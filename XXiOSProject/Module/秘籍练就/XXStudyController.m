//
//  XXStudyController.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/13.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXStudyController.h"

#import "XXCollectionViewController.h"

@interface XXStudyController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSDictionary *dict;

@end

@implementation XXStudyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = self.tableView;
}

#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dict.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = self.dict.allValues[indexPath.row];
    return cell;
}

#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *clsName = self.dict.allKeys[indexPath.row];
    Class cls = NSClassFromString(clsName);
    UIViewController *vc = [[cls alloc] init];
    vc.title = self.dict.allValues[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSDictionary *)dict {
    if (!_dict) {
        _dict = @{
                  NSStringFromClass([XXCollectionViewController class]) : @"CollectionView",
                  
                  };
    }
    return _dict;
}

@end

