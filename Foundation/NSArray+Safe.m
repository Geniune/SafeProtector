//
//  NSArray+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSArray (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstance:objc_getClass("__NSPlaceholderArray") selector:@selector(initWithObjects:count:) withSwizzledSelector:@selector(safe_initWithObjects:count:)];
        
        [self exchangeInstance:objc_getClass("__NSArrayI") selector:@selector(objectAtIndex:)withSwizzledSelector:@selector(safe_objectAtIndexI:)];
        [self exchangeInstance:objc_getClass("__NSArrayI") selector:@selector(objectAtIndexedSubscript:) withSwizzledSelector:@selector(safe_objectAtIndexedSubscriptI:)];
        
        [self exchangeInstance:objc_getClass("__NSArray0") selector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safe_objectAtIndex0:)];
        
        [self exchangeInstance:objc_getClass("__NSSingleObjectArrayI") selector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safe_objectAtIndexSI:)];
    });
}

- (instancetype)safe_initWithObjects:(id _Nonnull const [])objects count:(NSUInteger)count{
    
    id instance = nil;
    @try {
        instance = [self safe_initWithObjects:objects count:count];
    } @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception, LSSafeProtectorCrashTypeNSArray);
        //错误数据处理，将nil去掉，得到新的数组，再初始化
        NSInteger newObjectsIndex = 0;
        id newObjects[count];
        
        for(int i = 0;i < count;i ++){
            if(objects[i]){
                newObjects[newObjectsIndex] = objects[i];
                newObjectsIndex ++;
            }
        }
        instance = [self safe_initWithObjects:newObjects count:newObjectsIndex];
    } @finally {
        return instance;
    }
}

- (instancetype)safe_objectAtIndexI:(NSUInteger)index{
    
    id object = nil;
    @try {
        object = [self safe_objectAtIndexI:index];
    } @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSArray);
    } @finally {
        return object;
    }
}

- (instancetype)safe_objectAtIndexedSubscriptI:(NSUInteger)index{
    
    id object = nil;
    @try {
        object = [self safe_objectAtIndexedSubscriptI:index];
    } @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSArray);
    } @finally {
        return object;
    }
}

- (id)safe_objectAtIndex0:(NSUInteger)index{
    
    id object = nil;
    @try {
        object = [self safe_objectAtIndex0:index];
    } @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSArray);
    } @finally {
        return object;
    }
}

- (id)safe_objectAtIndexSI:(NSUInteger)index{
    
    id object = nil;
    @try {
        object = [self safe_objectAtIndexSI:index];
    } @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSArray);
    } @finally {
        return object;
    }
}

- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level{
    
    NSMutableString *stringM = [NSMutableString string];
    [stringM appendString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [stringM appendFormat:@"\t%@,\n",obj];
    }];
    
    [stringM appendString:@")\n"];
    
    return stringM;
}


@end
