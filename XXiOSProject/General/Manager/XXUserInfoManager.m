//
//  XXUserInfoManager.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/26.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXUserInfoManager.h"

#import "YYModel.h"

#define M_PATH_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define M_PATH_USERINFO [M_PATH_DOCUMENT stringByAppendingPathComponent:@"userInfo"]

static XXUserInfoManager * _manager = nil;

@implementation XXUserInfoManager
#pragma mark - Public Method
+ (instancetype)sharedManager {
    if (!_manager) {
        //解档
        @synchronized(_manager){
            _manager = [NSKeyedUnarchiver unarchiveObjectWithFile:M_PATH_USERINFO];
            if (!_manager) {
                _manager = [[self alloc] init];
            }
        }
    }
    return _manager;
}

- (void)analyzingWithDict:(NSDictionary *)data {
    self.name = data[@"name"];
    
    [self archive];
}

- (void)archive {
    //归档
    [NSKeyedArchiver archiveRootObject:self toFile:M_PATH_USERINFO];
}

- (void)clearData {
    _manager = nil;
    
    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:M_PATH_USERINFO error:&error];
    NSLog(@"result: %d", result);
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder*)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

@end
