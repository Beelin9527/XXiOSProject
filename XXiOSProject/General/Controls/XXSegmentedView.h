//
//  XXSegmentedView.h
//  baicaotang
//
//  Created by Beelin on 2017/12/7.
//  Copyright © 2017年 Beelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXSegmentedView;
@protocol XXSegmentedViewDelegate <NSObject>
@optional
-(void)segmentedViewDidSelectButton:(UIButton*)sender;
@end


@interface XXSegmentedView : UIView

@property (nonatomic,strong) NSArray *arrayTitles;


@property (strong, nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) UIColor *normalColor;
@property (nonatomic,weak) id<XXSegmentedViewDelegate> delegate;

- (void)selectButtonAtIndex:(NSInteger)index;
@end
