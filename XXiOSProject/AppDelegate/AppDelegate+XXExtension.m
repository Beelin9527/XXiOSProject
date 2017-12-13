//
//  AppDelegate+XXExtension.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/13.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "AppDelegate+XXExtension.h"

@implementation AppDelegate (XXExtension)
- (void)xx_navigationGlobalConfig {
    /*
     [[UINavigationBar appearance] setBackgroundImage:[UIImage xx_imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
     [[UINavigationBar appearance] setShadowImage:[UIImage xx_imageWithColor:M_COLOR_SEPRATOR]];
     [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"general_back"]];
     [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"general_back"]];
     [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
     */
}

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

