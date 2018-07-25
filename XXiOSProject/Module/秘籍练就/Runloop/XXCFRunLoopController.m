//
//  XXCFRunLoopController.m
//  XXiOSProject
//
//  Created by Beelin on 2018/7/20.
//  Copyright © 2018年 xx. All rights reserved.
//

#import "XXCFRunLoopController.h"

@interface XXCFRunLoopController ()

@end

@implementation XXCFRunLoopController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserverByRunloop];
}

static void Callback (CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    NSLog(@"Runloop callback");
}

- (void)addObserverByRunloop {
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopObserverContext context = {
        0,
        (__bridge void*)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    static CFRunLoopObserverRef defaultModeObserver;
    defaultModeObserver = CFRunLoopObserverCreate(NULL,kCFRunLoopBeforeWaiting,YES,NSIntegerMax-999, &Callback, &context);
    CFRunLoopAddObserver(runloop, defaultModeObserver,kCFRunLoopCommonModes);
    CFRelease(defaultModeObserver);
}
@end
