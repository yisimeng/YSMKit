//
//  NSObject+Hook.h
//  Simeng
//
//  Created by 忆思梦 on 16/5/13.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Hook)

/**
 交换类方法

 @param originalSelector 原方法
 @param swizzledSelector 替换方法
 @return 是否成功
 */
+ (BOOL)swizzleClassMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
/**
 交换实例方法

 @param originalSelector 原方法
 @param swizzledSelector 替换方法
 @return 是否成功
 */
+ (BOOL)swizzleInstanceMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
