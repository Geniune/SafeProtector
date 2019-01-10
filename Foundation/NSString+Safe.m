//
//  NSString+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSString+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSString (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstance:NSClassFromString(@"NSPlaceholderString") selector:@selector(initWithString:) withSwizzledSelector:@selector(safe_initWithString:)];
        
        [self safe_changeAllMethod:NSClassFromString(@"__NSCFConstantString")];
        [self safe_changeAllMethod:NSClassFromString(@"NSTaggedPointerString")];
    });
}

+ (void)safe_changeAllMethod:(Class)class{
    
    //hasPrefix
    [self exchangeInstance:class selector:@selector(hasPrefix:) withSwizzledSelector:@selector(safe_hasPrefix:)];
    
    //hasSuffix
    [self exchangeInstance:class selector:@selector(hasSuffix:) withSwizzledSelector:@selector(safe_hasSuffix:)];
    
    //substringFromIndex
    [self exchangeInstance:class selector:@selector(substringFromIndex:) withSwizzledSelector:@selector(safe_substringFromIndex:)];
    
    //substringToIndex
    [self exchangeInstance:class selector:@selector(substringToIndex:) withSwizzledSelector:@selector(safe_substringToIndex:)];
    
    //substringWithRange
    [self exchangeInstance:class selector:@selector(substringWithRange:) withSwizzledSelector:@selector(safe_substringWithRange:)];
    
    //characterAtIndex
    [self exchangeInstance:class selector:@selector(characterAtIndex:) withSwizzledSelector:@selector(safe_characterAtIndex:)];
    
    //stringByReplacingOccurrencesOfString:withString:options:range:
    [self exchangeInstance:class selector:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) withSwizzledSelector:@selector(safe_stringByReplacingOccurrencesOfString:withString:options:range:)];
    
    //stringByReplacingCharactersInRange:withString:
    [self exchangeInstance:class selector:@selector(stringByReplacingCharactersInRange:withString:) withSwizzledSelector:@selector(safe_stringByReplacingCharactersInRange:withString:)];
}

- (instancetype)safe_initWithString:(NSString *)aString{
    
    id instance = nil;
    @try {
        instance = [self safe_initWithString:aString];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSStirng);
    }
    @finally {
        return instance;
    }
}

-(BOOL)safe_hasPrefix:(NSString *)str
{
    BOOL has = NO;
    @try {
        has = [self safe_hasPrefix:str];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSStirng);
    }
    @finally {
        return has;
    }
}

-(BOOL)safe_hasSuffix:(NSString *)str
{
    BOOL has = NO;
    @try {
        has = [self safe_hasSuffix:str];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSStirng);
    }
    @finally {
        return has;
    }
}

- (NSString *)safe_substringFromIndex:(NSUInteger)from {
    
    NSString *subString = nil;
    @try {
        subString = [self safe_substringFromIndex:from];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSStirng);
        subString = nil;
    }
    @finally {
        return subString;
    }
}

- (NSString *)safe_substringToIndex:(NSUInteger)index {
    
    NSString *subString = nil;
    
    @try {
        subString = [self safe_substringToIndex:index];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSStirng);
        subString = nil;
    }
    @finally {
        return subString;
    }
}

- (NSString *)safe_substringWithRange:(NSRange)range {
    
    NSString *subString = nil;
    @try {
        subString = [self safe_substringWithRange:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSStirng);
        subString = nil;
    }
    @finally {
        return subString;
    }
}

- (unichar)safe_characterAtIndex:(NSUInteger)index {
    
    unichar characteristic;
    @try {
        characteristic = [self safe_characterAtIndex:index];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSStirng);
    }
    @finally {
        return characteristic;
    }
}


- (NSString *)safe_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self safe_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSStirng);
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}


- (NSString *)safe_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self safe_stringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSStirng);
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

@end
