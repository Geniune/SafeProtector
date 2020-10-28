//
//  UITextField+Safe.m
//  App
//
//  Created by Geniune on 2020/9/2.
//  Copyright © 2020 Geniune. All rights reserved.
//

#import "UITextField+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation UITextField (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [self exchangeInstance:[self class] selector:@selector(setText:) withSwizzledSelector:@selector(safe_setText:)];
    });
}

- (void)safe_setText:(NSString *)text{
    
    if(!text){
        text = @"";
    }
    
    if(![text isKindOfClass:[NSString class]]){
        text = [NSString stringWithFormat:@"%@", text];
    }
    
    @try {
        [self safe_setText:text];
    } @catch (NSException *exception) {
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeUITextField);
    } @finally {
        
    }
}

@end
