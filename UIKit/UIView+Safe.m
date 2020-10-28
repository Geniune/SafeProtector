//
//  UIView+Safe.m
//  App
//
//  Created by Geniune on 2020/10/28.
//  Copyright © 2020 Geniune. All rights reserved.
//

#import "UIView+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation UIView (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [self exchangeInstance:[self class] selector:@selector(setFrame:) withSwizzledSelector:@selector(safe_setFrame:)];
        [self exchangeInstance:[self class] selector:@selector(setCenter:) withSwizzledSelector:@selector(safe_setCenter:)];
    });
}

- (void)safe_setFrame:(CGRect)frame{
  
    CGRect unitFrame = frame;
    
    if(isnan(unitFrame.origin.x)){
        unitFrame.origin.x = 0;
    }
    if(isnan(unitFrame.origin.y)){
        unitFrame.origin.y = 0;
    }
    if(isnan(unitFrame.size.width)){
        unitFrame.size.width = 0;
    }
    if(isnan(unitFrame.size.height)){
        unitFrame.size.height = 0;
    }
    
    @try {
        [self safe_setFrame:unitFrame];
    } @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception, LSSafeProtectorCrashTypeUIView);
    } @finally {
    }
}

- (void)safe_setCenter:(CGPoint)center{
    
    CGPoint unitCenter = center;
    
    if(isnan(unitCenter.x)){
        unitCenter.x = 0;
    }
    if(isnan(unitCenter.y)){
        unitCenter.y = 0;
    }
    
    @try {
        [self safe_setCenter:unitCenter];
    } @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception, LSSafeProtectorCrashTypeUIView);
    } @finally {
    }
}

@end
