//
//  SVProgressHUD+XXExtension.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/13.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "SVProgressHUD+XXExtension.h"

@implementation SVProgressHUD (XXExtension)
+ (void)xx_showText:(NSString *)text {
    [SVProgressHUD xx_showText:text Complete:nil];
}

+ (void)xx_showText:(NSString *)text Complete:(void (^)(void))completeBlock {
    if (!text) return;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundLayerColor:[UIColor clearColor]];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.65]];
    [SVProgressHUD showImage:nil status:text];
    [SVProgressHUD dismissWithDelay:2 completion:completeBlock];
    [SVProgressHUD resetOffsetFromCenter];
}


+ (void)xx_showToast {
    [SVProgressHUD xx_showToastWithText:nil];
}

+ (void)xx_showToastWithText:(NSString *)text {
    [SVProgressHUD setForegroundColor:[UIColor redColor]];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setRingThickness:3];
    
    if(text && text.length)
        [SVProgressHUD showWithStatus:text];
    else
        [SVProgressHUD show];
}

@end
