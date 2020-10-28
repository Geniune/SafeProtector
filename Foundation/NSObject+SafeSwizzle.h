//
//  NSObject+SafeSwizzle.h
//  TestExample
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (SafeSwizzle)

//交换对象方法
//+ (BOOL)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;
+ (BOOL)exchangeInstance:(Class)class selector:(SEL)originalSelector withSwizzledSelector: (SEL)swizzledSelector;


+ (BOOL)swizzleClassMethod:(SEL)originalSelector withClassMethod:(SEL)swizzledSelector error:(NSError**)error;
+ (BOOL)swizzleMethod:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector error:(NSError**)error;

+ (NSInvocation*)swizzleMethod:(SEL)originalSelector withBlock:(id)block error:(NSError**)error;
+ (NSInvocation*)swizzleClassMethod:(SEL)originalSelector withBlock:(id)block error:(NSError**)error;

@end

