//
//  XFInteractiveTransition
//  Community
//
//  Created by Beelin on 2018/11/19.
//  Copyright © 2018年 ThinkFly. All rights reserved.
//

#import "XFInteractiveTransition.h"

@implementation XFInteractiveTransition
/// 通过这个方法给控制器的View添加相应的手势
- (void)addPanGestureForViewController:(UIViewController *)viewController {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    //将传入的控制器保存，因为要利用它触发转场操作
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}

/// 关键的手势过渡的过程
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture {
    //手势百分比
    CGFloat percent = 0.0;
    switch (self.direction) {
        case XFInteractiveTransitionDirectionLeft:
        {
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            percent = transitionX / (panGesture.view.frame.size.width);
        }
            break;
        case XFInteractiveTransitionDirectionRight:
        {
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            percent = transitionX / (panGesture.view.frame.size.width);
        }
            break;
        case XFInteractiveTransitionDirectionUp:
        {
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            percent = transitionY / (panGesture.view.frame.size.width);
        }
            break;
        case XFInteractiveTransitionDirectionDown:
        {
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            percent = transitionY / (panGesture.view.frame.size.width);
        }
            break;
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件，它的作用在使用这个类的时候说明
            self.interation = YES;
            //手势开始是触发对应的转场操作，方法代码在后面
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置转场过程进行的百分比，然后系统会根据百分比自动布局控件，不用我们控制了
            [self updateInteractiveTransition:percent];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作，转场失败
            self.interation = NO;
            if (percent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            !self.GestureRecognizerStateEndedBlock ?: self.GestureRecognizerStateEndedBlock();
            break;
        }
        default:
            break;
    }
}
/// 触发对应转场操作的代码如下
- (void)startGesture{
    switch (self.type) {
        case XFInteractiveTransitionTypePresent:{
            if (self.presentBlock) {
                self.presentBlock();
            }
        }
            break;
            
        case XFInteractiveTransitionTypeDismiss:
            [self.vc dismissViewControllerAnimated:YES completion:nil];
            break;
        case XFInteractiveTransitionTypePush:{
            if (self.pushBlock) {
                self.pushBlock();
            }
        }
            break;
        case XFInteractiveTransitionTypePop:
            [self.vc.navigationController popViewControllerAnimated:YES];
            break;
    }
}
@end
