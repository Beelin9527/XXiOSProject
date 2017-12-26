//
//  XXCollectionViewController.m
//  XXiOSProject
//
//  Created by Beelin on 2017/12/25.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXCollectionViewController.h"

#import "XXCollectionViewLayout.h"

static NSString *cellId = @"cellId";

@interface XXCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *heightArray;
@end

@implementation XXCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor whiteColor];
//    _heightArray = @[@100.0f, @150.0f, @200.0f, @130.0f, @120.0f, @150.0f, @200.0f, @130.0f, @120.0f,@180.0f];
    [self.view addSubview: self.collectionView];
}

#pragma - mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}
#pragma - mark UICollectionViewDelegate

#pragma - mark Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        XXCollectionViewLayout *layout = [[XXCollectionViewLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(100, 100);
        
        CGRect f = CGRectMake(0, 100, self.view.frame.size.width, 150);
        _collectionView  = [[UICollectionView alloc] initWithFrame:f collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    }
    return _collectionView;
}

@end
