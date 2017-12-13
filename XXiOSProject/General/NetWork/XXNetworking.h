//
//  LMSNetworking.h
//  XXiOSProject
//
//  Created by Beelin on 2017/11/22.
//  Copyright © 2017年 Beelin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXNetworking : NSObject
#pragma mark - 单例
+(instancetype)shareNetworking;

#pragma mark - GET
- (NSURLSessionDataTask *)get:(NSString *)url
                       params:(NSDictionary *) params
                      success:(void (^)(id data))success
                      failure:(void (^)(NSString *errmsg, NSInteger errcode))failure;
- (NSURLSessionDataTask *)get:(NSString *)url
                       params:(NSDictionary *) params
                     progress:(void(^)(NSProgress * uploadProgress))progress
                      success:(void (^)(id data))success
                      failure:(void (^)(NSString *errmsg, NSInteger errcode))failure;


#pragma mark - POST
- (NSURLSessionDataTask *)post:(NSString *)url
                        params:(NSDictionary *)params
                       success:(void (^)(id data))success
                       failure:(void (^)(NSString *errmsg, NSInteger errcode))failure;
- (NSURLSessionDataTask *)post:(NSString *)url
                        params:(NSDictionary *)params
                      progress:(void(^)(NSProgress * uploadProgress))progress
                       success:(void (^)(id data))success
                       failure:(void (^)(NSString *errmsg, NSInteger errcode))failure;

#pragma mark - 网络监听
/** 开始监听网络变化 */
- (void)startMonitoring;

/** 停止监听网络状态 */
- (void)stopMonitoring;

/** 是否有网 */
- (BOOL)isReachable;

/** 是否Wifi */
- (BOOL)isWifi;

/** 是否2G|3G|4G */
- (BOOL)isWWAN;
@end
