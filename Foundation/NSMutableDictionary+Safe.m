//
//  NSMutableDictionary+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSMutableDictionary (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstance:objc_getClass("__NSDictionaryM") selector:@selector(setObject:forKey:) withSwizzledSelector:@selector(safe_setObject:forKey:)];
        [self exchangeInstance:objc_getClass("__NSDictionaryM") selector:@selector(setObject:forKeyedSubscript:) withSwizzledSelector:@selector(safe_setObject:forKeyedSubscript:)];
        [self exchangeInstance:objc_getClass("__NSDictionaryM") selector:@selector(removeObjectForKey:) withSwizzledSelector:@selector(safe_removeObjectForKey:)];
        
        //__NSCFDictionary
        [self exchangeInstance:objc_getClass("__NSCFDictionary") selector:@selector(setObject:forKey:) withSwizzledSelector:@selector(safe_setObjectCFDictionary:forKey:)];
        [self exchangeInstance:objc_getClass("__NSCFDictionary") selector:@selector(removeObjectForKey:) withSwizzledSelector:@selector(safe_removeObjectForKeyCFDictionary:)];
    });
}

#pragma mark - __NSCFDictionary
- (void)safe_setObjectCFDictionary:(id)anObject forKey:(id<NSCopying>)aKey {
    
    @try {
        [self safe_setObjectCFDictionary:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableDictionary);
    }
    @finally {
    }
}

- (void)safe_removeObjectForKeyCFDictionary:(id)aKey {
    
    @try {
        [self safe_removeObjectForKeyCFDictionary:aKey];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableDictionary);
    }
    @finally {
    }
}

#pragma mark - __NSDictionaryM
- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    @try {
        [self safe_setObject:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableDictionary);
    }
    @finally {
    }
}

- (void)safe_setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)aKey {
    
    @try {
        [self safe_setObject:anObject forKeyedSubscript:aKey];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableDictionary);
    }
    @finally {
    }
}

- (void)safe_removeObjectForKey:(id)aKey {
    
    @try {
        [self safe_removeObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableDictionary);
    }
    @finally {
    }
}

@end
