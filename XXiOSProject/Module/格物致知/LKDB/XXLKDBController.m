//
//  XXLKDBController.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/23.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXLKDBController.h"

#import "XXLKDBPersonModel.h"
#import "XXLKDBManager.h"


@interface XXLKDBController ()

@end

@implementation XXLKDBController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *document = [documentArray objectAtIndex:0];
    NSLog(@"pathc: %@", document);
    [self insert];
}

- (void)createTable {
   XXLKDBManager *manager = [[XXLKDBManager alloc] init];
   
}
- (void)insert {
    XXLKDBPersonModel *model = [[XXLKDBPersonModel alloc] init];
    model.name = @"Beelin";
    model.age = 27;
//    [model saveToDB];
    
    LKDBHelper *helper = [[LKDBHelper alloc] init];
    [helper insertToDB:model callback:^(BOOL result) {
        NSLog(@"...");
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
