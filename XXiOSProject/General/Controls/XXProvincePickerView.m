//
//  XXProvincePickerView.m
//  PickerView
//
//  Created by Beelin on 2017/12/5.
//  Copyright © 2017年 WTC. All rights reserved.
//

#import "XXProvincePickerView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define PICKER_HEIGHT   216

@interface XXProvincePickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIView *headView;

@property (strong, nonatomic) NSArray *dataSource;
@property (assign, nonatomic) NSInteger provinceIndex;
@property (assign, nonatomic) NSInteger cityIndex;

@property (strong, nonatomic) NSString *province;
@property (strong, nonatomic) NSString *ciyt;

@property (copy, nonatomic) CompletionBlock completionBlock;
@property (copy, nonatomic) CancelBlock cancelBlock;
@end

@implementation XXProvincePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self getSource];
        [self initUI];
    }
    return self;
}

+ (void)provincePickerViewWithCompletion:(CompletionBlock)completionBlock cancel:(CancelBlock)cancelBlock {
    XXProvincePickerView *pickerView = [[XXProvincePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    pickerView.completionBlock = completionBlock;
    pickerView.cancelBlock = cancelBlock;
    [[UIApplication sharedApplication].keyWindow addSubview:pickerView];
}

- (void)getSource {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"province" ofType:@"plist"];
    _dataSource = [[NSArray alloc] initWithContentsOfFile:path];
    
    _province = _dataSource[0][@"province"];
    _ciyt = _dataSource[0][@"cities"][0][@"city"];
}

- (void)initUI {
    _backView = [[UIView alloc] initWithFrame:self.frame];
    _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self addSubview:_backView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [_backView addGestureRecognizer:tap];
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.pickerView];
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, self.pickerView.frame.origin.y - 43.5, self.frame.size.width, 43.5)];
    _headView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 43.5, 43.5);
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.frame.size.width - 42, 0, 43.5, 43.5);
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(completionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:button];
    
    [self addSubview:_headView];
}

//- (void)show {
//    self.hidden = NO;
//    _backView.alpha = 0.6;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.pickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - PICKER_HEIGHT, self.frame.size.width, PICKER_HEIGHT);
//        _headView.frame = CGRectMake(0, self.pickerView.frame.origin.y - 43.5, self.frame.size.width, 43.5);
//    }];
//}

- (void)hide {
    _backView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.pickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height+44, self.frame.size.width, PICKER_HEIGHT);
        _headView.frame = CGRectMake(0, self.pickerView.frame.origin.y, self.frame.size.width, 43.5);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)completionButtonAction:(UIButton *)sender {
    
    
    if (self.completionBlock) {
        self.completionBlock(self.province, self.ciyt);
    }
    [self hide];
}

- (void)cancleButtonAction:(UIButton *)sender {
    [self hide];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0){
        return self.dataSource.count;
    }
    else {
        return [self.dataSource[self.provinceIndex][@"cities"] count];
    }
}

// 返回每一行的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0){
        return self.dataSource[row][@"province"];
    }
    else  {
        return self.dataSource[self.provinceIndex][@"cities"][row][@"city"];
    }
    
}


#pragma mark - UIPickerViewDelegate
// 滑动或点击选择，确认pickerView选中结果
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0){
        self.provinceIndex = row;
        self.cityIndex = 0;
        
        [self.pickerView reloadComponent:1];
        
        self.province =  self.dataSource[row][@"province"];
        self.ciyt = self.dataSource[row][@"cities"][0][@"city"];
        
    }
    else {
        self.cityIndex = row;
        
        self.ciyt = self.dataSource[self.provinceIndex][@"cities"][row][@"city"];
    }
    
    // 重置当前选中项
    [self resetPickerSelectRow];
}

#pragma mark - Getter
-(UIPickerView *)pickerView
{
    if(!_pickerView){
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - PICKER_HEIGHT, SCREEN_WIDTH, PICKER_HEIGHT)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
       
        
    }
    return _pickerView;
}

-(void)resetPickerSelectRow
{
    [self.pickerView selectRow:_provinceIndex inComponent:0 animated:YES];
    [self.pickerView selectRow:_cityIndex inComponent:1 animated:YES];
}
@end
