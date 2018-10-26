//
//  GCDMulticastDelegate.h
//  GCDMulticastDelegate
//
//  Created by 忆思梦 on 2016/11/16.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDMulticastDelegate : NSObject

/**
 添加代理

 @param delelgate <#delelgate description#>
 @param delegateQueue <#delegateQueue description#>
 */
- (void)addDelegate:(id)delelgate delegateQueue:(dispatch_queue_t)delegateQueue;

/**
 移除代理

 @param delelgate <#delelgate description#>
 @param delegateQueue <#delegateQueue description#>
 */
- (void)removeDelegate:(id)delelgate delegateQueue:(dispatch_queue_t)delegateQueue;

/**
 是否有代理实现aSelector方法

 @param aSelector <#aSelector description#>
 @return <#return value description#>
 */
- (BOOL)hasDelegateThatRespondsToSelector:(SEL)aSelector;

@end
