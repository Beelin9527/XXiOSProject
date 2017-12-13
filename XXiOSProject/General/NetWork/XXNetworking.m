//
//  XXNetworking.m
//  XXiOSProject
//
//  Created by Beelin on 2017/11/22.
//  Copyright © 2017年 Beelin. All rights reserved.
//

#import "XXNetworking.h"
#import "AFNetworking.h"


//超时时间
static const NSTimeInterval  kTimeoutInterval = 30;
static  NSString *baseUrl = @"http://wx.2mashi.com/AgencyAPI/api/Manager/";
static  NSString *kErrorMsg = @"网络异常，请稍候重试...";

#define M_STRING_IS_EMPTY(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

@interface XXNetworking ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation XXNetworking
+ (XXNetworking *)shareNetworking{
    static XXNetworking *request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[XXNetworking alloc] init];
        [request setupConfig];
    });
    return request;
}

#pragma mark - Config
- (void)setupConfig {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.timeoutIntervalForRequest = kTimeoutInterval;
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl] sessionConfiguration:sessionConfiguration];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",
                                                          @"text/plain",
                                                          @"text/json",
                                                          @"application/json",nil];
    [_manager.requestSerializer setTimeoutInterval: kTimeoutInterval];
}

#pragma mark - Get
- (NSURLSessionDataTask *)get:(NSString *)url
                       params:(NSDictionary *) params
                      success:(void (^)(id data))success
                      failure:(void (^)(NSString *errmsg, NSInteger errcode))failure
{
    return [self get:url params:params progress:nil success:success failure:failure];
}

- (NSURLSessionDataTask *)get:(NSString *)url
                       params:(NSDictionary *) params
                     progress:(void(^)(NSProgress * uploadProgress))progress
                      success:(void (^)(id data))success
                      failure:(void (^)(NSString *errmsg, NSInteger errcode))failure
{
    NSLog(@"\n----------\nurl: %@\nparams: %@\n----------", url, params);
    return [_manager GET:url parameters:params progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"\n----------\nresponseObject:%@\n-----------",responseObject);
                NSDictionary *responseDict = responseObject;
                id data = responseDict[@"data"];
                NSString *errmsg = responseDict[@"errmsg"];
                NSNumber *errcodeNum = responseDict[@"errcode"];
                NSInteger errcode = [errcodeNum integerValue];
                
                if (errcode == 200) {
                    success(data);
                } else {
                     failure(M_STRING_IS_EMPTY(errmsg) ? kErrorMsg : errmsg, errcode);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(kErrorMsg, -9527);
            }];
}

#pragma mark - Post
- (NSURLSessionDataTask *)post:(NSString *)url
                        params:(NSDictionary *)params
                       success:(void (^)(id data))success
                       failure:(void (^)(NSString *errmsg, NSInteger errcode))failure
{
    return [self post:url params:params progress:nil success:success failure:failure];
}

- (NSURLSessionDataTask *)post:(NSString *)url
                        params:(NSDictionary *)params
                      progress:(void(^)(NSProgress * uploadProgress))progress
                       success:(void (^)(id data))success
                       failure:(void (^)(NSString *errmsg, NSInteger errcode))failure
{
    NSLog(@"\n----------\nurl: %@\nparams: %@\n----------", url, params);
    return [_manager POST:url parameters:params progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n----------\nresponseObject:%@\n-----------",responseObject);
        NSDictionary *responseDict = responseObject;
        id data = responseDict[@"data"];
        NSString *errmsg = responseDict[@"errmsg"];
        NSNumber *errcodeNum = responseDict[@"errcode"];
        NSInteger errcode = [errcodeNum integerValue];
        
        if (errcode == 200) {
            success(data);
        } else {
            failure(M_STRING_IS_EMPTY(errmsg) ? kErrorMsg : errmsg, errcode);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(kErrorMsg, -9527);
    }];
    
}

/*-------------------------This is a line without dream-----------------------------*/

#pragma mark - 网络监听
/** 开始监听网络变化 */
- (void)startMonitoring
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //发出网络更改通知广播
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"" object:[NSNumber numberWithInt:status]];
    }];
    [reachabilityManager startMonitoring];
}
/** 停止监听网络状态 */
- (void)stopMonitoring{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

/** 是否有网 */
- (BOOL)isReachable {
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

/** 是否Wifi */
- (BOOL)isWifi {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

/** 是否2G|3G|4G */
- (BOOL)isWWAN {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

@end
