//
//  NSString+Frame.h
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/5.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YSMCategory)
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

 @return 字符串长度
 */
- (int)ysm_unicodeLength;
/**
 字符串是否包含汉字

 @return YES:包含；NO:不含
 */
- (BOOL)ysm_containChinese;
/**
 限制字符串长度

 @param maxlimit 最大长度
 @return 截取最大长度后的子串
 */
- (NSString *)ysm_substringToMaxCharacterLimit:(NSUInteger)maxlimit;

@end

@interface NSAttributedString (YSMCategory)

/**
 按照视图的进位方式计算frame

 @param size <#size description#>
 @param options <#options description#>
 @param context <#context description#>
 @return <#return value description#>
 */
- (CGRect)ysm_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options context:(nullable NSStringDrawingContext *)context;

@end
