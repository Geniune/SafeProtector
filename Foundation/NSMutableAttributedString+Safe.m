//
//  NSMutableAttributedString+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSMutableAttributedString+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSMutableAttributedString (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class ConcreteClass = NSClassFromString(@"NSConcreteMutableAttributedString");
        
        [self exchangeInstance:ConcreteClass selector:@selector(initWithString:) withSwizzledSelector:@selector(safe_initWithString:)];
        [self exchangeInstance:ConcreteClass selector:@selector(initWithString:attributes:) withSwizzledSelector:@selector(safe_initWithString:attributes:)];
        [self exchangeInstance:ConcreteClass selector:@selector(initWithAttributedString:) withSwizzledSelector:@selector(safe_initWithAttributedString:)];
        
        //以下为NSMutableAttributedString特有方法
        //4.replaceCharactersInRange:withString:
        [self exchangeInstance:ConcreteClass selector:@selector(replaceCharactersInRange:withString:) withSwizzledSelector:@selector(safe_replaceCharactersInRange:withString:)];
        //5.setAttributes:range:
        [self exchangeInstance:ConcreteClass selector:@selector(setAttributes:range:) withSwizzledSelector:@selector(safe_setAttributes:range:)];
        //6.addAttribute:value:range:
        [self exchangeInstance:ConcreteClass selector:@selector(addAttribute:value:range:) withSwizzledSelector:@selector(safe_addAttribute:value:range:)];
        //7.addAttributes:range:
        [self exchangeInstance:ConcreteClass selector:@selector(addAttributes:range:) withSwizzledSelector:@selector(safe_addAttributes:range:)];
        //8.removeAttribute:range:
        [self exchangeInstance:ConcreteClass selector:@selector(removeAttribute:range:) withSwizzledSelector:@selector(safe_removeAttribute:range:)];
        //9.replaceCharactersInRange:withAttributedString:
        [self exchangeInstance:ConcreteClass selector:@selector(replaceCharactersInRange:withAttributedString:) withSwizzledSelector:@selector(safe_replaceCharactersInRange:withAttributedString:)];
        //10.insertAttributedString:atIndex:
        [self exchangeInstance:ConcreteClass selector:@selector(insertAttributedString:atIndex:) withSwizzledSelector:@selector(safe_insertAttributedString:atIndex:)];
        //11.appendAttributedString:
        [self exchangeInstance:ConcreteClass selector:@selector(appendAttributedString:) withSwizzledSelector:@selector(safe_appendAttributedString:)];
        //12.deleteCharactersInRange:
        [self exchangeInstance:ConcreteClass selector:@selector(deleteCharactersInRange:) withSwizzledSelector:@selector(safe_deleteCharactersInRange:)];
        //13.setAttributedString:
        [self exchangeInstance:ConcreteClass selector:@selector(setAttributedString:) withSwizzledSelector:@selector(safe_setAttributedString:)];

    });
}

- (instancetype)safe_initWithString:(NSString *)str {
    id object = nil;
    @try {
        object = [self safe_initWithString:str];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
    }
    @finally {
        return object;
    }
}

#pragma mark - initWithAttributedString
- (instancetype)safe_initWithAttributedString:(NSAttributedString *)attrStr {
    id object = nil;
    
    @try {
        object = [self safe_initWithAttributedString:attrStr];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
    }
    @finally {
        return object;
    }
}

#pragma mark - initWithString:attributes:
- (instancetype)safe_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    id object = nil;
    
    @try {
        object = [self safe_initWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
    }
    @finally {
        return object;
    }
}


-(void)safe_replaceCharactersInRange:(NSRange)range withString:(nonnull NSString *)aString
{
    @try {
        [self safe_replaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
    }
    @finally {
    }
}

-(void)safe_setAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range
{
    @try {
        [self safe_setAttributes:attrs range:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
    }
    @finally {
    }
}

-(void)safe_addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range
{
    @try {
        [self safe_addAttribute:name value:value range:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
    }
    @finally {
    }
}
-(void)safe_addAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range
{
    @try {
        [self safe_addAttributes:attrs range:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
    }
    @finally {
    }
}

-(void)safe_removeAttribute:(NSAttributedStringKey)name range:(NSRange)range
{
    @try {
        [self safe_removeAttribute:name range:range];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
    }
    @finally {
    }
}

-(void)safe_replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString
{
    @try {
        [self safe_replaceCharactersInRange:range withAttributedString:attrString];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
    }
    @finally {
    }
}


-(void)safe_insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc
{
    @try {
        [self safe_insertAttributedString:attrString atIndex:loc];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
    }
    @finally {
    }
}


-(void)safe_appendAttributedString:(NSAttributedString *)attrString
{
    @try {
        [self safe_appendAttributedString:attrString];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
    }
    @finally {
    }
}

-(void)safe_setAttributedString:(NSAttributedString *)attrString
{
    @try {
        [self safe_setAttributedString:attrString];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableAttributedString);
    }
    @finally {
    }
}


@end

