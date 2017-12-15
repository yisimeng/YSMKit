//
//  UIImage+Category.h
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/5.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

/**
 占用内存大小
 */
@property(nonatomic, readonly) NSUInteger memorysize;

/**
 图片上某一像素点的颜色

 @param point <#point description#>
 @return <#return value description#>
 */
- (UIColor *)colorAtPixel:(CGPoint)point;

/**
 使用blend改变图片颜色

 @param tintColor tintcolor
 @param blendMode 混合模式
 @return 混合后的图片
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

/**
 返回一个指定大小、颜色的纯色图片

 @param color 颜色
 @param rect 大小
 @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color andRect:(CGRect)rect;

/**
 view快照

 @param view view
 @return 快照
 */
+ (UIImage*) imageWithUIView:(UIView*) view;

@end
