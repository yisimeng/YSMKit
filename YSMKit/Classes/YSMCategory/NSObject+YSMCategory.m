//
//  NSObject+common.m
//  Simeng
//
//  Created by 忆思梦 on 16/4/12.
//  Copyright © 2016年 忆思梦. All rights reserved.
//

#import "NSObject+YSMCategory.h"
#import <objc/runtime.h>

@implementation NSObject (YSMCategory)

+ (NSMutableArray *)methodNameArray{
    u_int count;
    NSMutableArray * methodArray = [NSMutableArray arrayWithCapacity:1];
    Method * methods = class_copyMethodList(self, &count);
    for (int i = 0; i < count; i++) {
        SEL method = method_getName(methods[i]);
        NSString *methodName = [NSString stringWithUTF8String:sel_getName(method)];
        [methodArray addObject:methodName];
    }
    free(methods);
    return methodArray;
}

+ (NSMutableArray *)propertisArray{
    u_int count;
    NSMutableArray * propertyArray = [NSMutableArray arrayWithCapacity:1];
    objc_property_t * propertis = class_copyPropertyList(self, &count);
    for (int i = 0; i < count; i++) {
        const char *property = property_getName(propertis[i]);
        NSString * propertyName = [NSString stringWithUTF8String:property];
        [propertyArray addObject:propertyName];
    }
    free(propertis);
    return propertyArray;
}

+ (NSMutableArray *)ivarsArray{
    u_int count;
    NSMutableArray * ivarArray = [NSMutableArray arrayWithCapacity:1];
    Ivar * ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        const char *ivar = ivar_getName(ivars[i]);
        NSString * ivarName = [NSString stringWithUTF8String:ivar];
        [ivarArray addObject:ivarName];
    }
    free(ivars);
    return ivarArray;
}

+ (NSMutableArray *)protocolArray{
    u_int count;
    NSMutableArray * protocolArray = [NSMutableArray arrayWithCapacity:1];
    __unsafe_unretained Protocol ** protocols = class_copyProtocolList(self, &count);
    for (int i = 0; i < count; i++) {
        const char * name = protocol_getName(protocols[i]);
        NSString * protocolName = [NSString stringWithUTF8String:name];
        [protocolArray addObject:protocolName];
    }
    free(protocols);
    return protocolArray;
}

+ (NSString *)classTypeForProperty:(char *)property object:(id)obj{
    Ivar var = class_getInstanceVariable(object_getClass(obj), property);
    const char * type = ivar_getTypeEncoding(var);
    NSString * typeName = [NSString stringWithUTF8String:type];
    return typeName;
}


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
