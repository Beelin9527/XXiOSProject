//
//  XXNetworking+RAC.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/29.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXNetworking+RAC.h"

@implementation XXNetworking (RAC)
- (RACSignal *)get:(NSString *)url
            params:(NSDictionary *) params {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
      NSURLSessionDataTask *task =  [self get:url params:params success:^(id data) {
            [subscriber sendNext:data];
            [subscriber sendCompleted];
        } failure:^(NSString *errmsg, NSInteger errcode) {
            NSError *error = [NSError errorWithDomain:NSLocalizedDescriptionKey code:errcode userInfo:@{@"errmsg": errmsg}];
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            // 如果被释放，则取消
            if (task && task.state != NSURLSessionTaskStateCompleted) {
                [task cancel];
            }
        }];
    }];
    return signal;
}

- (RACSignal *)post:(NSString *)url
             params:(NSDictionary *) params {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSURLSessionDataTask *task =  [self post:url params:params success:^(id data) {
            [subscriber sendNext:data];
            [subscriber sendCompleted];
        } failure:^(NSString *errmsg, NSInteger errcode) {
            NSError *error = [NSError errorWithDomain:NSLocalizedDescriptionKey code:errcode userInfo:@{@"errmsg": errmsg}];
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            // 如果被释放，则取消
            if (task && task.state != NSURLSessionTaskStateCompleted) {
                [task cancel];
            }
        }];
    }];
    return signal;
}
@end
