//
//  XXTabBarControllerManager.m
//  BaseFramework
//
//  Created by Mantis-man on 16/1/16.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "XXTabBarController.h"

#import "XXMyWorksController.h"
#import "XXStudyController.h"
#import "XXFrameworkController.h"
@implementation XXTabBarController

- (instancetype)init{
    if (self = [super init]) {
        XXMyWorksController *myWorkC = [[XXMyWorksController alloc]init];
        [self setupChildVc:myWorkC title:@"个人作品" image:nil selectedImage:nil];
        
        XXStudyController *studyC = [[XXStudyController alloc]init];
        [self setupChildVc:studyC title:@"个人学习" image:nil selectedImage:nil];
        
        XXFrameworkController *frameworkC = [[XXFrameworkController alloc] init];
        [self setupChildVc:frameworkC title:@"格物致知" image:nil selectedImage:nil];
        
        //设置未选中字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        //设置选中字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    }
    return self;
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.title = title;
    
    [vc.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
