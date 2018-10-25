//
//  UIButton+Category.m
//  YSMOCTools
//
//  Created by duanzengguang on 2018/5/8.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

#import "UIButton+YSMCategory.h"
#import <objc/runtime.h>

@implementation UIButton (YSMCategory)

- (void)setLayout:(YSMButtonLayoutType)layout spacing:(CGFloat)spacing{
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];
    
    
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    CGSize labelSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGFloat labelWidth = labelSize.width;
    CGFloat labelHeight = labelSize.height;
    
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;
    
    switch (layout) {
        case YSMButtonLayoutTypeNormal:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case YSMButtonLayoutTypeRightImage:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case YSMButtonLayoutTypeTopImage:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
            
        case YSMButtonLayoutTypeBottomIamge:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
    }
}

@end

@implementation UIButton (YSMCountDown)
static NSString * YSMCountDownTimerKey;

- (void)setCountDownTimer:(dispatch_source_t)countDownTimer{
    objc_setAssociatedObject(self, &YSMCountDownTimerKey, countDownTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)countDownTimer{
    return objc_getAssociatedObject(self, &YSMCountDownTimerKey);
}

- (void)invalidTimer {
    if (self.countDownTimer) {
        dispatch_source_cancel(self.countDownTimer);
        self.countDownTimer = nil;
    }
}

- (void)startWithDuration:(NSInteger)duration running:(void (^)(id, NSInteger, NSInteger))runBlock finished:(void (^)(id))endBlock {
    __block NSInteger timeOut = duration;
    dispatch_queue_t queue    = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.countDownTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.countDownTimer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.countDownTimer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(self.countDownTimer);
            dispatch_async(dispatch_get_main_queue(), ^{
                endBlock(self);
            });
        } else {
            int allTime = (int)duration + 1;
            int seconds = timeOut % allTime;
            dispatch_async(dispatch_get_main_queue(), ^{
                runBlock(self, duration, seconds);
            });
            timeOut--;
        }
    });
    dispatch_resume(self.countDownTimer);
}

@end
