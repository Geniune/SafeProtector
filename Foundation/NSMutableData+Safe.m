//
//  NSMutableData+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSMutableData+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSMutableData (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstance:NSClassFromString(@"NSConcreteMutableData") selector:@selector(subdataWithRange:) withSwizzledSelector:@selector(safe_subdataWithRangeMutableConcreteData:)];
        [self exchangeInstance:NSClassFromString(@"NSConcreteMutableData") selector:@selector(rangeOfData:options:range:) withSwizzledSelector:@selector(safe_rangeOfDataMutableConcreteData:options:range:)];
        [self exchangeInstance:NSClassFromString(@"NSConcreteMutableData") selector:@selector(resetBytesInRange:) withSwizzledSelector:@selector(safe_resetBytesInRange:)];
        [self exchangeInstance:NSClassFromString(@"NSConcreteMutableData") selector:@selector(replaceBytesInRange:withBytes:) withSwizzledSelector:@selector(safe_replaceBytesInRange:withBytes:)];
        [self exchangeInstance:NSClassFromString(@"NSConcreteMutableData") selector:@selector(replaceBytesInRange:withBytes:length:) withSwizzledSelector:@selector(safe_replaceBytesInRange:withBytes:length:)];
    });
}

-(NSData *)safe_subdataWithRangeMutableConcreteData:(NSRange)range
{
    id object=nil;
    @try {
        object =  [self safe_subdataWithRangeMutableConcreteData:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableData);
    }
    @finally {
        return object;
    }
}

-(NSRange)safe_rangeOfDataMutableConcreteData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    NSRange object;
    @try {
        object =  [self safe_rangeOfDataMutableConcreteData:dataToFind options:mask range:searchRange];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableData);
    }
    @finally {
        return object;
    }
}

- (void)safe_resetBytesInRange:(NSRange)range
{
    @try {
        [self safe_resetBytesInRange:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableData);
    }
    @finally {
    }
}


- (void)safe_replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes
{
    @try {
        [self safe_replaceBytesInRange:range withBytes:bytes];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableData);
    }
    @finally {
    }
}

- (void)safe_replaceBytesInRange:(NSRange)range withBytes:(const void *)replacementBytes length:(NSUInteger)replacementLength
{
    @try {
        [self safe_replaceBytesInRange:range withBytes:replacementBytes length:replacementLength];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableData);
    }
    @finally {
    }
}

@end
