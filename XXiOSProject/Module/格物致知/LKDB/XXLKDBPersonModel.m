//
//  XXLKDBPersonModel.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/23.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXLKDBPersonModel.h"

@implementation XXLKDBPersonModel
+(NSString *)getTableName {
    return @"tb_lkdbperson";
}

//主键
+ (NSString *)getPrimaryKey {
    return @"name";
}

//是否将父实体类的属性也映射到sqlite库表
+ (BOOL)isContainParent {
    return YES;
}  
@end
