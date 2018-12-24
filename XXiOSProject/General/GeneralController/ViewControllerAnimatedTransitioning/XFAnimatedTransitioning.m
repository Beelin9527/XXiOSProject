//
//  XFAnimatedTransitioning.m
//  Community
//
//  Created by Beelin on 2018/11/28.
//  Copyright © 2018年 ThinkFly. All rights reserved.
//

#import "XFAnimatedTransitioning.h"

@implementation XFAnimatedTransitioning
- (instancetype)init
{
    self = [super init];
    if (self) {
        _transitionDuration = 0.25;
        _toViewHeight = [UIScreen mainScreen].bounds.size.height;
        _mask = YES;
        _maskColorWhiteAlpha = 0.5;
    }
    return self;
}
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.animatedTransitioningType) {
        case XFAnimatedTransitioningTypePresent:
            [self presentAnimationWithTransitionContext:transitionContext];
            break;
        case XFAnimatedTransitioningTypeDismiss:
            [self dismissAnimationWithTransitionContext:transitionContext];
            break;
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

#pragma mark - Custom Animation Method
/// present 动画逻辑
- (void)presentAnimationWithTransitionContext:(nonnull id<UIViewControllerContextTransitioning>)transitionContextn {
    UIViewController *toViewController = [transitionContextn viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContextn viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 截图
    UIView *snapshotView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = fromViewController.view.frame;
    
    // 隐藏 fromViewController.view
    fromViewController.view.hidden = YES;
    
    // 蒙层
    UIView *mask = [[UIView alloc] init];
    mask.frame = fromViewController.view.frame;
    mask.backgroundColor = [UIColor colorWithWhite:0 alpha:self.maskColorWhiteAlpha];
    
    // 获取 containerView 管理器
    UIView *containerView = [transitionContextn containerView];
    [containerView addSubview:snapshotView];
    if (self.isMask) [containerView addSubview:mask];
    [containerView addSubview:toViewController.view];
    
    // 设置toViewController.view frame
    toViewController.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, self.toViewHeight);
    
    // 执行动画效果
    [UIView animateWithDuration:[self transitionDuration:transitionContextn] delay:0 options:0 animations:^{
        toViewController.view.transform = CGAffineTransformMakeTranslation(0, -self.toViewHeight);
    } completion:^(BOOL finished) {
        // 标记状态
        [transitionContextn completeTransition:![transitionContextn transitionWasCancelled]];
        
        //转场失败后的处理
        if ([transitionContextn transitionWasCancelled]) {
            fromViewController.view.hidden = NO;
            [snapshotView removeFromSuperview];
        }
    }];
}

/// dismiss 动画逻辑
- (void)dismissAnimationWithTransitionContext:(nonnull id<UIViewControllerContextTransitioning>)transitionContextn {
    // 注：与present相反，fromViewController是present时的toViewController
    UIViewController *toViewController = [transitionContextn viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContextn viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 截图
    UIView *snapshotView = [transitionContextn containerView].subviews[0];
    
    // 执行动画效果
    [UIView animateWithDuration:[self transitionDuration:transitionContextn] animations:^{
        fromViewController.view.transform = CGAffineTransformIdentity;
        snapshotView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if ([transitionContextn transitionWasCancelled]) {
            [transitionContextn completeTransition:NO];
        } else {
            [transitionContextn completeTransition:YES];
            toViewController.view.hidden = NO;
            snapshotView.hidden = YES;
        }
    }];
}
@end
