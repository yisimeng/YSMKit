//
//  NSString+Frame.m
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/5.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import "NSString+Frame.h"

CGRect frameFormatterRect(CGRect rect){
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    //允许1位小数
    formatter.maximumFractionDigits = 1;
    //增量设置为0.5
    formatter.roundingIncrement = @0.5;
    //向上取整
    formatter.roundingMode = kCFNumberFormatterRoundUp;
    CGRect result;
    result.origin.x = [[formatter stringFromNumber:[NSNumber numberWithFloat:rect.origin.x]] floatValue];
    result.origin.y = [[formatter stringFromNumber:[NSNumber numberWithFloat:rect.origin.y]] floatValue];
    result.size.width = [[formatter stringFromNumber:[NSNumber numberWithFloat:rect.size.width]] floatValue];
    result.size.height = [[formatter stringFromNumber:[NSNumber numberWithFloat:rect.size.height]] floatValue];
    return result;
}

@implementation NSString (Frame)

- (CGRect)ysm_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes context:(nullable NSStringDrawingContext *)context{
    CGRect rect = [self boundingRectWithSize:size options:options attributes:attributes context:context];
    return frameFormatterRect(rect);
}

@end

@implementation NSAttributedString (Frame)

- (CGRect)ysm_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options context:(nullable NSStringDrawingContext *)context{
    CGRect rect = [self boundingRectWithSize:size options:options context:context];
    return frameFormatterRect(rect);
}

@end
