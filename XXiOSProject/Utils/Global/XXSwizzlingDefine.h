//
//  XXSwizzlingDefine.h
//  XXiOSProject
//
//  Created by Beelin on 2017/11/27.
//  Copyright © 2017年 xx. All rights reserved.
//

#ifndef XXSwizzlingDefine_h
#define XXSwizzlingDefine_h

#import <objc/runtime.h>
static inline void swizzling_exchangeMethod(Class clazz ,SEL originalSelector, SEL swizzledSelector){
    Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(clazz, swizzledSelector);
    
    BOOL success = class_addMethod(clazz, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(clazz, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
#endif /* XXSwizzlingDefine_h */
