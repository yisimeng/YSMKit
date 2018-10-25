//
//  NSUserDefaults+Category.m
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/5.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import "NSUserDefaults+YSMCategory.h"

@implementation NSUserDefaults (YSMCategory)

+ (void)clean{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dic = [defs dictionaryRepresentation];
    for (id key in dic) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

+ (void)clear{
    NSString * domain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:domain];
}

@end
