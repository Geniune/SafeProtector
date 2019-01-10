//
//  NSUserDefaults+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSUserDefaults+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSUserDefaults (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstance:NSClassFromString(@"NSUserDefaults") selector:@selector(setObject:forKey:) withSwizzledSelector:@selector(safe_setObject:forKey:)];
        [self exchangeInstance:NSClassFromString(@"NSUserDefaults") selector:@selector(objectForKey:) withSwizzledSelector:@selector(safe_objectForKey:)];
        [self exchangeInstance:NSClassFromString(@"NSUserDefaults") selector:@selector(stringForKey:) withSwizzledSelector:@selector(safe_stringForKey:)];
        [self exchangeInstance:NSClassFromString(@"NSUserDefaults") selector:@selector(arrayForKey:) withSwizzledSelector:@selector(safe_arrayForKey:)];
        [self exchangeInstance:NSClassFromString(@"NSUserDefaults") selector:@selector(dataForKey:) withSwizzledSelector:@selector(safe_dataForKey:)];
        [self exchangeInstance:NSClassFromString(@"NSUserDefaults") selector:@selector(URLForKey:) withSwizzledSelector:@selector(safe_URLForKey:)];
        [self exchangeInstance:NSClassFromString(@"NSUserDefaults") selector:@selector(stringArrayForKey:) withSwizzledSelector:@selector(safe_stringArrayForKey:)];
        [self exchangeInstance:NSClassFromString(@"NSUserDefaults") selector:@selector(floatForKey:) withSwizzledSelector:@selector(safe_floatForKey:)];
        [self exchangeInstance:NSClassFromString(@"NSUserDefaults") selector:@selector(doubleForKey:) withSwizzledSelector:@selector(safe_doubleForKey:)];
        [self exchangeInstance:NSClassFromString(@"NSUserDefaults") selector:@selector(integerForKey:) withSwizzledSelector:@selector(safe_integerForKey:)];
        [self exchangeInstance:NSClassFromString(@"NSUserDefaults") selector:@selector(boolForKey:) withSwizzledSelector:@selector(safe_boolForKey:)];
    });
}

-(void)safe_setObject:(id)value forKey:(NSString *)defaultName
{
    if(!defaultName){
        //defaultName空才会崩溃
        NSString *reason=[NSString stringWithFormat:@"NSUserDefaults %@ key  can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSUserDefaults);
    }else{
        [self safe_setObject:value forKey:defaultName];
    }
}

-(id)safe_objectForKey:(NSString *)defaultName
{
    id obj=nil;
    if(defaultName){
        obj=[self safe_objectForKey:defaultName];
    }else{
        NSString *reason=[NSString stringWithFormat:@"NSUserDefaults %@ key can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSUserDefaults);
    }
    return obj;
}
-(NSString *)safe_stringForKey:(NSString *)defaultName
{
    id obj=nil;
    if(defaultName){
        obj=[self safe_stringForKey:defaultName];
    }else{
        NSString *reason=[NSString stringWithFormat:@"NSUserDefaults %@ key can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSUserDefaults);
    }
    return obj;
}
-(NSArray *)safe_arrayForKey:(NSString *)defaultName
{
    id obj=nil;
    if(defaultName){
        obj=[self safe_arrayForKey:defaultName];
    }else{
        NSString *reason=[NSString stringWithFormat:@"NSUserDefaults %@ key can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSUserDefaults);
    }
    return obj;
}
-(NSData *)safe_dataForKey:(NSString *)defaultName
{
    id obj=nil;
    if(defaultName){
        obj=[self safe_dataForKey:defaultName];
    }else{
        NSString *reason=[NSString stringWithFormat:@"NSUserDefaults %@ key can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSUserDefaults);
    }
    return obj;
}
-(NSURL *)safe_URLForKey:(NSString *)defaultName
{
    id obj=nil;
    if(defaultName){
        obj=[self safe_URLForKey:defaultName];
    }else{
        NSString *reason=[NSString stringWithFormat:@"NSUserDefaults %@ key can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSUserDefaults);
    }
    return obj;
}
-(NSArray<NSString *> *)safe_stringArrayForKey:(NSString *)defaultName
{
    id obj=nil;
    if(defaultName){
        obj=[self safe_stringArrayForKey:defaultName];
    }else{
        NSString *reason=[NSString stringWithFormat:@"NSUserDefaults %@ key can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSUserDefaults);
    }
    return obj;
}
-(float)safe_floatForKey:(NSString *)defaultName
{
    float obj=0;
    if(defaultName){
        obj=[self safe_floatForKey:defaultName];
    }else{
        NSString *reason=[NSString stringWithFormat:@"NSUserDefaults %@ key can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSUserDefaults);
    }
    return obj;
}

-(double)safe_doubleForKey:(NSString *)defaultName
{
    double obj=0;
    if(defaultName){
        obj=[self safe_doubleForKey:defaultName];
    }else{
        NSString *reason=[NSString stringWithFormat:@"NSUserDefaults %@ key can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSUserDefaults);
    }
    return obj;
}
-(NSInteger)safe_integerForKey:(NSString *)defaultName
{
    NSInteger obj=0;
    if(defaultName){
        obj=[self safe_integerForKey:defaultName];
    }else{
        NSString *reason=[NSString stringWithFormat:@"NSUserDefaults %@ key can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSUserDefaults);
    }
    return obj;
}


-(BOOL)safe_boolForKey:(NSString *)defaultName
{
    BOOL obj=NO;
    if(defaultName){
        obj=[self safe_boolForKey:defaultName];
    }else{
        NSString *reason=[NSString stringWithFormat:@"NSUserDefaults %@ key can`t be nil",NSStringFromSelector(_cmd)];
        NSException *exception=[NSException exceptionWithName:reason reason:reason userInfo:nil];
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSUserDefaults);
    }
    return obj;
}

@end
