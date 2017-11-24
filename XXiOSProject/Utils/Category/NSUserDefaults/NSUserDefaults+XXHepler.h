//
//  NSUserDefaults+XXHepler.h
//  XXCategory
//
//  Created by beelin on 2017/8/23.
//  Copyright © 2017年 xx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (XXHepler)
+ (void)xx_setObject:(id)object forKey:(NSString *)key;

+ (id)xx_objectForKey:(NSString *)key;

+ (void)xx_setBool:(BOOL)b forKey:(NSString *)key;

+ (BOOL)xx_boolForKey:(NSString *)key;

+ (void)xx_removeObjectForKey:(NSString *)key;
@end
