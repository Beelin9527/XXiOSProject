//
//  XXNetworking+RAC.h
//  XXiOSProject
//
//  Created by Beelin on 2017/12/29.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXNetworking.h"
#import "ReactiveObjC.h"

@interface XXNetworking (RAC)
- (RACSignal *)get:(NSString *)url
            params:(NSDictionary *) params;

- (RACSignal *)post:(NSString *)url
            params:(NSDictionary *) params;
@end
