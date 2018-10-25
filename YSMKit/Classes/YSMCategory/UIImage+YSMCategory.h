//
//  UIImage+Category.h
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/5.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YSMCategory)

+ (UIImage *)ysm_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;

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
+ (UIImage *)imageWithUIView:(UIView *)view;

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

- (UIImage *)ysm_compressBelowMaxLength:(NSUInteger)maxLength;

- (UIImage *)ysm_scaleToScale:(float)scale;

- (UIImage *)ysm_scaleImageWithData:(NSData *)data withSize:(CGSize)size scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;

@end

@interface UIImage (YSMRender)

/**
 使用blend改变图片颜色
 
 @param tintColor tintcolor
 @param blendMode 混合模式
 @return 混合后的图片
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

/**
 template image
 */
- (UIImage *)ysm_templateImage;

/**
 original image
 */
- (UIImage *)ysm_originalImage;

- (UIImage *)ysm_resizableImage;

- (UIImage *)ysm_resizableImageWithCapInsets:(UIEdgeInsets)capInsets;

@end

@interface UIImage (YSMCorner)

- (UIImage *)ysm_circleImage;

- (UIImage *)ysm_circleImageWithFillColor:(UIColor *)fillColor;

- (UIImage *)ysm_imageCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius;

- (UIImage *)ysm_imageWithSize:(CGSize)size corners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius;

- (UIImage *)ysm_imageWithCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor;

- (UIImage *)ysm_imageWithSize:(CGSize)size corners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor;

@end
