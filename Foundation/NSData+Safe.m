//
//  NSData+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSData+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSData (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstance:NSClassFromString(@"NSConcreteData") selector:@selector(subdataWithRange:) withSwizzledSelector:@selector(safe_subdataWithRangeConcreteData:)];
        [self exchangeInstance:NSClassFromString(@"NSConcreteData") selector:@selector(rangeOfData:options:range:) withSwizzledSelector:@selector(safe_rangeOfDataConcreteData:options:range:)];
        
        [self exchangeInstance:NSClassFromString(@"_NSZeroData") selector:@selector(subdataWithRange:) withSwizzledSelector:@selector(safe_subdataWithRangeZeroData:)];
        [self exchangeInstance:NSClassFromString(@"_NSZeroData") selector:@selector(rangeOfData:options:range:) withSwizzledSelector:@selector(safe_rangeOfDataZeroData:options:range:)];
        
        [self exchangeInstance:NSClassFromString(@"_NSInlineData") selector:@selector(subdataWithRange:) withSwizzledSelector:@selector(safe_subdataWithRangeInlineData:)];
        [self exchangeInstance:NSClassFromString(@"_NSInlineData") selector:@selector(rangeOfData:options:range:) withSwizzledSelector:@selector(safe_rangeOfDataInlineData:options:range:)];
        
        [self exchangeInstance:NSClassFromString(@"__NSCFData") selector:@selector(subdataWithRange:) withSwizzledSelector:@selector(safe_subdataWithRangeCFData:)];
        [self exchangeInstance:NSClassFromString(@"__NSCFData") selector:@selector(rangeOfData:options:range:) withSwizzledSelector:@selector(safe_rangeOfDataCFData:options:range:)];
    });
}

-(NSData *)safe_subdataWithRangeConcreteData:(NSRange)range
{
    id object=nil;
    @try {
        object =  [self safe_subdataWithRangeConcreteData:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSData);
    }
    @finally {
        return object;
    }
}


-(NSData *)safe_subdataWithRangeZeroData:(NSRange)range
{
    id object=nil;
    @try {
        object =  [self safe_subdataWithRangeZeroData:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSData);
    }
    @finally {
        return object;
    }
}
-(NSData *)safe_subdataWithRangeInlineData:(NSRange)range
{
    id object=nil;
    @try {
        object =  [self safe_subdataWithRangeInlineData:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSData);
    }
    @finally {
        return object;
    }
}
-(NSData *)safe_subdataWithRangeCFData:(NSRange)range
{
    id object=nil;
    @try {
        object =  [self safe_subdataWithRangeCFData:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSData);
    }
    @finally {
        return object;
    }
}




-(NSRange)safe_rangeOfDataConcreteData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    NSRange object;
    @try {
        object =  [self safe_rangeOfDataConcreteData:dataToFind options:mask range:searchRange];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSData);
    }
    @finally {
        return object;
    }
}


-(NSRange)safe_rangeOfDataInlineData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    NSRange object;
    @try {
        object =  [self safe_rangeOfDataInlineData:dataToFind options:mask range:searchRange];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSData);
    }
    @finally {
        return object;
    }
}


-(NSRange)safe_rangeOfDataZeroData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    NSRange object;
    @try {
        object =  [self safe_rangeOfDataZeroData:dataToFind options:mask range:searchRange];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSData);
    }
    @finally {
        return object;
    }
}


-(NSRange)safe_rangeOfDataCFData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    NSRange object;
    @try {
        object =  [self safe_rangeOfDataCFData:dataToFind options:mask range:searchRange];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSData);
    }
    @finally {
        return object;
    }
}

@end
