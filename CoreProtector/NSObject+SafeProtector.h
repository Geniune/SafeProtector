//
//  NSObject+SafeProtector.h
//  TestExample
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SafeProtectorDefine.h"

#define LSKVOSafeLog(fmt, ...) safe_KVOCustomLog(fmt,##__VA_ARGS__)

@interface NSObject (SafeProtector)

@end

@interface LSSafeProtector : NSObject

+ (void)safe_logCrashWithException:(NSException *)exception crashType:(LSSafeProtectorCrashType)crashType;
//自定义log函数
void safe_KVOCustomLog(NSString *format,...);

@end
