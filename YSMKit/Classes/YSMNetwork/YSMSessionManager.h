//
//  YSMSessionManager.h
//  AFNetworking
//
//  Created by duanzengguang on 2018/7/4.
//

#import <AFNetworking/AFNetworking.h>

@interface YSMSessionManager : AFHTTPSessionManager

+ (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                                cookie:(BOOL)cookie
                              progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                               success:(nullable void (^)(id _Nullable responseObject))success
                               failure:(nullable void (^)(NSError *error))failure;


+ (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                 cookie:(BOOL)cookie
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(id _Nullable responseObject))success
                                failure:(nullable void (^)(NSError *error))failure;

@end
