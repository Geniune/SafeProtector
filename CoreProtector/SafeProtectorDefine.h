//
//  SafeProtectorDefine.h
//  TestExample
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#ifndef SafeProtectorDefine_h
#define SafeProtectorDefine_h
@class LSSafeProtector;

#define LSSafeProtectionCrashLog(exception,crash) [LSSafeProtector safe_logCrashWithException:exception crashType:crash]

//哪个类型的crash
typedef NS_OPTIONS(NSUInteger,LSSafeProtectorCrashType)
{
    LSSafeProtectorCrashTypeSelector                  = 1 << 0,
    LSSafeProtectorCrashTypeKVO                       = 1 << 1,
    LSSafeProtectorCrashTypeNSNotificationCenter      = 1 << 2,
    LSSafeProtectorCrashTypeNSUserDefaults            = 1 << 3,
    LSSafeProtectorCrashTypeNSCache                   = 1 << 4,
    
    LSSafeProtectorCrashTypeNSArray                   = 1 << 5,
    LSSafeProtectorCrashTypeNSMutableArray            = 1 << 6,
    
    LSSafeProtectorCrashTypeNSDictionary              = 1 << 7,
    LSSafeProtectorCrashTypeNSMutableDictionary       = 1 << 8,
    
    LSSafeProtectorCrashTypeNSStirng                  = 1 << 9,
    LSSafeProtectorCrashTypeNSMutableString           = 1 << 10,
    
    LSSafeProtectorCrashTypeNSAttributedString        = 1 << 11,
    LSSafeProtectorCrashTypeNSMutableAttributedString = 1 << 12,
    
    LSSafeProtectorCrashTypeNSSet                     = 1 << 13,
    LSSafeProtectorCrashTypeNSMutableSet              = 1 << 14,
    
    LSSafeProtectorCrashTypeNSData                    = 1 << 15,
    LSSafeProtectorCrashTypeNSMutableData             = 1 << 16,
    
    LSSafeProtectorCrashTypeNSOrderedSet              = 1 << 17,
    LSSafeProtectorCrashTypeNSMutableOrderedSet       = 1 << 18,
    
    LSSafeProtectorCrashTypeNSArrayContainer = LSSafeProtectorCrashTypeNSArray|LSSafeProtectorCrashTypeNSMutableArray,
    
    LSSafeProtectorCrashTypeNSDictionaryContainer = LSSafeProtectorCrashTypeNSDictionary|LSSafeProtectorCrashTypeNSMutableDictionary,
    
    LSSafeProtectorCrashTypeNSStringContainer = LSSafeProtectorCrashTypeNSStirng|LSSafeProtectorCrashTypeNSMutableString,
    
    LSSafeProtectorCrashTypeNSAttributedStringContainer = LSSafeProtectorCrashTypeNSAttributedString|LSSafeProtectorCrashTypeNSMutableAttributedString,
    
    LSSafeProtectorCrashTypeNSSetContainer = LSSafeProtectorCrashTypeNSSet|LSSafeProtectorCrashTypeNSMutableSet,
    
    LSSafeProtectorCrashTypeNSDataContainer = LSSafeProtectorCrashTypeNSData|LSSafeProtectorCrashTypeNSMutableData,
    
    LSSafeProtectorCrashTypeNSOrderedSetContainer = LSSafeProtectorCrashTypeNSOrderedSet|LSSafeProtectorCrashTypeNSMutableOrderedSet,
    
    LSSafeProtectorCrashTypeAll =
    //支持所有类型的crash
    LSSafeProtectorCrashTypeSelector
    |LSSafeProtectorCrashTypeKVO
    |LSSafeProtectorCrashTypeNSNotificationCenter
    |LSSafeProtectorCrashTypeNSUserDefaults
    |LSSafeProtectorCrashTypeNSCache
    |LSSafeProtectorCrashTypeNSArrayContainer
    |LSSafeProtectorCrashTypeNSDictionaryContainer
    |LSSafeProtectorCrashTypeNSStringContainer
    |LSSafeProtectorCrashTypeNSAttributedStringContainer
    |LSSafeProtectorCrashTypeNSSetContainer
    |LSSafeProtectorCrashTypeNSDataContainer
    |LSSafeProtectorCrashTypeNSOrderedSetContainer
};


typedef void(^LSSafeProtectorBlock)(NSException *exception,LSSafeProtectorCrashType crashType);

#endif /* SafeProtectorDefine_h */
