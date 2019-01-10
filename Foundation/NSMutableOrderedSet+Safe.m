//
//  NSMutableOrderedSet+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSMutableOrderedSet+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSMutableOrderedSet (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
//        [self exchangeInstance:NSClassFromString(@"__NSOrderedSetM") selector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safe_objectAtIndex:)];
//        [self exchangeInstance:NSClassFromString(@"__NSOrderedSetM") selector:@selector(insertObject:atIndex:) withSwizzledSelector:@selector(safe_insertObject:atIndex:)];
//        [self exchangeInstance:NSClassFromString(@"__NSOrderedSetM") selector:@selector(removeObjectAtIndex:) withSwizzledSelector:@selector(safe_removeObjectAtIndex:)];
//        [self exchangeInstance:NSClassFromString(@"__NSOrderedSetM") selector:@selector(replaceObjectAtIndex:withObject:) withSwizzledSelector:@selector(safe_replaceObjectAtIndex:withObject:)];
//        [self exchangeInstance:NSClassFromString(@"__NSOrderedSetM") selector:@selector(addObject:) withSwizzledSelector:@selector(safe_addObject:)];
    });
}

-(id)safe_objectAtIndex:(NSUInteger)idx
{
    id object=nil;
    @try {
        object = [self safe_objectAtIndex:idx];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableOrderedSet);
    }
    @finally {
        return object;
    }
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    @try {
        [self safe_insertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableOrderedSet);
    }
    @finally {
        
    }
}

- (void)safe_removeObjectAtIndex:(NSUInteger)index
{
    @try {
        [self safe_removeObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableOrderedSet);
    }
    @finally {
        
    }
}


- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    
    @try {
        [self safe_replaceObjectAtIndex:index withObject:anObject];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableOrderedSet);
    }
    @finally {
        
    }
}

- (void)safe_addObject:(id)object{
    
    @try {
        [self safe_addObject:object];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableOrderedSet);
    }
    @finally {
        
    }
}

@end
