//
//  NSNumber+Category.m
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/7.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import "NSNumber+YSMCategory.h"

@implementation NSNumber (YSMCategory)

- (NSString *)formateNumberWithStyle:(NSNumberFormatterStyle)style{
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = style;
    return [formatter stringFromNumber:self];
    
}

@end
