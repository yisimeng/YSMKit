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

@end
