//
//  NSCache+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSCache+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSCache (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstance:NSClassFromString(@"NSCache") selector:@selector(setObject:forKey:) withSwizzledSelector:@selector(safe_setObject:forKey:)];
        [self exchangeInstance:NSClassFromString(@"NSCache") selector:@selector(setObject:forKey:cost:) withSwizzledSelector:@selector(safe_setObject:forKey:cost:)];
    });
}

- (void)safe_setObject:(id)obj forKey:(id)key{
    
    if(key&&obj){
        [self safe_setObject:obj forKey:key];
    }else{
        NSString *reason=[NSString stringWithFormat:@"NSCache %@ key and value can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSCache);
    }
}

- (void)safe_setObject:(id)obj forKey:(id)key cost:(NSUInteger)g{
    
    if(key&&obj){
        [self safe_setObject:obj forKey:key cost:g];
    }else{
        NSString *reason=[NSString stringWithFormat:@"NSCache %@ key and value can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSCache);
    }
}

@end
