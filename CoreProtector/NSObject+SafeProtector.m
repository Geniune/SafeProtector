//
//  NSObject+SafeProtector.m
//  TestExample
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSObject+SafeProtector.h"

static  LSSafeProtectorBlock lsSafeProtectorBlock;

@implementation NSObject (SafeProtector)

@end

@implementation LSSafeProtector

+ (void)safe_logCrashWithException:(NSException *)exception crashType:(LSSafeProtectorCrashType)crashType
{
    // 堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组
    NSString *mainMessage = [self safe_getMainCallStackSymbolMessageWithCallStackSymbolArray: callStackSymbolsArr index:2 first:YES];
    
    if (mainMessage == nil) {
        mainMessage = @"崩溃方法定位失败,请您查看函数调用栈来查找crash原因";
    }
    
    NSString *crashName = [NSString stringWithFormat:@"\t\t[Crash Type]: %@",exception.name];
    
    NSString *crashReason = [NSString stringWithFormat:@"\t\t[Crash Reason]: %@",exception.reason];;
    NSString *crashLocation = [NSString stringWithFormat:@"\t\t[Crash Location]: %@",mainMessage];
    
    NSString *fullMessage = [NSString stringWithFormat:@"\n------------------------------------  Crash START -------------------------------------\n%@\n%@\n%@\n函数堆栈:\n%@\n------------------------------------   Crash END  -----------------------------------------", crashName, crashReason, crashLocation, exception.callStackSymbols];
    
    NSMutableDictionary *userInfo=[NSMutableDictionary dictionary];
    userInfo[@"callStackSymbols"]=[NSString stringWithFormat:@"%@",exception.callStackSymbols];
    userInfo[@"location"]=mainMessage;
    NSException *newException = [NSException exceptionWithName:exception.name reason:exception.reason userInfo:userInfo];
    if (lsSafeProtectorBlock) {
        lsSafeProtectorBlock(newException,crashType);
    }

    DebugLog(@"%@", fullMessage);
    assert(NO&&"检测到崩溃，详情请查看上面信息");
    
    //这里可以将NSException写入log文件或上传至Bugly等平台，具体如何选择请自行实现
    
}

#pragma mark -   获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来
+ (NSString *)safe_getMainCallStackSymbolMessageWithCallStackSymbolArray:(NSArray *)callStackSymbolArray index:(NSInteger)index first:(BOOL)first
{
    NSString *  callStackSymbolString;
    if (callStackSymbolArray.count<=0) {
        return nil;
    }
    if (index<callStackSymbolArray.count) {
        callStackSymbolString=callStackSymbolArray[index];
    }

    //mainCallStackSymbolMsg 的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    [regularExp enumerateMatchesInString:callStackSymbolString options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbolString.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (result) {
            mainCallStackSymbolMsg = [callStackSymbolString substringWithRange:result.range];
            *stop = YES;
        }
    }];
    
    if (index==0) {
        return mainCallStackSymbolMsg;
    }
    if (mainCallStackSymbolMsg==nil) {
        NSInteger newIndex=0;
        if (first) {
            newIndex=callStackSymbolArray.count-1;
        }else{
            newIndex=index-1;
        }
        mainCallStackSymbolMsg = [self safe_getMainCallStackSymbolMessageWithCallStackSymbolArray:callStackSymbolArray index:newIndex first:NO];
    }
    return mainCallStackSymbolMsg;
}

void safe_KVOCustomLog(NSString *format,...){
    
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    NSString *strFormat = [NSString stringWithFormat:@"%@",string];
    DebugLog(strFormat, args);
    va_end(args);
}


@end
