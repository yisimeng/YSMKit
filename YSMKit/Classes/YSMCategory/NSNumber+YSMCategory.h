//
//  NSNumber+Category.h
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/7.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (YSMCategory)

/**
 格式化number输出
 
 @param style <#style description#>
 @return <#return value description#>
 */
- (NSString *)formateNumberWithStyle:(NSNumberFormatterStyle)style;

@end
