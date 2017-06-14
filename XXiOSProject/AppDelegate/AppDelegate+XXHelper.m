//
//  AppDelegate+XXHelper.m
//  XXiOSProject
//
//  Created by Beelin on 17/6/14.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "AppDelegate+XXHelper.h"

@implementation AppDelegate (XXHelper)
#pragma mark - 注册推送
- (void)xx_registerAPNs {
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)]) {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}
@end
