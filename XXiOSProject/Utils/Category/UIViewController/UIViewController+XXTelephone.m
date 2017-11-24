//
//  UIViewController+XXTelephone.m
//  XXCategory
//
//  Created by Beelin on 17/8/1.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "UIViewController+XXTelephone.h"
#import "NSString+XXJudeg.h"

@implementation UIViewController (XXTelephone)
- (void)xx_telephone:(NSString *)phoneNumber {
    if ([phoneNumber xx_isEmpty]) {
        NSString *message = @"找不到电话号码";
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        NSString *phoneStr = [[NSMutableString alloc] initWithFormat:@"tel://%@",phoneNumber];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:phoneNumber message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
#pragma clang diagnostic pop
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
