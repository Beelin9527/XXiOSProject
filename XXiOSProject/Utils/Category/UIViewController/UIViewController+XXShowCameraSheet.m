//
//  UIViewController+XXShowCameraSheet.m
//  XXCategory
//
//  Created by Beelin on 17/7/15.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "UIViewController+XXShowCameraSheet.h"

#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>

@interface UIViewController ()
@property (nonatomic, strong) void(^finishblk)();
@end

@implementation UIViewController (XXShowCameraSheet)

#pragma mark - Associated Object
- (void)setFinishblk:(void (^)())finishblk {
    objc_setAssociatedObject(self, @selector(finishblk), finishblk, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)())finishblk {
   return  objc_getAssociatedObject(self, @selector(finishblk));
}

#pragma mark - Imp
- (UIAlertController *)xx_showCameraSheetDidFinishBlock:(void(^)(NSDictionary<NSString *,id> *info))block {
    return [self xx_showCameraSheetWithTintColor:nil didFinishBlock:block];
}

- (UIAlertController *)xx_showCameraSheetWithTintColor:(UIColor *)color
                                        didFinishBlock:(void(^)(NSDictionary<NSString *,id> *))block
{
    self.finishblk = block;
    UIImagePickerController *pc = [self createPickerController];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *shootAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        pc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pc animated:YES completion:^{
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == AVAuthorizationStatusRestricted ||
                authStatus ==AVAuthorizationStatusDenied) {
               [self alertTitle:@"请在手机的[设置]->[隐私]->[相机]中允许访问相机"];
            }
         
        }];
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        pc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pc animated:YES completion:^{
            PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
            if (authStatus == PHAuthorizationStatusRestricted ||
                authStatus == PHAuthorizationStatusDenied) {
                 [self alertTitle:@"请在手机的[设置]->[隐私]->[照片]中允许访问相册"];
            }
            
        }];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    if (color) {
        [shootAction setValue:color forKey:@"titleTextColor"];
        [albumAction setValue:color forKey:@"titleTextColor"];
        [cancelAction setValue:color forKey:@"titleTextColor"];
    }
    
    [alert addAction:shootAction];
    [alert addAction:albumAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    return alert;
}

#pragma mark - Create
- (UIImagePickerController *)createPickerController{
    UIImagePickerController *pc = [[UIImagePickerController alloc] init];
    pc.allowsEditing = YES;
    pc.delegate = self;
    return pc;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    !self.finishblk ?: self.finishblk();
    [self dismissViewControllerAnimated:picker completion:nil];
}

#pragma mark - Private
- (void)alertTitle:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *determine = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:determine];
    
    [self presentViewController:alert animated:YES completion:nil];
    return;
}
@end
