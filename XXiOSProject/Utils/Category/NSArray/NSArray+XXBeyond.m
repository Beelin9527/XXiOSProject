//
//  NSArray+XXBeyond.m
//  XXiOSProject
//
//  Created by Beelin on 2017/11/24.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "NSArray+XXBeyond.h"
#import <objc/runtime.h>

@implementation NSArray (XXBeyond)

+ (void)load{
    [super load];
    //  替换不可变数组中的方法
    Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(xx_objectAtIndex:));
    method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
    //  替换可变数组中的方法
    Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(xx_mutableObjectAtIndex:));
    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
}

- (id)xx_objectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self xx_objectAtIndex:index];
        } @catch (NSException *exception) {
            //__throwOutException  抛出异常
            NSLog(@"数组越界...");
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self xx_objectAtIndex:index];
    }
}

- (id)xx_mutableObjectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self xx_mutableObjectAtIndex:index];
        } @catch (NSException *exception) {
            //__throwOutException  抛出异常
            NSLog(@"数组越界...");
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self xx_mutableObjectAtIndex:index];
    }
}

@end
