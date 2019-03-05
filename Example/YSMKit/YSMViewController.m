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
