//
//  UIButton+Category.h
//  YSMOCTools
//
//  Created by duanzengguang on 2018/5/8.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QHButtonLayout) {
    QHButtonLayoutNormal = 0,
    QHButtonLayoutRightImage = 1,
    QHButtonLayoutTopImage = 2,
    QHButtonLayoutBottomIamge = 3,
};

@interface UIButton (Category)

/**
 自由排列图片和文字。注意：需要设置图片和文字之后调用。
 
 @param layout 排列方式
 @param spacing 间隔
 */
- (void)setLayout:(QHButtonLayout)layout spacing:(CGFloat)spacing;


@end
