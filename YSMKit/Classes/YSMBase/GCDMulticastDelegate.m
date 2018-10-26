//
//  GCDMulticastDelegate.m
//  GCDMulticastDelegate
//
//  Created by 忆思梦 on 2016/11/16.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import "GCDMulticastDelegate.h"

/**
 delegate队列中元素（代理对象）
 */
@interface GCDMulticastDelegateNode : NSObject{
    __weak id delegate;
    dispatch_queue_t delegateQueue;
}

@property (readwrite,weak) id delegate;
@property (nonatomic, readonly) dispatch_queue_t delegateQueue;

- (id)initWithDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

@end

@implementation GCDMulticastDelegateNode

@synthesize delegate;
@synthesize delegateQueue;

- (id)initWithDelegate:(id)inDelegate delegateQueue:(dispatch_queue_t)inDelegateQueue{
    if (self = [super init]) {
        delegate = inDelegate;
        delegateQueue = inDelegateQueue;
    }
    return self;
}

@end

@interface GCDMulticastDelegate ()
{
    //代理队列
    NSMutableArray<GCDMulticastDelegateNode *> * deleteNodes;
}
@end

@implementation GCDMulticastDelegate

- (id)init{
    if (self = [super init]) {
        deleteNodes = [NSMutableArray array];
    }
    return self;
}

- (void)addDelegate:(id)delelgate delegateQueue:(dispatch_queue_t)delegateQueue{
    if (delelgate == nil) return;
//    if (delegateQueue == NULL) return;    //留有疑问
    GCDMulticastDelegateNode * node = [[GCDMulticastDelegateNode alloc] initWithDelegate:delelgate delegateQueue:delegateQueue];
    [deleteNodes addObject:node];
}

- (void)removeDelegate:(id)delelgate delegateQueue:(dispatch_queue_t)delegateQueue{
    if (delelgate == nil) return;
    for (GCDMulticastDelegateNode * node in deleteNodes) {
        if ([node isEqual:delelgate]) {
            //可能调用: - (void)removeDelegate:(id)delelgate方法移除代理
            if (node.delegateQueue == NULL || node.delegateQueue == delegateQueue) {
                //将代理对象置空，delegateQueue需要到node销毁时才会释放
                node.delegate = nil;
                [deleteNodes removeObject:node];
            }
        }
    }
}

- (void)removeDelegate:(id)delelgate{
    [self removeDelegate:delelgate delegateQueue:NULL];
}

- (void)removeAllDelegate{
    for (GCDMulticastDelegateNode * node in deleteNodes) {
        node.delegate = nil;
    }
    [deleteNodes removeAllObjects];
}

- (BOOL)hasDelegateThatRespondsToSelector:(SEL)aSelector{
    for (GCDMulticastDelegateNode * node in deleteNodes) {
        if ([node.delegate respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

- (void)dealloc{
    [self removeAllDelegate];
}

#pragma mark - 消息转发
//必须重写，否则不走forwardInvocation:方法
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    for (GCDMulticastDelegateNode * node in deleteNodes) {
        //获取方法签名
        NSMethodSignature * methodSignature = [node.delegate methodSignatureForSelector:aSelector];
        if (methodSignature != nil) {
            return methodSignature;
        }
    }
    return [[self class] instanceMethodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL selector = anInvocation.selector;
    BOOL foundNilDelegate = NO;
    
    for (GCDMulticastDelegateNode * node in deleteNodes) {
        if ([node.delegate respondsToSelector:selector]) {
//            id delegate = node.delegate;
            //为什么要重新创建一个invocation呢
          NSInvocation * dupInvocation = [self duplicateInvocation:anInvocation];
            dispatch_async(node.delegateQueue, ^{
                @autoreleasepool {
                    if (node.delegate) {
                        [dupInvocation invokeWithTarget:node.delegate];
                    }
                }
            });
        }else if (node.delegate == nil){
            foundNilDelegate = YES;
        }
    }
    
    //移除被销毁的delegate
    if (foundNilDelegate){
        NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
        NSUInteger index = 0;
        for (GCDMulticastDelegateNode *node in deleteNodes){
            id nodeDelegate = node.delegate;
            if (nodeDelegate == nil){
                [indexSet addIndex:index];
            }
            index++;
        }
        
        [deleteNodes removeObjectsAtIndexes:indexSet];
    }
    
}


/**
 原代码中的方法，重新生成一个没有target的Invocation，没明白所以注释了：
 更新：因为系统会通过methodSignatureForSelector方法的返回值判断消息是否需要进一步转发处理，如果返回了方法的签名，表示当前有接受者可以处理消息，系统会自动调用forwardInvocation进行转发，而在forwardInvocation方法中是通过遍历代理数组，而方法的参数“anInvocation”是通过数组中第一个值生成的方法签名，所以需要对数组中其他的代理生成对应的方法签名和invocation

 @param oriInvocation <#oriInvocation description#>

 @return <#return value description#>
 */
- (NSInvocation *)duplicateInvocation:(NSInvocation *)oriInvocation{
    NSMethodSignature * methodSignature = oriInvocation.methodSignature;
    NSInvocation * dupInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [dupInvocation setSelector:[oriInvocation selector]];
    
    NSUInteger i, count = [methodSignature numberOfArguments];
    for (i = 2; i < count; i++)
    {
        const char *type = [methodSignature getArgumentTypeAtIndex:i];
        
        if (*type == *@encode(BOOL))
        {
            BOOL value;
            [oriInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(char) || *type == *@encode(unsigned char))
        {
            char value;
            [oriInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(short) || *type == *@encode(unsigned short))
        {
            short value;
            [oriInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(int) || *type == *@encode(unsigned int))
        {
            int value;
            [oriInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(long) || *type == *@encode(unsigned long))
        {
            long value;
            [oriInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(long long) || *type == *@encode(unsigned long long))
        {
            long long value;
            [oriInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(double))
        {
            double value;
            [oriInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == *@encode(float))
        {
            float value;
            [oriInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == '@')
        {
            void *value;
            [oriInvocation getArgument:&value atIndex:i];
            [dupInvocation setArgument:&value atIndex:i];
        }
        else if (*type == '^')
        {
            void *block;
            [oriInvocation getArgument:&block atIndex:i];
            [dupInvocation setArgument:&block atIndex:i];
        }
        else
        {
            NSString *selectorStr = NSStringFromSelector([oriInvocation selector]);
            
            NSString *format = @"Argument %lu to method %@ - Type(%c) not supported";
            NSString *reason = [NSString stringWithFormat:format, (unsigned long)(i - 2), selectorStr, *type];
            
            [[NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil] raise];
        }
    }
    
    [dupInvocation retainArguments];
    
    return dupInvocation;
}

@end
