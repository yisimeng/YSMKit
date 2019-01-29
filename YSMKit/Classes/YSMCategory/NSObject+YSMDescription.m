//
//  NSObject+YSMDescription.m
//  YSMKit
//
//  Created by duanzengguang on 2019/1/29.
//

#import "NSObject+YSMDescription.h"

static NSString * const kDescriptionArrayBegin = @"[";
static NSString * const kDescriptionArrayEnd = @"]";
static NSString * const kDescriptionDictionaryBegin = @"{";
static NSString * const kDescriptionDictionaryEnd = @"}";
static NSString * const kDescriptionSetBegin = @"{(";
static NSString * const kDescriptionSetEnd = @")}";

@implementation NSArray (YSMDescription)

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)debugDescription{
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString * string = [NSMutableString string];
    [string appendFormat:@"%@\n", kDescriptionArrayBegin];
    NSUInteger count = self.count;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * temp = nil;
        if ([obj respondsToSelector:@selector(descriptionWithLocale:)]) {
            temp = [obj performSelector:@selector(descriptionWithLocale:) withObject:locale];
            temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        }else{
            temp = [obj performSelector:@selector(description) withObject:nil];
            if ([obj isKindOfClass:[NSString class]]) {
                temp = [NSString stringWithFormat:@"\"%@\"",temp];
            }
        }
        [string appendFormat:@"\t%@",temp];
        if ((idx+1 != count)) {
            [string appendString:@","];
        }
        [string appendString:@"\n"];
    }];
    [string appendString:kDescriptionArrayEnd];
    return string;
}

@end


@implementation NSDictionary (YSMDescription)

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)debugDescription{
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString * string = [NSMutableString string];
    [string appendFormat:@"%@\n",kDescriptionDictionaryBegin];
    NSUInteger count = self.count;
    __block NSUInteger index = 0;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        // key
        NSString * keyTemp = nil;
        if ([key respondsToSelector:@selector(descriptionWithLocale:)]) {
            keyTemp = [key performSelector:@selector(descriptionWithLocale:) withObject:locale];
            keyTemp = [keyTemp stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        }else{
            keyTemp = [key performSelector:@selector(description) withObject:nil];
            if ([key isKindOfClass:[NSString class]]) {
                keyTemp = [NSString stringWithFormat:@"\"%@\"",keyTemp];
            }
        }
        // value
        NSString * valueTemp = nil;
        if ([value respondsToSelector:@selector(descriptionWithLocale:)]) {
            valueTemp = [value performSelector:@selector(descriptionWithLocale:) withObject:locale];
            valueTemp = [valueTemp stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        }else{
            valueTemp = [value performSelector:@selector(description) withObject:nil];
            if ([value isKindOfClass:[NSString class]]) {
                valueTemp = [NSString stringWithFormat:@"\"%@\"",valueTemp];
            }
        }
        [string appendFormat:@"\t%@ = %@",keyTemp, valueTemp];
        if (++index != count) {
            [string appendString:@","];
        }
        [string appendString:@"\n"];
    }];
    [string appendString:kDescriptionDictionaryEnd];
    return string;
}

@end

@implementation NSSet (YSMDescription)

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)debugDescription{
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString * string = [NSMutableString string];
    [string appendFormat:@"%@\n",kDescriptionSetBegin];
    NSUInteger count = self.count;
    __block NSUInteger idx = 0;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString * temp = nil;
        if ([obj respondsToSelector:@selector(descriptionWithLocale:)]) {
            temp = [obj performSelector:@selector(descriptionWithLocale:) withObject:locale];
            temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        }else{
            temp = [obj performSelector:@selector(description) withObject:nil];
            if ([obj isKindOfClass:[NSString class]]) {
                temp = [NSString stringWithFormat:@"\"%@\"", temp];
            }
        }
        [string appendFormat:@"\t%@", temp];
        if (++idx != count) {
            [string appendString:@","];
        }
        [string appendString:@"\n"];
    }];
    [string appendString:kDescriptionSetEnd];
    return string;
}

@end
