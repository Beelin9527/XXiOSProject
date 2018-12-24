//
//  XFInteractiveTransition.h
//  Community
//
//  Created by Beelin on 2018/11/19.
//  Copyright © 2018年 ThinkFly. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XFInteractiveTransitionDirection) {
    XFInteractiveTransitionDirectionLeft,
    XFInteractiveTransitionDirectionRight,
    XFInteractiveTransitionDirectionUp,
    XFInteractiveTransitionDirectionDown
};

typedef NS_ENUM(NSUInteger, XFInteractiveTransitionType) {
    XFInteractiveTransitionTypePresent,
    XFInteractiveTransitionTypeDismiss,
    XFInteractiveTransitionTypePush,
    XFInteractiveTransitionTypePop
};

@interface XFInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, weak) UIViewController *vc;
@property (nonatomic, assign) BOOL interation;
@property (nonatomic, assign) XFInteractiveTransitionDirection direction;
@property (nonatomic, assign) XFInteractiveTransitionType type;

@property (nonatomic, copy) void(^presentBlock)();
@property (nonatomic, copy) void(^pushBlock)();
@property (nonatomic, copy) void(^GestureRecognizerStateEndedBlock)();

/// 通过这个方法给控制器的View添加相应的手势
- (void)addPanGestureForViewController:(UIViewController *)viewController;

/// 手势过渡的过程
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture;
@end

NS_ASSUME_NONNULL_END
