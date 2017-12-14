//
//  NSDate+Category.m
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/14.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

- (BOOL)isEqualWeak:(NSDate *)otherDate{
    // 日期间隔大于七天直接返回NO
    if (fabs([self timeIntervalSinceDate:otherDate]) >= 7*24*3600) {
        return NO;
    }
    NSCalendar *calender = [NSCalendar currentCalendar];
    // 设置每周第一天为周一
    calender.firstWeekday = 2;
    // 计算两个日期分别为本年的第几周
    NSUInteger first = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:self];
    NSUInteger second = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:otherDate];
    return first == second;
}

@end
