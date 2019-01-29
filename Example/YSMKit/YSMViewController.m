//
//  YSMViewController.m
//  YSMKit
//
//  Created by yisimeng on 10/11/2018.
//  Copyright (c) 2018 yisimeng. All rights reserved.
//

#import "YSMViewController.h"
#import <YSMKit/YSMKit.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreText/CoreText.h>

@interface YSMViewController ()

@property (nonatomic, strong) CATextLayer * noticeLayer;

@end

@implementation YSMViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSString * str = @"中文1";
    NSArray * array = @[str,@"中文2",@"中文3",@"中文4",@"中文5",@"中文6",@"中文7",@"中文8",@"中文9",@"中文10"];
    NSSet *set = [NSSet setWithObjects:@"文字1",@"文字2",@"文字3",@"文字4",@"文字5",@"文字6", nil];
    NSDictionary * dic = @{array:set};
    NSLog(@"%@",dic);
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIFont * font = [UIFont fontWithName:@"Helvetica" size:15];
    NSAttributedString *content = [[NSAttributedString alloc] initWithString:@"打发打发打发点阿等发达地方" attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor],NSUnderlineStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle],NSBaselineOffsetAttributeName:@(0)}];
    
    self.noticeLayer = [CATextLayer layer];
    _noticeLayer.string = content;
    _noticeLayer.fontSize = 15;
    _noticeLayer.alignmentMode = kCAAlignmentCenter;
    _noticeLayer.frame = CGRectMake(100, 100, 100, 30);
    _noticeLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:_noticeLayer];
    
    
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [button addTarget:self action:@selector(sendNotification) forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"发送一个3s后显示的通知" forState:UIControlStateNormal];
//    button.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 100);
//    [self.view addSubview:button];
    
}

//发送一个通知
- (void)sendNotification {
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3.0f repeats:NO];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"App探索-NotFound";
    content.body = @"[App探索]JSBox中幽灵触发器的实现原理探索";
    content.badge = @1;
    content.categoryIdentifier = @"NotificationForeverCategory";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"requestIdentifier" content:content trigger:timeTrigger];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler: nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
