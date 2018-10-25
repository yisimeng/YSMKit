//
//  UIViewController+YSMCategory.h
//  YSMKit
//
//  Created by duanzengguang on 2018/9/7.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YSMCategory)

+ (instancetype)ysm_loadFromNibInBundle:(NSBundle *)bundle;

+ (instancetype)ysm_loadFromStoryboard:(UIStoryboard *)storyboard;

@end
