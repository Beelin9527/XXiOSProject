//
//  XXTableView.h
//  baicaotang
//
//  Created by Beelin on 2017/11/27.
//  Copyright © 2017年 Beelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXTableView : UITableView
+ (instancetype)createTableViewWithFrame:(CGRect)frame;

+ (instancetype)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style;
@end
