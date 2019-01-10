//
//  NSObject+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSObject+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@interface LSSafeProxy:NSObject

@property (nonatomic,strong) NSException *exception;
@property (nonatomic,weak) id safe_object;

@end

@implementation LSSafeProxy

- (void)safe_crashLog{
    
}

@end

@implementation NSObject (Safe)

+ (void)load{
    
    if([NSStringFromClass([NSObject class]) isEqualToString:@"NSObject"]){
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            [self exchangeInstance:[self class] selector:@selector(methodSignatureForSelector:) withSwizzledSelector:@selector(safe_methodSignatureForSelector:)];
            [self exchangeInstance:[self class] selector:@selector(forwardInvocation:) withSwizzledSelector:@selector(safe_forwardInvocation:)];
        });
    }
}

- (NSMethodSignature *)safe_methodSignatureForSelector:(SEL)aSelector{
    
    NSMethodSignature *ms = [self safe_methodSignatureForSelector:aSelector];
    if ([self respondsToSelector:aSelector] || ms){
        return ms;
    }
    else{
        return [LSSafeProxy instanceMethodSignatureForSelector:@selector(safe_crashLog)];
    }
}

- (void)safe_forwardInvocation:(NSInvocation *)anInvocation{
    
    @try {
        [self safe_forwardInvocation:anInvocation];
    } @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeSelector);
    } @finally {
    }
}

@end
