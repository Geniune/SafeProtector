//
//  NSObject+SafeSwizzle.m
//  TestExample
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSObject+SafeSwizzle.h"


#if TARGET_OS_IPHONE
#import <objc/runtime.h>
#import <objc/message.h>
#else
#import <objc/objc-class.h>
#endif

#define SetNSErrorFor(FUNC, ERROR_VAR, FORMAT,...)    \
if (ERROR_VAR) {    \
NSString *errStr = [NSString stringWithFormat:@"%s: " FORMAT,FUNC,##__VA_ARGS__]; \
*ERROR_VAR = [NSError errorWithDomain:@"NSCocoaErrorDomain" \
code:-1    \
userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]]; \
}
#define SetNSError(ERROR_VAR, FORMAT,...) SetNSErrorFor(__func__, ERROR_VAR, FORMAT, ##__VA_ARGS__)

#if OBJC_API_VERSION >= 2
#define GetClass(obj)    object_getClass(obj)
#else
#define GetClass(obj)    (obj ? obj->isa : Nil)
#endif

@implementation NSObject (SafeSwizzle)

+ (BOOL)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector {
    
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    if(!originalMethod || !swizzledMethod){
        
        return NO;
    }
    // 若已经存在，则添加会失败
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    // 若原来的方法并不存在，则添加即可
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    return YES;
}

+ (BOOL)exchangeInstance:(Class)class selector:(SEL)originalSelector withSwizzledSelector: (SEL)swizzledSelector{
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    if(!originalMethod || !swizzledMethod){
        
        return NO;
    }
    // 若已经存在，则添加会失败
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    // 若原来的方法并不存在，则添加即可
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    return YES;
}

