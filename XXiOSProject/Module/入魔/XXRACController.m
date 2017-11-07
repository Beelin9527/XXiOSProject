//
//  XXRACController.m
//  XXiOSProject
//
//  Created by Beelin on 2017/10/7.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "XXRACController.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface XXRACController ()
@property (nonatomic, strong)  RACSignal *singanl;
@property (nonatomic, strong) RACCommand *command;
@end

@implementation XXRACController

- (void)viewDidLoad {
    [super viewDidLoad];
  
//    [self replaySignal];
//    [self subject];
    [self commamdTest];
    [self.command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"last:%@",x);
    }];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 100, 30, 30);
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
}

- (void)testAction {
//    [self.singanl subscribeNext:^(id  _Nullable x) {
//        NSLog(@"last:%@",x);
//    }];
//    [self.singanl subscribeNext:^(id  _Nullable x) {
//        NSLog(@"last:%@",x);
//    }];
    
   
    [self.command execute:nil];
}

#pragma mark - 操作方法之组合
- (void)concat {
    //按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号。
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@2];
        return nil;
    }];
    
    // 把signalA拼接到signalB后，signalA发送完成，signalB才会被激活。
    RACSignal *concatSignal = [signalA concat:signalB];
    // 以后只需要面对拼接信号开发。
    // 订阅拼接的信号，不需要单独订阅signalA，signalB
    // 内部会自动订阅。
    // 注意：第一个信号必须发送完成，第二个信号才会被激活
    [concatSignal subscribeNext:^(id x) {
        //1, 2
        NSLog(@"%@",x);
    }];
}

- (void)then {
    //用于连接两个信号，当第一个信号完成，才会连接then返回的信号。
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@2];
            return nil;
        }];
    }] subscribeNext:^(id x) {
        // 只能接收到第二个信号的值，也就是then返回信号的值
        NSLog(@"%@", x);
    }];
}

- (void)merge {
    //把多个信号合并为一个信号，任何一个信号有新值的时候就会调用。
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
            [subscriber sendNext:@1];
        }];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@2];
        return nil;
    }];
    
    // 合并信号,任何一个信号发送数据，都能监听到.
    RACSignal *mergeSignal = [signalA merge:signalB];
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

- (void)zipWith {
    //把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件。
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
            [subscriber sendNext:@1];
        }];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@2];
        return nil;
    }];
    // 压缩信号A，信号B,包装成元组发出
    RACSignal *zipSignal = [signalA zipWith:signalB];
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

