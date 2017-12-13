//
//  NSUserDefaults+XXHepler.m
//  XXCategory
//
//  Created by beelin on 2017/8/23.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "NSUserDefaults+XXHepler.h"

@implementation NSUserDefaults (XXHepler)
+ (void)xx_setObject:(id)object forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)xx_objectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)xx_setBool:(BOOL)b forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:b forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)xx_boolForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (void)xx_removeObjectForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}
@end
