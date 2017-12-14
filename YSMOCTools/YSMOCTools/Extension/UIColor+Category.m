//
//  UIColor+Category.m
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/14.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

- (const CGFloat *)colorComponents{
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components;
}

@end
