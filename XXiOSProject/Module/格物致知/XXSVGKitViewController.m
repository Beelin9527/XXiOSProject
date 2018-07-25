//
//  XXSVGKitViewController.m
//  XXiOSProject
//
//  Created by Beelin on 2018/7/25.
//  Copyright © 2018年 xx. All rights reserved.
//

#import "XXSVGKitViewController.h"
#import "SVGKit.h"
#import "SVGKImage.h"
#import "SVGKParser.h"
#import "UIImage+XXColor.h"
#import "UIImage+svgImage.h"

@interface XXSVGKitViewController ()

@end

@implementation XXSVGKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *svgName = @"follow.svg";
    NSString *svgPath = [[NSBundle mainBundle] pathForResource:svgName ofType:nil];
    NSData *svgData = [NSData dataWithContentsOfFile:svgPath];
    NSString *reasourcePath = [[NSBundle mainBundle] resourcePath];
    NSURL *baseUrl = [[NSURL alloc] initFileURLWithPath:reasourcePath isDirectory:true];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(100, 70, 200, 200);
    [webView loadData:svgData MIMEType:@"image/svg+xml" textEncodingName:@"UTF-8" baseURL:baseUrl];
    [self.view addSubview:webView];
    
    // 更改层级颜色可以通过遍历，判断是否CAShapeLayer的类型
    SVGKImage *svgImage = [SVGKImage imageNamed:@"Camera.svg"];
    
    int count = 0;
    for (CALayer *layer in svgImage.CALayerTree.sublayers) {
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            CAShapeLayer *sl = (CAShapeLayer*)layer;
            
            if (count == 0) {
                [sl setFillColor:[UIColor redColor].CGColor];
                count = 1;
            } else {
                [sl setFillColor:[UIColor greenColor].CGColor];
            }
        }
        
        for (CALayer *layerSub in layer.sublayers) {
            if ([layerSub isKindOfClass:[CAShapeLayer class]]) {
                CAShapeLayer *sl = (CAShapeLayer*)layerSub;
                
                if (count == 0) {
                    [sl setFillColor:[UIColor redColor].CGColor];
                    count = 1;
                } else {
                    [sl setFillColor:[UIColor greenColor].CGColor];
                }
            }
            for (CALayer *layerSubSub in layerSub.sublayers) {
                for (CALayer *layerSubSubSub in layerSubSub.sublayers) {
                    if ([layerSubSubSub isKindOfClass:[CAShapeLayer class]]) {
                        CAShapeLayer *sl = (CAShapeLayer*)layerSubSubSub;
                        
                        if (count == 0) {
                            [sl setFillColor:[UIColor redColor].CGColor];
                            count = 1;
                        } else {
                            [sl setFillColor:[UIColor greenColor].CGColor];
                        }
                    }
                }
                
            }
        }
        
        
    }
    SVGKImageView *imv = [[SVGKFastImageView alloc] initWithFrame:CGRectMake(0, 100, 300, 300)];
    imv.image = svgImage;
    imv.clipsToBounds = YES;
    [self.view addSubview:imv];
    
    
    //    SVGKImage *svgImage = [SVGKImage imageNamed:@"follow.svg"];
    //    UIImage *image = [svgImage.UIImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //    SVGKImageView *myImageView = [[SVGKFastImageView alloc] initWithSVGKImage: svgImage];
    //    myImageView.frame = CGRectMake(100, 300, 200, 200);
    //    myImageView.tintColor = [UIColor redColor];
    //    UIImage *image = [UIImage svgImageNamed:@"Camera.svg" size:CGSizeMake(300, 300) tintColor:[UIColor redColor]];
    //
    //
    //    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 300, 300)];
    //    imv.image = image;//[SVGKImage imageNamed:@"home-sketch.svg"].UIImage;
    //
    //    [self.view addSubview: imv];
    
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
