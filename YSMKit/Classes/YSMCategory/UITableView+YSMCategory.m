//
//  UITableView+EmptyView.m
//  PigTeammates
//
//  Created by 忆思梦 on 2017/7/25.
//  Copyright © 2017年 muxiao. All rights reserved.
//

#import "UITableView+YSMCategory.h"
#import <objc/runtime.h>

@implementation UITableView (YSMCategory)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originSelector = @selector(reloadData);
        SEL swizzledSelector = @selector(hook_reloadData);
        
        Method originalMethod = class_getInstanceMethod(self, originSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(self,originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}


const void * kEmptyViewKey;
- (UIView *)emptyView{
    return objc_getAssociatedObject(self, kEmptyViewKey);
}
- (void)setEmptyView:(UIView *)emptyView{
    emptyView.userInteractionEnabled = NO;
    emptyView.center = CGPointMake(CGRectGetMidX(self.bounds), 100+emptyView.bounds.size.height/2);
    objc_setAssociatedObject(self, kEmptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/// EmptyView 监测刷新数据
- (void)hook_reloadData{
    [self hook_reloadData];
    
    if (self.emptyView != nil) {
        if ([self detectEmptyDataSource]) {
            [self.emptyView removeFromSuperview];
            [self addSubview:self.emptyView];
        }else {
            [self.emptyView removeFromSuperview];
        }
    }
}


/**
 检测当前数据是否为空
 */
- (BOOL)detectEmptyDataSource{
    BOOL isEmpty = YES;
    id<UITableViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    if (sections < 2) {
        int section = 0;
        do {
            NSInteger rows = [src tableView:self numberOfRowsInSection:section];
            if (rows) {
                isEmpty = NO;
            }
        } while (isEmpty && ((++section) < sections));
    }
    return isEmpty;
}

@end
