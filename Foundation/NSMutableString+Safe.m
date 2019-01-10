//
//  NSMutableString+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSMutableString+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSMutableString (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class CFStringClass=NSClassFromString(@"__NSCFString");
        
        [self exchangeInstance:NSClassFromString(@"NSPlaceholderMutableString") selector:@selector(initWithString:) withSwizzledSelector:@selector(safe_initWithString:)];
        
        [self exchangeInstance:CFStringClass selector:@selector(hasPrefix:) withSwizzledSelector:@selector(safe_hasPrefix:)];
        [self exchangeInstance:CFStringClass selector:@selector(hasSuffix:) withSwizzledSelector:@selector(safe_hasSuffix:)];
        [self exchangeInstance:CFStringClass selector:@selector(substringFromIndex:) withSwizzledSelector:@selector(safe_substringFromIndex:)];
        [self exchangeInstance:CFStringClass selector:@selector(substringToIndex:) withSwizzledSelector:@selector(safe_substringToIndex:)];
        [self exchangeInstance:CFStringClass selector:@selector(substringWithRange:) withSwizzledSelector:@selector(safe_substringWithRange:)];
        [self exchangeInstance:CFStringClass selector:@selector(characterAtIndex:) withSwizzledSelector:@selector(safe_characterAtIndex:)];
        [self exchangeInstance:CFStringClass selector:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) withSwizzledSelector:@selector(safe_stringByReplacingOccurrencesOfString:withString:options:range:)];
        [self exchangeInstance:CFStringClass selector:@selector(stringByReplacingCharactersInRange:withString:) withSwizzledSelector:@selector(safe_stringByReplacingCharactersInRange:withString:)];
    
        [self exchangeInstance:CFStringClass selector:@selector(replaceCharactersInRange:withString:) withSwizzledSelector:@selector(safe_replaceCharactersInRange:withString:)];
        [self exchangeInstance:CFStringClass selector:@selector(replaceOccurrencesOfString:withString:options:range:) withSwizzledSelector:@selector(safe_replaceOccurrencesOfString:withString:options:range:)];
        [self exchangeInstance:CFStringClass selector:@selector(insertString:atIndex:) withSwizzledSelector:@selector(safe_insertString:atIndex:)];
        [self exchangeInstance:CFStringClass selector:@selector(deleteCharactersInRange:) withSwizzledSelector:@selector(safe_deleteCharactersInRange:)];
        [self exchangeInstance:CFStringClass selector:@selector(appendString:) withSwizzledSelector:@selector(safe_appendString:)];
        [self exchangeInstance:CFStringClass selector:@selector(setString:) withSwizzledSelector:@selector(safe_setString:)];
    });
}

-(instancetype)safe_initWithString:(NSString *)aString
{
    id instance = nil;
    @try {
        instance = [self safe_initWithString:aString];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

#pragma mark - NSMutableString特有的

-(void)safe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString
{
    @try {
        [self safe_replaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
    }
    @finally {
    }
}


-(NSUInteger)safe_replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    NSUInteger index=0;
    @try {
        index= [self safe_replaceOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
    }
    @finally {
        return index;
    }
}



-(void)safe_insertString:(NSString *)aString atIndex:(NSUInteger)loc
{
    @try {
        [self safe_insertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
    }
    @finally {
    }
}


-(void)safe_deleteCharactersInRange:(NSRange)range
{
    @try {
        [self safe_deleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
    }
    @finally {
    }
}


-(void)safe_appendString:(NSString *)aString
{
    @try {
        [self safe_appendString:aString];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
    }
    @finally {
    }
}

-(void)safe_setString:(NSString *)aString
{
    @try {
        [self safe_setString:aString];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableString);
    }
    @finally {
    }
}


@end

