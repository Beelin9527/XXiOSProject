//
//  XFAnimatedTransitioningBaseViewController.h
//  Community
//
//  Created by Beelin on 2018/11/28.
//  Copyright © 2018年 ThinkFly. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface XFAnimatedTransitioningBaseViewController : UIViewController
/// 高度，默认高度：设备屏高
@property (nonatomic, assign) CGFloat height;

/// 蒙层显示, 默认：显示黑透明度0.5
@property (nonatomic, assign) BOOL mask;

/// 蒙层透明度, 默认：黑透明度0.5
@property (nonatomic, assign) CGFloat maskColorWhiteAlpha;
@end

NS_ASSUME_NONNULL_END