- (void)combineLatest {
    //将多个信号合并起来，并且拿到各个信号的最新的值，必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号。
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@2];
        return nil;
    }];
    // 把两个信号组合成一个信号,跟zip一样，没什么区别
    RACSignal *combineSignal = [signalA combineLatestWith:signalB];
    [combineSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

- (void)reduce {
    //聚合:用于信号发出的内容是元组，把信号发出元组的值聚合成一个值。
    //常见的用法，（先组合在聚合）。combineLatest:(id<NSFastEnumeration>)signals reduce:(id (^)())reduceBlock
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@2];
        return nil;
    }];
    RACSignal *reduceSignal = [RACSignal combineLatest:@[signalA,signalB] reduce:^id(NSNumber *num1 ,NSNumber *num2){
        return [NSString stringWithFormat:@"%@ %@",num1,num2];
    }];
    [reduceSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

#pragma mark - 操作方法的过滤
- (void)filter {
    //过滤信号，使用它可以获取满足条件的。根据block逻辑返回真时才能继续发送信号。
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    
    [[signal filter:^BOOL(id  _Nullable value) {
        return value > 0;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)ignore {
    //忽略完某些值的信号。内部调用filter过滤，忽略掉ignore的值。
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    
    [[signal ignore:@1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)distinctUntilChanged {
    //当上一次的值和当前的值有明显的变化就会发出信号，否则会被忽略掉。在开发中，刷新UI经常使用，只有两次数据不一样才需要刷新。
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendNext:@2];
        [subscriber sendNext:@3];
        return nil;
    }];
    
    [[signal distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)take {
    //从开始一共取N次的信号。
    RACSubject *signal = [RACSubject subject];
    
    [[signal take:1] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [signal sendNext:@1];
    [signal sendNext:@2];
}

- (void)takeLast {
    //取最后N次的信号，前提条件，订阅者必须调用完成，因为只有完成，就知道总共有多少信号。
    RACSubject *signal = [RACSubject subject];

    [[signal takeLast:1] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
  
    [signal sendNext:@1];
    [signal sendNext:@2];
    [signal sendCompleted];

}

- (void)takeUntil {
    //获取信号直到某个信号执行完成。
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    [[signal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //执行到block中的内容位YES停止
    [[signal takeUntilBlock:^BOOL(id  _Nullable x) {
        return NO;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
}

- (void)takeWhileBlock {
    //当符合block逻辑时返回yes，订阅者才接收
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    
    [[signal takeWhileBlock:^BOOL(id  _Nullable x) {
        return YES;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)skip {
    //跳过几个信号，不接受(表示输入第一次，不会被监听到，跳过第一次发出的信号)。
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendNext:@3];
        return nil;
    }];
    [[signal skip:1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    /*
     skipWhileBlock
     当符合block逻辑时跳过。
     
     skipUntilBlock
     直到block逻辑停止跳过。
     */
}

- (void)switchToLatest {
    //用于signalOfSignals（信号的信号），有时候信号也会发出信号，会在signalOfSignals中，获取signalOfSignals发送的最新信号。
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    [signalOfSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [signalOfSignals sendNext:signal];
    [signal sendNext:@1];
}

#pragma mark - 操作方法之秩序
- (void)doNext {
    //执行Next之前，会先执行这个Block
}

- (void)doCompleted {
    //执行sendCompleted之前，会先执行这个Block
}

#pragma mark - 操作方法之线程
- (void)deliverOn {
    //内容传递切换到制定线程中，副作用在原来线程中，把在创建信号时block中的代码称之为副作用。
}

- (void)subscribeOn {
    //内容传递和副作用都会切换到制定线程中。
}

#pragma mark - 操作方法之时间
- (void)timeout {
    //超时，可以让一个信号在一定的时间后，自动报错。
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return nil;
    }] timeout:1 onScheduler:[RACScheduler currentScheduler]];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    } error:^(NSError *error) {
        // 1秒后会自动调用
        NSLog(@"%@",error);
    }];
}

- (void)interval {
    //定时：每隔一段时间发出信号。
    [[RACSignal interval:1 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

- (void)delay {
    //延迟发送next。
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }] delay:2] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

#pragma mark - 操作方法之重复
- (void)retry {
    //重试：只要失败，就会重新执行创建信号中的block，直到成功。
    __block int i = 0;
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (i == 10) {
            [subscriber sendNext:@1];
        } else {
            NSLog(@"接收到错误");
            [subscriber sendError:nil];
        }
        i++;
        return nil;
    }] retry] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    } error:^(NSError *error) {
    }];
}

- (void)replaySignal {
    //重放：当一个信号被多次订阅，反复播放内容。
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        return nil;
    }] replay];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅者%@",x);
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第二个订阅者%@",x);
    }];
}

- (void)throttle {
    //截流:当某个信号发送比较频繁时，可以使用节流，在某一段时间不发送信号内容，过了一段时间获取信号的最新内容发出。
    //常用于即时搜索优化，防止频繁发出请求。
    RACSubject *signal = [RACSubject subject];
    // 截流，在一定时间（0.3秒）内，不接收任何信号内容，过了这个时间（0.3秒）获取最后发送的信号内容发出。
    [[signal throttle:0.3] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}
#pragma mark - 热信号
- (void)subject1 {
    // RACBehaviorSubject 0 1 1 1 不在乎订阅时机，有默认值
//    RACBehaviorSubject *subject = [RACBehaviorSubject behaviorSubjectWithDefaultValue:@0];
    
    // RACReplaySubject 不在乎订阅时机
//    RACReplaySubject *subject = [RACReplaySubject subject];
    
    // RACSubject 在乎订阅时机
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"1st Sub: %@", x);
    }];
    [subject sendNext:@1];
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"2nd Sub: %@", x);
    }];
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"3rd Sub: %@", x);
    }];
