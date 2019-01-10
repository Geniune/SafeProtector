//
//  NSMutableArray+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSMutableArray (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safe_objectAtIndexM:)];
        if(@available(iOS 11.0, *)){
            [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(objectAtIndexedSubscript:) withSwizzledSelector:@selector(safe_objectAtIndexedSubscriptM:)];
        }
        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(insertObject:atIndex:) withSwizzledSelector:@selector(safe_insertObject:atIndex:)];
        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(removeObjectAtIndex:) withSwizzledSelector:@selector(safe_removeObjectAtIndex:)];
        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(removeObjectsInRange:) withSwizzledSelector:@selector(safe_removeObjectsInRange:)];
        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(replaceObjectAtIndex:withObject:) withSwizzledSelector:@selector(safe_replaceObjectAtIndex:withObject:)];
        [self exchangeInstance:objc_getClass("__NSArrayM") selector:@selector(replaceObjectsInRange:withObjectsFromArray:) withSwizzledSelector:@selector(safe_replaceObjectsInRange:withObjectsFromArray:)];
        
        // 下面为  __NSCFArray
        //因为11.0以上系统才会调用此方法，所以大于11.0才交换此方法
        if (@available(iOS 11.0, *)) {
            [self exchangeInstance:objc_getClass("__NSCFArray") selector:@selector(objectAtIndexedSubscript:) withSwizzledSelector:@selector(safe_objectAtIndexedSubscriptCFArray:)];
        }
        [self exchangeInstance:objc_getClass("__NSCFArray") selector:@selector(insertObject:atIndex:) withSwizzledSelector:@selector(safe_insertObjectCFArray:atIndex:)];
        [self exchangeInstance:objc_getClass("__NSCFArray") selector:@selector(removeObjectAtIndex:) withSwizzledSelector:@selector(safe_removeObjectAtIndexCFArray:)];
        [self exchangeInstance:objc_getClass("__NSCFArray") selector:@selector(removeObjectsInRange:)  withSwizzledSelector:@selector(safe_removeObjectsInRangeCFArray:)];
        [self exchangeInstance:objc_getClass("__NSCFArray") selector:@selector(replaceObjectAtIndex:withObject:) withSwizzledSelector:@selector(safe_replaceObjectAtIndexCFArray:withObject:)];
        [self exchangeInstance:objc_getClass("__NSCFArray") selector:@selector(replaceObjectsInRange:withObjectsFromArray:) withSwizzledSelector:@selector(safe_replaceObjectsInRangeCFArray:withObjectsFromArray:)];
    });
}

- (instancetype)safe_objectAtIndexM:(NSUInteger)index{
    
    id object = nil;
    @try {
        object = [self safe_objectAtIndexM:index];
    } @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSArray);
    } @finally {
        return object;
    }
}

#pragma mark - 以下为__NSCFArray
- (id)safe_objectAtIndexedSubscriptCFArray:(NSUInteger)index
{
    id object=nil;
    @try {
        object =  [self safe_objectAtIndexedSubscriptCFArray:index];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
    }
    @finally {
        return object;
    }
}
- (void)safe_insertObjectCFArray:(id)anObject atIndex:(NSUInteger)index
{
    @try {
        [self safe_insertObjectCFArray:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
    }
    @finally {
        
    }
}
- (void)safe_removeObjectAtIndexCFArray:(NSUInteger)index
{
    @try {
        [self safe_removeObjectAtIndexCFArray:index];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
    }
    @finally {
        
    }
}

- (void)safe_removeObjectsInRangeCFArray:(NSRange)range
{
    @try {
        [self safe_removeObjectsInRangeCFArray:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
    }
    @finally {
    }
}

- (void)safe_replaceObjectAtIndexCFArray:(NSUInteger)index withObject:(id)anObject
{
    @try {
        [self safe_replaceObjectAtIndexCFArray:index withObject:anObject];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
    }
    @finally {
        
    }
}
- (void)safe_replaceObjectsInRangeCFArray:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    @try {
        [self safe_replaceObjectsInRangeCFArray:range withObjectsFromArray:otherArray];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
    }
    @finally {
        
    }
}

#pragma mark - 以下为__NSArrayM
- (id)safe_objectAtIndexedSubscriptM:(NSUInteger)index
{
    id object=nil;
    @try {
        object =  [self safe_objectAtIndexedSubscriptM:index];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
    }
    @finally {
        
    }
}

-(void)safe_removeObjectsInRange:(NSRange)range
{
    @try {
        [self safe_removeObjectsInRange:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
    }
    @finally {
    }
}

- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    @try {
        [self safe_replaceObjectAtIndex:index withObject:anObject];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
    }
    @finally {
        
    }
}

- (void)safe_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    @try {
        [self safe_replaceObjectsInRange:range withObjectsFromArray:otherArray];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
    }
    @finally {
        
    }
}

@end
