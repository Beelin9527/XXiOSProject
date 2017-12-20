//
//  XXRealmPersonModel.h
//  XXiOSProject
//
//  Created by Beelin on 2017/12/20.
//  Copyright © 2017年 xx. All rights reserved.
//

#import <Realm/Realm.h>

@interface XXRealmPersonModel : RLMObject
@property NSString *id;
@property  NSString *name;
@property  NSInteger age;
@end
RLM_ARRAY_TYPE(XXRealmPersonModel)
