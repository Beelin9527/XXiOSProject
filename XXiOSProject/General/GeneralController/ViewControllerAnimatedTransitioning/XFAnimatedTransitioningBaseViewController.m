//
//  XFAnimatedTransitioningBaseViewController.m
//  Community
//
//  Created by Beelin on 2018/11/28.
//  Copyright © 2018年 ThinkFly. All rights reserved.
//

#import "XFAnimatedTransitioningBaseViewController.h"
#import "XFAnimatedTransitioning.h"
#import "XFInteractiveTransition.h"

@interface XFAnimatedTransitioningBaseViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) XFAnimatedTransitioning *animatedTransitioning;
@property (nonatomic, strong) XFInteractiveTransition *interactiveDismiss;
@end

@implementation XFAnimatedTransitioningBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    [self.interactiveDismiss addPanGestureForViewController:self];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.animatedTransitioning.animatedTransitioningType = XFAnimatedTransitioningTypePresent;
    return self.animatedTransitioning;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animatedTransitioning.animatedTransitioningType = XFAnimatedTransitioningTypeDismiss;
    return self.animatedTransitioning;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
   return self.interactiveDismiss.interation ? self.interactiveDismiss : nil;
}

#pragma mark - Setter
- (void)setHeight:(CGFloat)height {
    _height = height;
    self.animatedTransitioning.toViewHeight = _height;
}

- (void)setMask:(BOOL)mask {
    _mask = mask;
    self.animatedTransitioning.mask = _mask;
}

- (void)setMaskColorWhiteAlpha:(CGFloat)maskColorWhiteAlpha {
    _maskColorWhiteAlpha = maskColorWhiteAlpha;
    self.maskColorWhiteAlpha = _maskColorWhiteAlpha;
}

#pragma mark - Getter
- (XFAnimatedTransitioning *)animatedTransitioning {
    if (!_animatedTransitioning) {
        _animatedTransitioning = [[XFAnimatedTransitioning alloc] init];
    }
    return _animatedTransitioning;
}

- (XFInteractiveTransition *)interactiveDismiss {
    if (!_interactiveDismiss) {
        _interactiveDismiss = [[XFInteractiveTransition alloc] init];
        _interactiveDismiss.type = XFInteractiveTransitionTypeDismiss;
        _interactiveDismiss.direction = XFInteractiveTransitionDirectionDown;
    }
    return _interactiveDismiss;
}
@end
