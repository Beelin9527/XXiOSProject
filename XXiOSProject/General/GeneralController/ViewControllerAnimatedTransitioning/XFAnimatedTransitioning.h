//
//  XFAnimatedTransitioning.h
//  Community
//
//  Created by Beelin on 2018/11/28.
//  Copyright © 2018年 ThinkFly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XFAnimatedTransitioningType) {
    XFAnimatedTransitioningTypePresent,
    XFAnimatedTransitioningTypeDismiss,
};

@interface XFAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

/// 转场动效类型
@property (nonatomic, assign) XFAnimatedTransitioningType animatedTransitioningType;

/// 转场动效时长, 默认0.25
@property (nonatomic, assign) NSTimeInterval transitionDuration;

/// 转场to view 的高度， 默认设备屏高
@property (nonatomic, assign) CGFloat toViewHeight;

/// 蒙层显示, 默认：黑透明度0.5
@property (nonatomic, assign, getter=isMask) BOOL mask;

/// 蒙层透明度, 默认：黑透明度0.5
@property (nonatomic, assign) CGFloat maskColorWhiteAlpha;
@end

NS_ASSUME_NONNULL_END
