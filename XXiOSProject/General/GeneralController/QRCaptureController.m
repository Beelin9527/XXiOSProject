//
//  QRCaptureController.m
//  baicaotang
//
//  Created by Beelin on 2017/12/6.
//  Copyright © 2017年 Beelin. All rights reserved.
//

#import "QRCaptureController.h"

#import <AVFoundation/AVFoundation.h>

#define M_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define M_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define  M_RECT_HEIGHT(number)         (M_SCREEN_WIDTH / 375.0) * number

@interface QRCaptureController () <AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layer;
@property (weak, nonatomic) UIImageView *animationLine;
@property (strong, nonatomic) CAKeyframeAnimation *keyFrameAnimatio;

@end

@implementation QRCaptureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_return_normal"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    [self setUpQRCodeInterface];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(albumButtonDidClick)];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.session startRunning];
//    [self.animationLine.layer addAnimation:self.keyFrameAnimatio forKey:@"lineAnimation"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupQRUI
{
    // 设置扫描二维码界面
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, M_SCREEN_WIDTH, M_SCREEN_HEIGHT)];
    imageView.image = [UIImage imageNamed:@"general_scan"];
    
    UIImageView *animationLine = [[UIImageView alloc] initWithFrame:CGRectMake(M_SCREEN_WIDTH /2.0 - M_RECT_HEIGHT(250)/2.0, M_RECT_HEIGHT(90),M_RECT_HEIGHT(250), 14/2.0)];
    _animationLine = animationLine;
    animationLine.image = [UIImage imageNamed:@"general_scanning_line"];
    
    [self.view addSubview:imageView];
    [self.view addSubview:animationLine];
    
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    self.keyFrameAnimatio = keyFrameAnimation;
    keyFrameAnimation.keyPath = @"position";
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(animationLine.center.x, M_RECT_HEIGHT(100))];
    [path addLineToPoint:CGPointMake(animationLine.center.x, M_RECT_HEIGHT(300))];
    [path addLineToPoint:CGPointMake(animationLine.center.x, M_RECT_HEIGHT(100))];
    keyFrameAnimation.path = path.CGPath;
    
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    keyFrameAnimation.duration = 6.0;
    keyFrameAnimation.repeatCount = MAXFLOAT;
    [animationLine.layer addAnimation:keyFrameAnimation forKey:@"lineAnimation"];
}


- (void)setUpQRCodeInterface{
    
    // 获取 AVCaptureDevice 实例
    NSError * error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 初始化输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.localizedFailureReason delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
        
    }
    // 创建会话
    _session = [[AVCaptureSession alloc] init];
    // 添加输入流
    [_session addInput:input];
    // 初始化输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
//    [captureMetadataOutput setRectOfInterest:CGRectMake(200 / M_SCREEN_HEIGHT,95 / M_SCREEN_WIDTH, 800 / M_SCREEN_HEIGHT,560 / M_SCREEN_WIDTH)];
    
    // 添加输出流
    [_session addOutput:captureMetadataOutput];
    
    // 创建dispatch queue.
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 设置元数据类型 AVMetadataObjectTypeQRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // 创建输出对象
    AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
    // 开始会话
    [_session startRunning];
    //设置QR UI
    [self setupQRUI];
    
}

#pragma mark - 实现output的回调方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        
        if (object.stringValue.length > 0) {
            [self.session stopRunning];
            [self.animationLine.layer removeAnimationForKey:@"lineAnimation"];
            !self.scancResultBlock ?: self.scancResultBlock(object.stringValue);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        NSLog(@"未扫描到结果");
    }
}



#pragma mark - Event Response

//- (void)albumButtonDidClick {
//    [[DWDPrivacyManager shareManger] needPrivacy:DWDPrivacyTypePhotoLibrary withController:self authorized:^{
//        UIImagePickerController *imagePiker = [[UIImagePickerController alloc] init];
//        //        imagePiker.allowsEditing = YES;
//        imagePiker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        imagePiker.delegate = self;
//        [self presentViewController:imagePiker animated:YES completion:nil];
//    }];
//}
//
//#pragma mark - UIImagePickerControllerDelegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    NSString *msg = [NSString messageWithImage:image];
//    if (msg != nil) {
//        [DWDQRClient requestAnalysisWithQRInfo:msg controller:self];
//    }
//}

@end
