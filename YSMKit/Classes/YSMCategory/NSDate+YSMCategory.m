//
//  NSDate+YSMCategory.m
//  Pods-YSMKit_Example
//
//  Created by duanzengguang on 2018/9/6.
//

#import "NSDate+YSMCategory.h"

@implementation NSDate (YSMCategory)

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
