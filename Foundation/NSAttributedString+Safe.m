//
//  NSAttributedString+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSAttributedString+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSAttributedString (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstance:NSClassFromString(@"NSConcreteAttributedString") selector:@selector(initWithString:) withSwizzledSelector:@selector(safe_initWithString:)];
        [self exchangeInstance:NSClassFromString(@"NSConcreteAttributedString") selector:@selector(initWithString:attributes:) withSwizzledSelector:@selector(safe_initWithString:attributes:)];
        [self exchangeInstance:NSClassFromString(@"NSConcreteAttributedString") selector:@selector(initWithAttributedString:) withSwizzledSelector:@selector(safe_initWithAttributedString:)];
    });
}

- (instancetype)safe_initWithString:(NSString *)str {
    id object = nil;
    @try {
        object = [self safe_initWithString:str];
    }
    @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSAttributedString);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSAttributedString);
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
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSAttributedString);
    }
    @finally {
        return object;
    }
}


@end
