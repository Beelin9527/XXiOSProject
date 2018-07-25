//
//  UIViewController+TableView.h
//  HOHO
//
//  Created by Beelin on 2018/7/17.
//  Copyright © 2018年 ThinkFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TableView) <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end
