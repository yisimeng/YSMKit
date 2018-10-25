//
//  UIColor+Category.h
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/14.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YSMCategory)
/**
 十六进制数值生成颜色

 @param hex hex
 @return color
 */
+ (UIColor *)ysm_colorWithHex:(NSUInteger)hex;
/**
 十六进制数值生成颜色

 @param hex hex
 @param alpha 透明度
 @return color
 */
+ (UIColor *)ysm_colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;

/**
 随机颜色

 @return color
 */
+ (UIColor *)ysm_randomColor;
/**
 颜色的rgba分量

 @return r:[0] g:[1] b:[2] a:[3]
 */
- (const CGFloat *)ysm_colorComponentsOfScale;
/**
 *  将图片转化背景颜色
 *
 *  @param imageName image name
 *
 *  @return color
 */
- (UIColor *)ysm_colorWithImageName:(NSString *)imageName;

@end
