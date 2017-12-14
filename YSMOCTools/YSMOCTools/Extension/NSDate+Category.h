//
//  NSDate+Category.h
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/14.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

/**
 是否在同一周

 @param otherDate otherDate
 @return bool value
 */
- (BOOL)isEqualWeak:(NSDate *)otherDate;

@end
