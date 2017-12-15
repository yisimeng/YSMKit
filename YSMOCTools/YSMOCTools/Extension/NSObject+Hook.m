//
//  NSObject+Hook.m
//  Simeng
//
//  Created by 忆思梦 on 16/5/13.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import "NSObject+Hook.h"

@implementation NSObject (Hook)

+ (BOOL)swizzleClassMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    Method originalMethod = class_getClassMethod(self, originalSelector);
    Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
    if (!originalMethod || !swizzledMethod) return NO;
    method_exchangeImplementations(originalMethod, swizzledMethod);
    return YES;
}

+ (BOOL)swizzleInstanceMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (!originalMethod || !swizzledMethod) return NO;
    class_addMethod(self, originalSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    class_addMethod(self, swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    return YES;
}

@end
