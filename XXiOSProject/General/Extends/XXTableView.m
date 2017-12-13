//
//  XXTableView.m
//  baicaotang
//
//  Created by Beelin on 2017/11/27.
//  Copyright © 2017年 Beelin. All rights reserved.
//

#import "XXTableView.h"

#define M_RGB_COLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define M_COLOR_BACKGROUND M_RGB_COLOR(245,245, 245)

@implementation XXTableView

+ (instancetype)createTableViewWithFrame:(CGRect)frame {
   return [XXTableView createTableViewWithFrame:frame style:UITableViewStylePlain];
}

+ (instancetype)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    XXTableView *tableview = [[XXTableView alloc] initWithFrame:frame style:style];
    tableview.backgroundColor = M_COLOR_BACKGROUND;
    tableview.tableFooterView = [UIView new];
   
    //解决iOS11,SectionHeaderHeight与SectionFooterHeight失效问题。
    tableview.estimatedRowHeight = 0;
    tableview.estimatedSectionHeaderHeight = 0;
    tableview.estimatedSectionFooterHeight = 0;
    
    return tableview;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self == [super initWithFrame:frame style:style]) {
        // tableView 偏移20/64适配
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        } 
    }
    return self;
}
@end
