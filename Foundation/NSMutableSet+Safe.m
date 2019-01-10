//
//  NSMutableSet+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSMutableSet+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSMutableSet (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstance:NSClassFromString(@"__NSSetM") selector:@selector(addObject:) withSwizzledSelector:@selector(safe_addObject:)];
        [self exchangeInstance:NSClassFromString(@"__NSSetM") selector:@selector(removeObject:) withSwizzledSelector:@selector(safe_removeObject:)];
    });
}

- (void)safe_addObject:(id)object{
    
    @try {
        [self safe_addObject:object];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableSet);
    }
    @finally {
    }
}

- (void)safe_removeObject:(id)object{
    
    @try {
        [self safe_removeObject:object];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableSet);
    }
    @finally {
    }
}

@end
