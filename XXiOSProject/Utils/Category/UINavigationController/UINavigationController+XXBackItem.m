//
//  UINavigationController+XXBackItem.m
//  XXCategory
//
//  Created by Beelin on 2017/10/13.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "UINavigationController+XXBackItem.h"
#import <objc/runtime.h>
@implementation UINavigationController (XXBackItem)
+ (void)load {
    SEL originalSelector = @selector(pushViewController:animated:);
    SEL swizzledSelector = @selector(xx_pushViewController:animated:);
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    BOOL success = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


- (void)xx_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    
    viewController.navigationItem.backBarButtonItem = item;
    
    [self xx_pushViewController:viewController animated:animated];
    
    
}
@end
