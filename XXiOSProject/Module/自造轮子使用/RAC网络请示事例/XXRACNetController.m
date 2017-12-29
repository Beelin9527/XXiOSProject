//
//  XXRACNetController.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/29.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXRACNetController.h"
#import "XXNetworking+RAC.h"

@interface XXRACNetController ()

@end

@implementation XXRACNetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
}

- (void)requestData {
    RACSignal *signal = [[XXNetworking shareNetworking] get:@"LoadFirstPoster" params:@{
                                                                                        @"firm_no": @"1001",
                                                                                        }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"success");
    } error:^(NSError * _Nullable error) {
        NSLog(@"error");
    }];
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