+ (BOOL)swizzleMethod:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector error:(NSError**)error{
#if OBJC_API_VERSION >= 2
    Method origMethod = class_getInstanceMethod(self, originalSelector);
    if (!origMethod) {
#if TARGET_OS_IPHONE
        SetNSError(error, @"original method %@ not found for class %@", NSStringFromSelector(originalSelector), [self class]);
#else
        SetNSError(error, @"original method %@ not found for class %@", NSStringFromSelector(originalSelector), [self className]);
#endif
        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(self, swizzledSelector);
    if (!altMethod) {
#if TARGET_OS_IPHONE
        SetNSError(error, @"alternate method %@ not found for class %@", NSStringFromSelector(swizzledSelector), [self class]);
#else
        SetNSError(error, @"alternate method %@ not found for class %@", NSStringFromSelector(swizzledSelector), [self className]);
#endif
        return NO;
    }
    
    class_addMethod(self,
                    originalSelector,
                    class_getMethodImplementation(self, originalSelector),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    swizzledSelector,
                    class_getMethodImplementation(self, swizzledSelector),
                    method_getTypeEncoding(altMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSelector), class_getInstanceMethod(self, swizzledSelector));
    return YES;
#else
    //    Scan for non-inherited methods.
    Method directOriginalMethod = NULL, directAlternateMethod = NULL;
    
    void *iterator = NULL;
    struct objc_method_list *mlist = class_nextMethodList(self, &iterator);
    while (mlist) {
        int method_index = 0;
        for (; method_index < mlist->method_count; method_index++) {
            if (mlist->method_list[method_index].method_name == originalSelector) {
                assert(!directOriginalMethod);
                directOriginalMethod = &mlist->method_list[method_index];
            }
            if (mlist->method_list[method_index].method_name == swizzledSelector) {
                assert(!directAlternateMethod);
                directAlternateMethod = &mlist->method_list[method_index];
            }
        }
        mlist = class_nextMethodList(self, &iterator);
    }
    
    //    If either method is inherited, copy it up to the target class to make it non-inherited.
    if (!directOriginalMethod || !directAlternateMethod) {
        Method inheritedOriginalMethod = NULL, inheritedAlternateMethod = NULL;
        if (!directOriginalMethod) {
            inheritedOriginalMethod = class_getInstanceMethod(self, originalSelector);
            if (!inheritedOriginalMethod) {
#if TARGET_OS_IPHONE
                SetNSError(error, @"original method %@ not found for class %@", NSStringFromSelector(originalSelector), [self class]);
#else
                SetNSError(error, @"original method %@ not found for class %@", NSStringFromSelector(originalSelector), [self className]);
#endif
                return NO;
            }
        }
        if (!directAlternateMethod) {
            inheritedAlternateMethod = class_getInstanceMethod(self, swizzledSelector);
            if (!inheritedAlternateMethod) {
#if TARGET_OS_IPHONE
                SetNSError(error, @"alternate method %@ not found for class %@", NSStringFromSelector(swizzledSelector), [self class]);
#else
                SetNSError(error, @"alternate method %@ not found for class %@", NSStringFromSelector(swizzledSelector), [self className]);
#endif
                return NO;
            }
        }
        
        int hoisted_method_count = !directOriginalMethod && !directAlternateMethod ? 2 : 1;
        struct objc_method_list *hoisted_method_list = malloc(sizeof(struct objc_method_list) + (sizeof(struct objc_method)*(hoisted_method_count-1)));
        hoisted_method_list->obsolete = NULL;    // soothe valgrind - apparently ObjC runtime accesses this value and it shows as uninitialized in valgrind
        hoisted_method_list->method_count = hoisted_method_count;
        Method hoisted_method = hoisted_method_list->method_list;
        
        if (!directOriginalMethod) {
            bcopy(inheritedOriginalMethod, hoisted_method, sizeof(struct objc_method));
            directOriginalMethod = hoisted_method++;
        }
        if (!directAlternateMethod) {
            bcopy(inheritedAlternateMethod, hoisted_method, sizeof(struct objc_method));
            directAlternateMethod = hoisted_method;
        }
        class_addMethods(self, hoisted_method_list);
    }
    
    //    Swizzle.
    IMP temp = directOriginalMethod->method_imp;
    directOriginalMethod->method_imp = directAlternateMethod->method_imp;
    directAlternateMethod->method_imp = temp;
    
    return YES;
#endif
}

+ (BOOL)swizzleClassMethod:(SEL)originalSelector withClassMethod:(SEL)swizzledSelector error:(NSError**)error {
    return [GetClass((id)self) swizzleMethod:originalSelector withSwizzledSelector:swizzledSelector error:error];
}

+ (NSInvocation*)swizzleMethod:(SEL)originalSelector withBlock:(id)block error:(NSError**)error {
    
    IMP blockIMP = imp_implementationWithBlock(block);
    NSString *blockSelectorString = [NSString stringWithFormat:@"_jr_block_%@_%p", NSStringFromSelector(originalSelector), block];
    SEL blockSel = sel_registerName([blockSelectorString cStringUsingEncoding:NSUTF8StringEncoding]);
    Method origSelMethod = class_getInstanceMethod(self, originalSelector);
    const char* origSelMethodArgs = method_getTypeEncoding(origSelMethod);
    class_addMethod(self, blockSel, blockIMP, origSelMethodArgs);
    
    NSMethodSignature *origSig = [NSMethodSignature signatureWithObjCTypes:origSelMethodArgs];
    NSInvocation *origInvocation = [NSInvocation invocationWithMethodSignature:origSig];
    origInvocation.selector = blockSel;
    
    [self swizzleMethod:originalSelector withBlock:block error:nil];
    
    return origInvocation;
}

+ (NSInvocation*)swizzleClassMethod:(SEL)originalSelector withBlock:(id)block error:(NSError**)error {
    
    NSInvocation *invocation = [GetClass((id)self) swizzleMethod:originalSelector withBlock:block error:error];
    invocation.target = self;
    
    return invocation;
}

@end
