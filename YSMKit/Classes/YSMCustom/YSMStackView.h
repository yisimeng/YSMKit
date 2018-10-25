//
//  AMStackView.h
//  AmuletSDK
//
//  Created by duanzengguang on 2018/7/26.
//

#import <UIKit/UIKit.h>

@class YSMStackView;
@protocol YSMStackViewDelegate <NSObject>

@optional
- (void)stackView:(YSMStackView *)stackView didSelect:(NSInteger)index;

@end

@interface YSMStackView : UIView

@property (nonatomic, weak) id<YSMStackViewDelegate> delegate;

- (void)setupArrangedSubviews:(NSArray<UIView *> *)arrangedSubviews withSpace:(CGFloat)space;

- (void)didSelectSubView:(UIView *)view;

@end