//     [subject sendNext:@1];
    [subject sendCompleted];
}

#pragma mark - 多播
- (void)publish {
    RACMulticastConnection *connection = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"Send Request");
        [subscriber sendNext:@(1)];
        return nil;
    }] publish];
    
   
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"product: %@", x);
    }];

    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"productId: %@", x);
    }];
    
    [connection connect];
}

- (void)multicast {
    /* multicast 等同于
     RACSignal *signal = [[RACSignal createSignal:...] replay];
     */
    RACMulticastConnection *connection = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"Send Request");
        [subscriber sendNext:@(1)];
        return nil;
    }] multicast:[RACReplaySubject subject]];
    
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"product: %@", x);
    }];
    [connection connect];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"productId: %@", x);
    }];
    [connection connect];
}

- (void)subjectTest {
    RACSubject *letters = [RACSubject subject];
    RACSignal *signal = [letters replay];
//    RACSignal *signal = [letters replayLast];
//    RACSignal *signal = [letters replayLazily];
    
    NSLog(@"Subscribe S1");
    [signal subscribeNext:^(id x) {
        NSLog(@"S1: %@", x);
    }];
    
    NSLog(@"Send A");
    [letters sendNext:@"A"];
    NSLog(@"Send B");
    [letters sendNext:@"B"];
    
    NSLog(@"Subscribe S2");
    [signal subscribeNext:^(id x) {
        NSLog(@"S2: %@", x);
    }];
    
    NSLog(@"Send C");
    [letters sendNext:@"C"];
    NSLog(@"Send D");
    [letters sendNext:@"D"];
    
    NSLog(@"Subscribe S3");
    [signal subscribeNext:^(id x) {
        NSLog(@"S3: %@", x);
    }];
}

- (void)replay {
    /*
     Subscribe S1
     
     Send A
     S1: A
     
     Send B
     S1: B
     
     Subscribe S2
     S2: A
     S2: B
     
     Send C
     S1: C
     S2: C
     
     Send D
     S1: D
     S2: D
     
     Subscribe S3
     S3: A
     S3: B
     S3: C
     S3: D
     */
}

- (void)replayLast {
    /*
     Subscribe S1
     
     Send A
     S1: A
     
     Send B
     S1: B
     
     Subscribe S2
     S2: B
     
     Send C
     S1: C
     S2: C
     
     Send D
     S1: D
     S2: D
     
     Subscribe S3
     S3: D
     */
}

- (void)replayLazily {
    /*
     Subscribe S1
     
     Send A
     S1: A
     
     Send B
     S1: B
     
     Subscribe S2
     S2: A
     S2: B
     
     Send C
     S1: C
     S2: C
     
     Send D
     S1: D
     S2: D
     
     Subscribe S3
     S3: A
     S3: B
     S3: C
     S3: D
     */
}

#pragma mark -
- (void)singanlTest {
    __block int i = 0;
    _singanl = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        i ++;
        [subscriber sendNext:@(i)];
        return nil;
    }] replayLazily];
    
    [_singanl subscribeNext:^(id  _Nullable x) {
        NSLog(@"s1: %@",x);
    }];
    [_singanl subscribeNext:^(id  _Nullable x) {
        NSLog(@"s2: %@",x);
    }];
}

#pragma mark -
- (void)commamdTest {
    _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        __block int i = 0;
       return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            i ++;
            [subscriber sendNext:@(i)];
            return nil;
        }];
    }];
    
}
@end
