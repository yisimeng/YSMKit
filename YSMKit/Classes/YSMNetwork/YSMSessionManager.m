//
//  YSMSessionManager.m
//  AFNetworking
//
//  Created by duanzengguang on 2018/7/4.
//

#import "YSMSessionManager.h"
#import "YSMMacros.h"

@implementation YSMSessionManager

static YSMSessionManager * shareInstance = nil;
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[YSMSessionManager alloc] init];
        //设置User-Agent
//        [shareInstance.requestSerializer setValue:[QHUtils userAgent] forHTTPHeaderField:@"User-Agent"];
    });
    return shareInstance;
}

- (instancetype)HTTPResponseSerializer {
    shareInstance.responseSerializer = [AFHTTPResponseSerializer serializer];
    return self;
}
- (instancetype)JSONResponseSerializer {
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/xml",@"text/html", nil];
    serializer.removesKeysWithNullValues = YES;
    shareInstance.responseSerializer = serializer;
    return self;
}

- (instancetype)cookie{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@""]];
    NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    if (headers.allKeys.count != 0) {
        [shareInstance.requestSerializer setValue:headers.allValues[0] forHTTPHeaderField:headers.allKeys[0]];
    }
    return self;
}

- (instancetype)noCookie{
    [shareInstance.requestSerializer setValue:@"" forHTTPHeaderField:@"Cookie"];
    return self;
}


#pragma mark -- Public

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                       cookie:(BOOL)cookie
                     progress:(void (^)(NSProgress *))downloadProgress
                      success:(void (^)(id _Nullable))success
                      failure:(void (^)(NSError *))failure{
    YSMSessionManager *manager = [YSMSessionManager shared];
    [manager JSONResponseSerializer];
    if (cookie) {
        [manager cookie];
    }else{
        [manager noCookie];
    }
    YSMLog(@"\n---------【Request】--------\n %@",URLString);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    return [manager GET:URLString
      parameters:parameters
        progress:downloadProgress
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             YSMLog(@"\n----------[Success Response]-----------\n %@ \n%@",task.originalRequest.URL, responseObject);
             success(responseObject);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             YSMLog(@"\n----------[Failure Response]-----------\n %@ \n %@ \n %@",error,task.response,task.originalRequest.URL);
             failure(error);
         }];
}

+ (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                 cookie:(BOOL)cookie
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(id _Nullable responseObject))success
                                failure:(nullable void (^)(NSError *error))failure{
    YSMSessionManager *manager = [YSMSessionManager shared];
    [manager JSONResponseSerializer];
    if (cookie) {
        [manager cookie];
    }else{
        [manager noCookie];
    }
    YSMLog(@"\n---------【Request】--------\n %@",URLString);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    return [manager POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        YSMLog(@"\n----------[Success Response]-----------\n %@ \n%@",task.originalRequest.URL, responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        YSMLog(@"\n----------[Failure Response]-----------\n %@ \n %@ \n %@",error,task.response,task.originalRequest.URL);
        failure(error);
    }];
}



@end
