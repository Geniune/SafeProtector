//
//  UIControl+QuickLimit.h
//  App
//
//  Created by Apple on 2018/5/28.
//  Copyright © 2018年 Geniune. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (QuickLimit)

@property(nonatomic, assign) NSTimeInterval  acceptEventInterval;//响应事件间隔，初始值为0.00

@property(nonatomic, assign) BOOL ignoreEvent;//不相应UIControlEvents事件，默认为NO

@end
