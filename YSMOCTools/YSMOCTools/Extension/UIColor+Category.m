//
//  UIColor+Category.m
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/14.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

- (const CGFloat *)colorComponentsOfScale{
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components;
}

/**
 *  将图片转化背景颜色
 *
 *  @param imageName <#image description#>
 *
 *  @return <#return value description#>
 */
- (UIColor *)colorWithImageName:(NSString *)imageName{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
}

@end
