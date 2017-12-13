//
//  UIViewController+XXShowCameraSheet.h
//  XXCategory
//
//  Created by Beelin on 17/7/15.
//  Copyright © 2017年 xx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XXShowCameraSheet) <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

- (UIAlertController *)xx_showCameraSheetDidFinishBlock:(void(^)(NSDictionary<NSString *,id> *info))block;
- (UIAlertController *)xx_showCameraSheetWithTintColor:(UIColor *)color
                                        didFinishBlock:(void(^)(NSDictionary<NSString *,id> *info))block;
@end
