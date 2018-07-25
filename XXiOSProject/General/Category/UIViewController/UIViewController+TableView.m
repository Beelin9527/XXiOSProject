//
//  UIViewController+TableView.m
//  HOHO
//
//  Created by Beelin on 2018/7/17.
//  Copyright © 2018年 ThinkFly. All rights reserved.
//

#import "UIViewController+TableView.h"
#import <objc/runtime.h>
#import "XXMacros.h"
@implementation UIViewController (TableView)

- (UITableView *)tableView {
    UITableView *tableView = objc_getAssociatedObject(self, @selector(tableView));
    if (!tableView) {
        // frame 可以重写，默认此frame
        CGRect frame = CGRectMake(0, M_TOPBAR_HEIGHT, M_SCREEN_WIDTH, M_SCREEN_HEIGHT - M_TOPBAR_HEIGHT);
        tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        
        // 设置代理，减少重复性写这两句代段，反正我懒。
        tableView.delegate = self;
        tableView.dataSource = self;
        
        // 懒
        tableView.tableFooterView = [[UIView alloc] init];

        //解决iOS11,SectionHeaderHeight与SectionFooterHeight失效问题。
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        
        // 解决 适配tableView 偏移20/64
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        // 关联
        objc_setAssociatedObject(self, @selector(tableView), tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        // 加入视图
        [self.view addSubview:tableView];
    }
    return tableView;
}

- (void)setTableView:(UITableView *)tableView {
    objc_setAssociatedObject(self, @selector(tableView), tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
