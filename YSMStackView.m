//
//  AMStackView.m
//  AmuletSDK
//
//  Created by duanzengguang on 2018/7/26.
//

#import "YSMStackView.h"

@interface YSMStackView ()

@property (nonatomic, assign) CGFloat space;
@property (nonatomic, strong) NSArray * arrangedSubviews;

@end

@implementation YSMStackView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat itemWidth = (self.frame.size.width - (self.arrangedSubviews.count - 1) * self.space)  /self.arrangedSubviews.count;
    CGFloat itemHeight = self.frame.size.height;
    CGFloat itemLeft = 0;
    for (UIView *subView in self.arrangedSubviews) {
        subView.frame = CGRectMake(itemLeft, 0, itemWidth, itemHeight);
        itemLeft += (itemWidth + self.space);
    }
}


#pragma mark -- Public
- (void)setupArrangedSubviews:(NSArray<UIView *> *)arrangedSubviews withSpace:(CGFloat)space{
    self.arrangedSubviews = arrangedSubviews;
    self.space = space;
    for (int i = 0; i < arrangedSubviews.count; i++) {
        [self addSubview:arrangedSubviews[i]];
    }
}

- (void)didSelectSubView:(UIView *)view{
    if (_delegate && [_delegate respondsToSelector:@selector(stackView:didSelect:)]) {
        [_delegate stackView:self didSelect:view.tag];
    }
}

@end
