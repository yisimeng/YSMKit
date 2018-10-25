//
//  UIButton+Category.h
//  YSMOCTools
//
//  Created by duanzengguang on 2018/5/8.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YSMButtonLayoutType) {
    YSMButtonLayoutTypeNormal = 0,
    YSMButtonLayoutTypeRightImage = 1,
    YSMButtonLayoutTypeTopImage = 2,
    YSMButtonLayoutTypeBottomIamge = 3,
};

@interface UIButton (YSMCategory)

/**
 自由排列图片和文字。注意：需要设置图片和文字之后调用。
 
 @param layout 排列方式
 @param spacing 间隔
 */
- (void)setLayout:(YSMButtonLayoutType)layout spacing:(CGFloat)spacing;

@end


@protocol YSMCountDownDelegate <NSObject>

@property (nonatomic, strong) dispatch_source_t countDownTimer;

- (void)startWithDuration:(NSInteger)duration running:(void(^)(id target, NSInteger totalTime, NSInteger leftTime))runBlock finished:(void(^)(id target))endBlock;
- (void)invalidTimer;

@end

@interface UIButton (YSMCountDown)<YSMCountDownDelegate>

@property (nonatomic, strong) dispatch_source_t countDownTimer;

@end
