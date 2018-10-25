//
//  NSString+Category.m
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/5.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import "NSString+YSMCategory.h"

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

@implementation NSString (YSMCategory)

- (CGRect)ysm_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes context:(nullable NSStringDrawingContext *)context{
    CGRect rect = [self boundingRectWithSize:size options:options attributes:attributes context:context];
    return frameFormatterRect(rect);
}

- (int)ysm_unicodeLength{
    // 第一种
    int asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex:i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
    
// 第二种
//    int strlength = 0;
//    char* p = (char*)[self dcStringUsingEncoding:NSUnicodeStringEncoding];
//    for (int i=0 ; i（[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++){
//        if (*p){
//            p++;
//            strlength++;
//        }else{
//            p++;
//        }
//    }
//    return strlength;
}

- (BOOL)ysm_containChinese{
    for (int i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (0x4E00 <= ch && ch <= 0x9FA5){
            return YES;
        }
    }
    return NO;
}

- (NSString *)ysm_substringToMaxCharacterLimit:(NSUInteger)maxlimit{
    NSMutableString *appString = [NSMutableString string];
    NSInteger length = [self ysm_unicodeLength];
    if(length <= maxlimit){
        [appString appendString:self];
    }else{
        if(length > maxlimit * 2){
            NSInteger endIndex = maxlimit;
            for(;endIndex >= 0 ; endIndex--){
                @autoreleasepool {
                    NSString *tempString = [self substringToIndex:endIndex];
                    NSInteger templength = [tempString ysm_unicodeLength];
                    if(templength <= maxlimit ){
                        [appString appendString:tempString];
                        break;
                    }
                }
            }
        }else{
            NSInteger startIndex = 0;
            for(;startIndex < maxlimit; startIndex ++){
                @autoreleasepool {
                    NSString *tempString = [self substringToIndex:startIndex];
                    NSInteger templength = [tempString ysm_unicodeLength];
                    if(templength > maxlimit ){
                        break;
                    }
                }
            }
            [appString appendString:[self substringToIndex:startIndex - 1]];
        }
    }
    return appString;
}

@end

@implementation NSAttributedString (YSMCategory)

- (CGRect)ysm_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options context:(nullable NSStringDrawingContext *)context{
    CGRect rect = [self boundingRectWithSize:size options:options context:context];
    return frameFormatterRect(rect);
}

@end
