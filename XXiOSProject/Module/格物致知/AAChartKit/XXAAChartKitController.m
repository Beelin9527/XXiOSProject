//
//  XXAAChartKitController.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/21.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXAAChartKitController.h"

#import "AAGlobalMacro.h"
#import "AAChartView.h"

@interface XXAAChartKitController ()
@property (strong, nonatomic) AAChartView * aaChartView;
@end

@implementation XXAAChartKitController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat chartViewWidth  = self.view.frame.size.width;
    CGFloat chartViewHeight = self.view.frame.size.height-250;
    self.aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 60, chartViewWidth, chartViewHeight)];
    //设置图表视图的内容高度(默认 contentHeight 和 AAChartView 的高度相同)
    //self.aaChartView.contentHeight = self.view.frame.size.height-250;
    [self.view addSubview:self.aaChartView];
    
    AAChartModel *chartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeLine)//设置图表的类型(这里以设置的为柱状图为例)
    .titleSet(@"编程语言热度")//设置图表标题
    .subtitleSet(@"虚拟数据")//设置图表副标题
    .categoriesSet(@[@"Java",@"Swift",@"Python",@"Ruby", @"PHP",@"Go",@"C",@"C#",@"C++"])//设置图表横轴的内容
    .yAxisTitleSet(@"摄氏度")//设置图表 y 轴的单位
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2017")
                 .dataSet(@[@45,@56,@34,@43,@65,@56,@47,@28,@49]),
                 
                 AAObject(AASeriesElement)
                 .nameSet(@"2018")
                 .dataSet(@[@11,@12,@13,@14,@15,@16,@17,@18,@19]),
                 
                 AAObject(AASeriesElement)
                 .nameSet(@"2019")
                 .dataSet(@[@31,@22,@33,@54,@35,@36,@27,@38,@39]),
                 
                 AAObject(AASeriesElement)
                 .nameSet(@"2020")
                 .dataSet(@[@21,@22,@53,@24,@65,@26,@37,@28,@49]),
                 ])
    ;
    
    /*图表视图对象调用图表模型对象,绘制最终图形*/
    [_aaChartView aa_drawChartWithChartModel:chartModel];
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
