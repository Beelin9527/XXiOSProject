//
//  XXBeelinMainController.m
//  XXiOSProject
//
//  Created by Beelin on 17/6/9.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXBeelinMainController.h"

#import "XXTestViewController.h"
#import <Lottie/Lottie.h>

@interface XXBeelinMainController ()
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) UIView *boxView;

@property (nonatomic, weak) NSString *target;
@end

@implementation XXBeelinMainController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    XXTestViewController *test = [[XXTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
//    [self initConfig];
    //
    //    [self addSubviews];
    //
    //    [self setupSubviewsFrame];
    //
    //    [self addObservers];
    //
    //    [self requestXXX];
    
//    dispatch_queue_t queue = dispatch_queue_create("parallel", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i < 1000000 ; i++) {
//        dispatch_async(queue, ^{
//            self.target = [NSString stringWithFormat:@"ksddkjalkjd%d",i];
//        });
//    }
    
//    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"123"];
//    [self.view addSubview:animation];
//    [animation playWithCompletion:^(BOOL animationFinished) {
//        // Do Something
//    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initConfig {
    //        self.title = @"";
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)addSubviews {
    [self.view addSubview:self.lab];
    [self.view addSubview:self.boxView];
    
    [self.view addSubview:({
        UILabel *lab = [UILabel new];
        lab.text = @"title";
        lab;
    })];
    
    [self.view addSubview:({
        UILabel *lab = [UILabel new];
        lab.text = @"title";
        lab;
    })];
    
    [self.view addSubview:({
        UILabel *lab = [UILabel new];
        lab.text = @"title";
        lab;
    })];
}

-(void)setupSubviewsFrame {
    
}

- (void)addObservers {
    
}
#pragma mark - Delegate

#pragma mark - Event Responser

#pragma mark - Observer Imp

#pragma mark - Request
- (void)requestXXX {
    
}
#pragma mark - public Method

#pragma mark - private Method
- (void)p_xx {
    
}

- (void)p_xxx {
    
}

#pragma mark - Setter

#pragma mark - Getter
- (UILabel *)lab {
    if (!_lab) {
        _lab = [UILabel new];
    }
    return _lab;
}

- (UIView *)boxView {
    if (!_boxView) {
        _boxView = [UIView new];
        
        //red view
        [_boxView addSubview:({
            UIView *redView = [UIView new];
            redView.backgroundColor = [UIColor redColor];
            redView;
        })];
        
        //green view
        [_boxView addSubview:({
            UIView *greenView = [UIView new];
            greenView.backgroundColor = [UIColor greenColor];
            greenView;
        })];
        
    }
    return _boxView;
}

@end
