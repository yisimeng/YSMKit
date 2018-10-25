//
//  YSMViewController.m
//  YSMKit
//
//  Created by yisimeng on 10/11/2018.
//  Copyright (c) 2018 yisimeng. All rights reserved.
//

#import "YSMViewController.h"
#import <YSMKit/YSMTextView.h>


@interface YSMViewController ()

@end

@implementation YSMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    YSMTextView * test = [[YSMTextView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    test.placeholder = @"打点";
    [self.view addSubview:test];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
