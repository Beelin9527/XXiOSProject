//
//  XXUserInfoManager.h
//  XXiOSProject
//
//  Created by Beelin on 2017/12/26.
//  Copyright © 2017年 xx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXUserInfoManager : NSObject
@property (strong, nonatomic) NSString *name;

#pragma mark - Public Method
+ (instancetype)sharedManager;
- (void)analyzingWithDict:(NSDictionary *)data;
- (void)archive;
- (void)clearData;
@end
