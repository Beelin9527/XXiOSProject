//
//  QRCaptureController.h
//  baicaotang
//
//  Created by Beelin on 2017/12/6.
//  Copyright © 2017年 Beelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCaptureController : UIViewController
@property (copy, nonatomic) void(^scancResultBlock)(NSString *result);
@end
