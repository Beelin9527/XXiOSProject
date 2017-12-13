//
//  XXSegmentedView.m
//  baicaotang
//
//  Created by Beelin on 2017/12/7.
//  Copyright © 2017年 Beelin. All rights reserved.
//

#import "XXSegmentedView.h"

@interface XXSegmentedView ()
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,strong) UIView *indexLine;

@property (assign, nonatomic) CGFloat buttonW;
@property (assign, nonatomic) CGFloat indexLineW;
@property (assign, nonatomic) CGFloat indexLineX;

@property (copy, nonatomic) NSMutableArray *buttonArray;
@end

@implementation XXSegmentedView

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size.height = 44;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void)setArrayTitles:(NSArray *)arrayTitles {
    if (!arrayTitles.count) return;
    
    self.buttonW = self.bounds.size.width/arrayTitles.count;
    self.indexLineW = self.buttonW/2.0;
    self.indexLineX = self.indexLineW/2.0;
    
    for (int i = 0; i < arrayTitles.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [btn setTitle:arrayTitles[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.normalColor ?: [UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedColor ?: [UIColor blackColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(licked:) forControlEvents:UIControlEventTouchDown];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.frame = CGRectMake(i*self.buttonW , 0, self.buttonW , self.bounds.size.height);
        [self addSubview:btn];
        
        if (i==0) {
            [self licked:btn];
        }
        
        
        //竖分隔线
        UIView *lineS = [[UIView alloc]init];
        lineS.frame = CGRectMake(self.buttonW *i , 12, 0.5, 20);
        lineS.backgroundColor  = [UIColor colorWithRed:(221)/255.0 green:(221)/255.0 blue:(221)/255.0 alpha:1.0];
        [self addSubview:lineS];
        
        [self.buttonArray addObject:btn];
    }
    
    //下标线
    UIView *indexLine = [[UIView alloc]init];
    self.indexLine = indexLine;
    self.indexLine.frame = CGRectMake(self.indexLineX, self.bounds.size.height-3,self.indexLineW, 3);
    indexLine.backgroundColor  = self.selectedColor ?: [UIColor grayColor];
    [self addSubview:indexLine];
    
    
    //横分隔线
    UIView *line = [[UIView alloc]init];
    line.frame = CGRectMake(0, self.bounds.size.height-0.5, self.bounds.size.width,0.5);
    line.backgroundColor  = [UIColor colorWithRed:(221)/255.0 green:(221)/255.0 blue:(221)/255.0 alpha:1.0];;
    [self addSubview:line];
    
}

-(void)licked:(UIButton*)sender {
    self.selectBtn.selected = NO;
    sender.selected = YES;
    self.selectBtn = sender;
    
    [UIView animateWithDuration:.25 animations:^{
        CGRect f = self.indexLine.frame;
        f.origin.x = CGRectGetMidX(sender.frame) - self.indexLineW/2.0;
        self.indexLine.frame = f;
    }];
 
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedViewDidSelectButton:)]) {
        [self.delegate segmentedViewDidSelectButton:sender];
    }
}

#pragma mark - Public Method
- (void)selectButtonAtIndex:(NSInteger)index {
    if (self.selectBtn.tag == index) {
        return;
    } else {
        UIButton *btn = [self.buttonArray objectAtIndex:index];
        [self licked:btn];
    }
}

#pragma mark - Getter
- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _buttonArray;
}
@end
