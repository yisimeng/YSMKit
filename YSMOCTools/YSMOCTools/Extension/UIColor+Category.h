//
//  UIColor+Category.h
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/14.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

+ (UIColor *)randomColor;

/**
 颜色的rgba分量

 @return r:[0] g:[1] b:[2] a:[3]
 */
- (const CGFloat *)colorComponentsOfScale;

/**
 *  将图片转化背景颜色
 *
 *  @param imageName <#image description#>
 *
 *  @return <#return value description#>
 */
- (UIColor *)colorWithImageName:(NSString *)imageName;

@end
