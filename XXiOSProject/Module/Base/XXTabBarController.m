//
//  XXTabBarController.m
//  BaseFramework
//
//  Created by Mantis-man on 16/1/16.
//  Copyright © 2016年 Mantis-man. All rights reserved.
//

#import "XXTabBarController.h"
#import "XXNavigationController.h"

#import "XXBeelinMainController.h"
#import "XXLucasMainController.h"
#import "XXHanlMainController.h"
@implementation XXTabBarController

- (instancetype)init{
    if (self = [super init]) {
       
        XXBeelinMainController *beelin = [[XXBeelinMainController alloc]init];
        [self setupChildVc:beelin title:@"beelin" image:nil selectedImage:nil];
        
        XXLucasMainController *lucas = [[XXLucasMainController alloc]init];
        [self setupChildVc:lucas title:@"lucas" image:nil selectedImage:nil];
        
        XXHanlMainController *hanl = [[XXHanlMainController alloc]init];
        [self setupChildVc:hanl title:@"hanl" image:nil selectedImage:nil];
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
    
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    XXNavigationController *nav = [[XXNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
