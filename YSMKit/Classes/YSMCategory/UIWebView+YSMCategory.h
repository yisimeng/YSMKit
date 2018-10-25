//
//  UIWebView+Category.h
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/13.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (YSMCategory)

/**
 更新User-Agent

 @param str 添加的字符串
 */
+ (void)appendingUserAgent:(NSString *)str;

@end
