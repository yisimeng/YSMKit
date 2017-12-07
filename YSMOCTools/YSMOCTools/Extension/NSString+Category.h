//
//  NSString+Frame.h
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/5.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (Category)

/**
 按照视图的进位方式计算frame

 @param size <#size description#>
 @param options <#options description#>
 @param attributes <#attributes description#>
 @param context <#context description#>
 @return <#return value description#>
 */
- (CGRect)ysm_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes context:(nullable NSStringDrawingContext *)context;

/**
 字符串unicode长度

 @return <#return value description#>
 */
- (int)uinicodeLength;

/**
 字符串是否包含汉字

 @return <#return value description#>
 */
- (BOOL)containChinese;

@end

@interface NSAttributedString (Category)

/**
 按照视图的进位方式计算frame

 @param size <#size description#>
 @param options <#options description#>
 @param context <#context description#>
 @return <#return value description#>
 */
- (CGRect)ysm_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options context:(nullable NSStringDrawingContext *)context;

@end
