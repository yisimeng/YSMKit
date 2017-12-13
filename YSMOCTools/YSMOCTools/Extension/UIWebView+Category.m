//
//  UIWebView+Category.m
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/13.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import "UIWebView+Category.h"

@implementation UIWebView (Category)

+ (void)appendingUserAgent:(NSString *)str{
    UIWebView *webView = [[UIWebView alloc] init];
    NSString *userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *newUserAgent = [userAgent stringByAppendingFormat:@" %@",str];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

@end
