//
//  UINavigationController+XXBackItem.m
//  XXCategory
//
//  Created by Beelin on 2017/10/13.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "UINavigationController+XXBackItem.h"
#import <objc/runtime.h>
#import "XXSwizzlingDefine.h"
@implementation UINavigationController (XXBackItem)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzling_exchangeMethod(self, @selector(pushViewController:animated:), @selector(xx_pushViewController:animated:));
    });
}

- (void)xx_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    viewController.navigationItem.backBarButtonItem = item;
    [self xx_pushViewController:viewController animated:animated];
}
@end
