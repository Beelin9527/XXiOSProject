//
//  XXTestViewController.m
//  XXiOSProject
//
//  Created by beelin on 2017/8/23.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXTestViewController.h"

@interface XXTestViewController ()
@property (nonatomic, strong) UIView *box;
@end

@implementation XXTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.edgesForExtendedLayout = UIRectEdgeNone;
    CGFloat top = 0;
    if (@available(iOS 11.0, *)) {
//        top  = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
       
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.box = [UIView new];
    self.box.backgroundColor = [UIColor orangeColor];
    self.box.frame = CGRectMake(0, top, 100, 100);
    [self.view addSubview:self.box];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.box = nil;
    });
}
- (void)dealloc {
    NSLog(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
