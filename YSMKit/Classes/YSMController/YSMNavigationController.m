//
//  YSMNavigationController.m
//  YSMKit
//
//  Created by duanzengguang on 2019/3/5.
//

#import "YSMNavigationController.h"

@implementation YSMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) waekSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = waekSelf;
    }
}

#pragma mark - Override
- (BOOL)shouldAutorotate {
    if ([self.topViewController respondsToSelector:@selector(shouldAutorotate)]) {
        return [self.topViewController shouldAutorotate];
    }
    return  [super shouldAutorotate];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([self.topViewController respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return [self.topViewController supportedInterfaceOrientations];
    }
    return  [super supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if ([self.topViewController respondsToSelector:@selector(preferredInterfaceOrientationForPresentation)]) {
        return [self.topViewController preferredInterfaceOrientationForPresentation];
    }
    return  [super preferredInterfaceOrientationForPresentation];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if ([self.topViewController respondsToSelector:@selector(preferredStatusBarStyle)]) {
        return self.topViewController.preferredStatusBarStyle;
    }
    return [super preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden {
    if ([self.topViewController respondsToSelector:@selector(prefersStatusBarHidden)]) {
        return self.topViewController.prefersStatusBarHidden;
    }
    return [super prefersStatusBarHidden];
}


@end
