//
//  SVProgressHUD+XXExtension.h
//  XXiOSProject
//
//  Created by Beelin on 2017/12/13.
//  Copyright © 2017年 xx. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (XXExtension)
+ (void)xx_showText:(NSString *)text;
+ (void)xx_showText:(NSString *)text Complete:(void (^)(void))completeBlock;

+ (void)xx_showToast;
+ (void)xx_showToastWithText:(NSString *)text;
@end
