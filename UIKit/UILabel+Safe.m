//
//  UILabel+Safe.m
//  App
//
//  Created by Apple on 2019/1/4.
//  Copyright © 2019年 Geniune. All rights reserved.
//

#import "UILabel+Safe.h"
#import "NSObject+SafeSwizzle.h"

@implementation UILabel (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

//         [self exchangeInstance:[UILabel class] selector:@selector(setText:) withSwizzledSelector:@selector(safe_setText:)];
    });
}

- (void)safe_setText:(NSString *)text{
    
    if(!text){
        
        text = @"";
    }
    
    if(![text isKindOfClass:[NSString class]]){
        
        text = [NSString stringWithFormat:@"%@", text];
    }

    // invoke originalimplemention
    [self safe_setText:text];
}

@end
