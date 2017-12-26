//
//  XXGGChartController.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/23.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXGGChartController.h"


#import "LineData.h"
#import "LineDataSet.h"
#import "LineChart.h"


@interface XXGGChartController ()<UIScrollViewDelegate>

@property (nonatomic, strong) LineData * lineData1;
@property (nonatomic, strong) LineData * lineData2;

@property (nonatomic) LineChart *lineChart;
@property (strong, nonatomic) UIScrollView *scr;

@end

@implementation XXGGChartController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self test];
}

- (void)test {
    
    _lineData1 = [[LineData alloc] init];
    _lineData1.lineColor = __RGB_BLUE;
    _lineData1.scalerMode = ScalerAxisLeft;
    _lineData1.shapeRadius = 2;
    _lineData1.dataAry = @[@20.29, @-1.88, @1.46, @26.30, @3.66, @3.23, @-3.48, @-3.51, @-3.51, @-3.51,@1.29, @-1.88, @1.46, @-3.30, @3.66, @3.23, @-3.48, @-3.51];
    
    _lineData2 = [[LineData alloc] init];
    _lineData2.lineColor = __RGB_ORIGE;
    _lineData2.scalerMode = ScalerAxisRight;
    _lineData2.shapeRadius = 2;
    _lineData2.dataAry = @[@20.29, @-1.88, @1.46, @-3.30, @3.66, @3.23, @-3.48, @-33.51, @-3.51, @-13.51,@1.29, @-1.88, @1.46, @-3.30, @3.66, @3.23, @-3.48, @-3.51];
    
    LineDataSet *lineBarSet = [[LineDataSet alloc] init];
    lineBarSet.insets = UIEdgeInsetsMake(30, 40, 30, 40);;
    lineBarSet.lineAry =  @[_lineData1, _lineData2];
    lineBarSet.updateNeedAnimation = YES;
    
    
    lineBarSet.gridConfig.lineColor = [UIColor greenColor];//C_HEX(0xe4e4e4);
    lineBarSet.gridConfig.lineWidth = .5f;
    lineBarSet.gridConfig.axisLineColor =  [UIColor greenColor];//RGB(146, 146, 146);
    lineBarSet.gridConfig.axisLableColor = [UIColor greenColor];//RGB(146, 146, 146);
    
    lineBarSet.gridConfig.bottomLableAxis.lables = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    lineBarSet.gridConfig.bottomLableAxis.drawStringAxisCenter = YES;
    lineBarSet.gridConfig.bottomLableAxis.showSplitLine = YES;
    lineBarSet.gridConfig.bottomLableAxis.over = 2;
    lineBarSet.gridConfig.bottomLableAxis.showQueryLable = YES;
    
    lineBarSet.gridConfig.leftNumberAxis.splitCount = 4;
    lineBarSet.gridConfig.leftNumberAxis.dataFormatter = @"%.0f";
    lineBarSet.gridConfig.leftNumberAxis.showSplitLine = YES;
    lineBarSet.gridConfig.leftNumberAxis.showQueryLable = YES;
    
    lineBarSet.gridConfig.rightNumberAxis.splitCount = 4;
    lineBarSet.gridConfig.rightNumberAxis.dataFormatter = @"%.0f";
    lineBarSet.gridConfig.rightNumberAxis.showQueryLable = YES;
    
    _lineChart = [[LineChart alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 10, 300)];
    _lineChart.lineDataSet = lineBarSet;
    [_lineChart drawLineChart];
    
    
    
    _scr = [[UIScrollView alloc] init];
    _scr.frame = _lineChart.bounds;
    _scr.contentSize = _lineChart.gg_size;
    _scr.delegate = self;
    [_scr addSubview:_lineChart];
    
    //设置最大伸缩比例
    _scr.maximumZoomScale=2.0;
    //设置最小伸缩比例
    _scr.minimumZoomScale=1;
    
    
    [self.view addSubview:_scr];
    [_lineChart startAnimationsWithType:LineAnimationStrokeType duration:.8f];
}

//告诉scrollview要缩放的是哪个子控件
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _lineChart;
}
@end
