//
//  UIViewController+YSMCategory.m
//  YSMKit
//
//  Created by duanzengguang on 2018/9/7.
//

#import "UIViewController+YSMCategory.h"

@implementation UIViewController (YSMCategory)

+ (instancetype)ysm_loadFromNibInBundle:(NSBundle *)bundle{
    return [[self alloc] initWithNibName:NSStringFromClass(self) bundle:bundle];
}

+ (instancetype)ysm_loadFromStoryboard:(UIStoryboard *)storyboard {
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

@end
