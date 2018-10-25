//
//  UIColor+Category.m
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/14.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import "UIColor+YSMCategory.h"

@implementation UIColor (YSMCategory)

+ (UIColor *)ysm_colorWithHex:(NSUInteger)hex{
    return [UIColor ysm_colorWithHex:hex alpha:1.0];
}

+ (UIColor *)ysm_colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)ysm_randomColor{
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
}

- (const CGFloat *)ysm_colorComponentsOfScale{
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components;
}

- (UIColor *)ysm_colorWithImageName:(NSString *)imageName{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
}

@end
