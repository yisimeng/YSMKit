//
//  UIImage+Category.m
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/5.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

- (NSUInteger)memorysize{
    return CGImageGetWidth(self.CGImage)*CGImageGetHeight(self.CGImage);
}

@end
