//
//  XXRealmPersonModel.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/20.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXRealmPersonModel.h"

@implementation XXRealmPersonModel
//主键
+ (NSString *)primaryKey {
    return @"id";
}

/*
 另外Realm提供了以下几个方法供对属性进行自定义：
 
 1） + (NSArray *)indexedProperties; : 可以被重写来来提供特定属性（property）的属性值（attrbutes）例如某个属性值要添加索引。
 
 2） + (NSDictionary *)defaultPropertyValues; : 为新建的对象属性提供默认值。
 
 3） + (NSString *)primaryKey; : 可以被重写来设置模型的主键。定义主键可以提高效率并且确保唯一性。
 
 4） + (NSArray *)ignoredProperties; ：可以被重写来防止Realm存储模型属性。
 */

@end
