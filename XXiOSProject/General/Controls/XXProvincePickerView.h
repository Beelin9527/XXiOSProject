//
//  XXProvincePickerView.h
//  PickerView
//
//  Created by Beelin on 2017/12/5.
//  Copyright © 2017年 WTC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)(NSString *province, NSString *city);
typedef void(^CancelBlock)(void);

@interface XXProvincePickerView : UIView
+ (void)provincePickerViewWithCompletion:(CompletionBlock)completionBlock cancel:(CancelBlock)cancelBlock;
@end
