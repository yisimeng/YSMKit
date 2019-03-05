//
//  YSMTabViewController.m
//  YSMKit
//
//  Created by duanzengguang on 2019/3/5.
//

#import "YSMTabViewController.h"

@interface YSMTabViewController ()

@end

@implementation YSMTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Override
- (BOOL)shouldAutorotate {
    if ([self.tabBarController.selectedViewController respondsToSelector:@selector(shouldAutorotate)]) {
        return [self.tabBarController.selectedViewController shouldAutorotate];
    }
    return  [super shouldAutorotate];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.tabBarController.selectedViewController;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([self.tabBarController.selectedViewController respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return [self.tabBarController.selectedViewController supportedInterfaceOrientations];
    }
    return  [super supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if ([self.tabBarController.selectedViewController respondsToSelector:@selector(preferredInterfaceOrientationForPresentation)]) {
        return [self.tabBarController.selectedViewController preferredInterfaceOrientationForPresentation];
    }
    return  [super preferredInterfaceOrientationForPresentation];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if ([self.tabBarController.selectedViewController respondsToSelector:@selector(preferredStatusBarStyle)]) {
        return self.tabBarController.selectedViewController.preferredStatusBarStyle;
    }
    return [super preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden {
    if ([self.tabBarController.selectedViewController respondsToSelector:@selector(prefersStatusBarHidden)]) {
        return self.tabBarController.selectedViewController.prefersStatusBarHidden;
    }
    return [super prefersStatusBarHidden];
}

@end
