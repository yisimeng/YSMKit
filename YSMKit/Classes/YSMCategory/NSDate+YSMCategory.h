//
//  NSDate+YSMCategory.h
//  Pods-YSMKit_Example
//
//  Created by duanzengguang on 2018/9/6.
//

#import <Foundation/Foundation.h>

@interface NSDate (YSMCategory)

/**
 是否在同一周
 
 @param otherDate otherDate
 @return bool value
 */
- (BOOL)isEqualWeak:(NSDate *)otherDate;

@end
