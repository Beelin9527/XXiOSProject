//
//  NSDate+XXExtension.m
//  baicaotang
//
//  Created by Beelin on 2017/11/27.
//  Copyright © 2017年 Beelin. All rights reserved.
//

#import "NSDate+XXExtension.h"

@implementation NSDate (XXExtension)

+ (NSString *)xx_today {
    NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
    _formatter.timeZone = [NSTimeZone systemTimeZone];
    _formatter.dateFormat = @"yyyy-MM-dd";
    NSString *today = [_formatter stringFromDate:[NSDate date]];
    return today;
}

+ (NSString *)xx_year {
    NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
    _formatter.timeZone = [NSTimeZone systemTimeZone];
    _formatter.dateFormat = @"yyyy";
    NSString *year = [_formatter stringFromDate:[NSDate date]];
    return year;
}

+ (NSString *)xx_month {
    NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
    _formatter.timeZone = [NSTimeZone systemTimeZone];
    _formatter.dateFormat = @"MM";
    NSString *month = [_formatter stringFromDate:[NSDate date]];
    return month;
}

+ (NSString *)xx_dateAndTime {
    NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
    _formatter.timeZone = [NSTimeZone systemTimeZone];
    _formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *date = [_formatter stringFromDate:[NSDate date]];
    return date;
}
@end
