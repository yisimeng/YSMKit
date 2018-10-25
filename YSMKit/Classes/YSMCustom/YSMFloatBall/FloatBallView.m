//
//  FloatBallView.m
//  YSMOCTools
//
//  Created by duanzengguang on 2018/1/3.
//  Copyright © 2018年 忆思梦吧. All rights reserved.
//

#import "FloatBallView.h"
#import "FloatBallMenuContainer.h"
#import "UIImage+YSMCategory.h"

@interface FloatBallView()

@property (strong, nonatomic) FloatBallMenuContainer * menuContainer;
@property (strong, nonatomic) NSMutableArray<FloatBallMenu *> *menus;

@end

@implementation FloatBallView{
    BOOL _isMove;
    CGPoint _beganPoint;
}

#pragma mark -- Initialize

+ (instancetype)shared {
    static FloatBallView * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FloatBallView buttonWithType:UIButtonTypeCustom];
        instance.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, 50, 50);
        instance.backgroundColor = [UIColor orangeColor];
        instance.layer.cornerRadius = 25;
        [instance addTarget:instance action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    });
    return instance;
}

#pragma mark -- public

- (void)show{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    [[UIApplication sharedApplication].delegate.window addSubview:self.menuContainer];
}

- (void)hide{
    [self hideMenu];
    [self removeFromSuperview];
}

#pragma mark -- setter & getter
- (FloatBallMenuContainer *)menuContainer{
    if (_menuContainer == nil) {
        _menuContainer = [[FloatBallMenuContainer alloc] initWithMenus:self.menus];
        _menuContainer.hidden = YES;
    }
    return _menuContainer;
}

- (NSMutableArray<FloatBallMenu *> *)menus{
    if (_menus == nil) {
        FloatBallMenu * menu1 = [[FloatBallMenu alloc] init];
        menu1.title = @"菜单1";
        menu1.image = [UIImage imageWithColor:[UIColor cyanColor] andRect:CGRectMake(0, 0, 30, 30)];
        FloatBallMenu * menu2 = [[FloatBallMenu alloc] init];
        menu2.title = @"菜单2";
        menu2.image = [UIImage imageWithColor:[UIColor brownColor] andRect:CGRectMake(0, 0, 30, 30)];
        _menus = [NSMutableArray arrayWithArray:@[menu1, menu2]];
    }
    return _menus;
}

#pragma mark -- Gesture & touch

- (void)tap:(UIButton *)tap{
    if (tap.isSelected) {
        [self hideMenu];
    }else {
        [self showMenu];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * targetView = [super hitTest:point withEvent:event];
    if (targetView != self) {
        [self hideMenu];
    }
    return targetView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isMove = NO;
    _beganPoint = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    CGFloat delta_x = currentPoint.x - _beganPoint.x;
    CGFloat delta_y = currentPoint.y - _beganPoint.y;
    if (fabs(delta_x) < 5 && fabs(delta_y) < 5) {
        return;
    }
    _isMove = YES;
    [self hideMenu];
    self.center = CGPointMake(self.center.x+delta_x, self.center.y+delta_y);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_isMove == NO) {
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
        return;
    }
    
    CGFloat side_x,side_y;
    if (self.center.x < self.superview.bounds.size.width/2) {
        // 靠左
        side_x = 10 + self.frame.size.width/2;
    }else{
        // 靠右
        side_x = self.superview.bounds.size.width-10-self.frame.size.width/2;
    }
    if (self.center.y < 20 + self.frame.size.height/2) {
        side_y = 20 + self.frame.size.height/2;
    }else if (self.center.y > self.superview.bounds.size.height-10-self.frame.size.height/2) {
        side_y = self.superview.bounds.size.height-10-self.frame.size.height/2;
    }else {
        side_y = self.center.y;
    }
    CGPoint sidePoint = CGPointMake(side_x, side_y);
    CGPointEqualToPoint(sidePoint, self.center)?:[self animatedTo:sidePoint needBounce:YES];
}

#pragma mark -- private

- (void)animatedTo:(CGPoint)point needBounce:(BOOL)bounce{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.center = point;
    } completion:nil];
}

- (void)showMenu{
    if (self.center.x < self.superview.bounds.size.width/2) {
        // 左边
        self.menuContainer.center = CGPointMake(10+self.frame.size.width+self.menuContainer.bounds.size.width/2, self.center.y);
        [_menuContainer animateShowLeft:YES];
    }else {
        // 右边
        self.menuContainer.center = CGPointMake(self.superview.bounds.size.width-10-self.frame.size.width-self.menuContainer.bounds.size.width/2, self.center.y);
        [_menuContainer animateShowLeft:NO];
    }
    self.menuContainer.hidden = NO;
    self.selected = YES;
}
- (void)hideMenu{
    self.menuContainer.hidden = YES;
    self.selected = NO;
}

@end
