//
//  NSString+XXJudeg.m
//  XXCategory
//
//  Created by Beelin on 17/8/1.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "NSString+XXJudeg.h"

@implementation NSString (XXJudeg)

- (BOOL)xx_isEmpty {
    if ([self isKindOfClass:[NSNull class]]) return YES;
    if ([self isEqual:[NSNull null]]) return YES;
    if (self.length == 0) return YES;
    
    return ({
        [self stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0;
    });
}


- (BOOL)xx_isMobilePhone {
    return [self compareRegex:@"^1([3-57-8])\\d{9}$"];
}


- (BOOL)xx_isTelephone {
    return [self compareRegex:@"((\\+[0-9]{2,4})?\\(?[0-9]+\\)?-?)?[0-9]{7,8}|([\\d]{3,13})"];
}


- (BOOL)xx_isEmail {
    return [self compareRegex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

#pragma mark - Execute Regex

- (BOOL)compareRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}
@end
