//
//  NSOrderedSet+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSOrderedSet+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSOrderedSet (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [self exchangeInstance:NSClassFromString(@"__NSPlaceholderOrderedSet") selector:@selector(initWithObjects:count:) withSwizzledSelector:@selector(safe_initWithObjects:count:)];
        [self exchangeInstance:NSClassFromString(@"__NSPlaceholderOrderedSet") selector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safe_objectAtIndex:)];
    });
}

- (instancetype)safe_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    
    id instance = nil;
    @try {
        instance = [self safe_initWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSOrderedSet);
        
        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id   newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self safe_initWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}

- (id)safe_objectAtIndex:(NSUInteger)idx{
    
    id object=nil;
    @try {
        object = [self safe_objectAtIndex:idx];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSOrderedSet);
    }
    @finally {
        return object;
    }
}

@end
