//
//  AppDelegate+XXExtension.h
//  XXiOSProject
//
//  Created by Beelin on 2017/12/13.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (XXExtension)
/** 设置全局导航栏样式 */
- (void)xx_navigationGlobalConfig;

/** 注册推送 */
- (void)xx_registerAPNs;
@end
