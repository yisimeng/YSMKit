//
//  ViewController.m
//  YSMOCTools
//
//  Created by 马彬彬 on 2017/8/23.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "UIImage+Category.h"
#import "FloatBallView.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *first;

@property (weak, nonatomic) IBOutlet UIButton *second;
@property (weak, nonatomic) IBOutlet UIButton *third;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
     
- (IBAction)show:(id)sender {
    
    [[FloatBallView shared] show];
    
}

- (IBAction)hide:(id)sender {
    [[FloatBallView shared] hide];
}

- (IBAction)test:(id)sender {
}


@end

