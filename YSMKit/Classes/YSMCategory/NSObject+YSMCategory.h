//
//  NSObject+common.h
//  Simeng
//
//  Created by 忆思梦 on 16/4/12.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YSMCategory)
/**
 类方法列表

 @return class methods
 */
+ (NSMutableArray *)classMethods;
/**
 实例方法列表

 @return instance methods
 */
+ (NSMutableArray *)instanceMethods;
/**
 *  获取类属性列表
 *
 *  @return <#return value description#>
 */
+ (NSMutableArray *)propertisArray;
/**
 *  获取类实例列表
 *
 *  @return <#return value description#>
 */
+ (NSMutableArray *)ivarsArray;
/**
 *  获取类遵循协议列表
 *
 *  @return <#return value description#>
 */
+ (NSMutableArray *)protocolArray;
/**
 属性类型

 @param property 属性
 @param obj 对象
 @return 类型
 */
+ (NSString *)classTypeForProperty:(char *)property object:(id)obj;


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
