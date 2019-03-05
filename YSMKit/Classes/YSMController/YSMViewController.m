//
//  YSMViewController.m
//  YSMKit
//
//  Created by duanzengguang on 2019/3/5.
//

#import "YSMViewController.h"

@interface YSMViewController ()

@end

@implementation YSMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    /// ignore adjust auto scroll 64
    if (@available(iOS 11.0, *)) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.extendedLayoutIncludesOpaqueBars = YES;
}

#pragma mark - Orientation
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {return UIInterfaceOrientationMaskPortrait;}
- (BOOL)shouldAutorotate {return YES;}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {return UIInterfaceOrientationPortrait;}

#pragma mark - Status bar
- (BOOL)prefersStatusBarHidden { return NO; }
- (UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleDefault; }
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation { return UIStatusBarAnimationFade; }

@end
