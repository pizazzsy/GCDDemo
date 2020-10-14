//
//  ViewController.m
//  GCDDemo
//
//  Created by linkcircle on 2020/9/23.
//  Copyright © 2020 linkcircle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self serialQueueFun];
//    [self concurrentQueueFun];
//    [self multipleSerialQueueFun];
    [self targetQueueFun];
    
}
///串行队列-----运行时间大概3秒
-(void)serialQueueFun{
    dispatch_queue_t serialQueue = dispatch_queue_create("queue_1", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        NSLog(@"任务1 begin");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"任务1 stop");
    });
    dispatch_async(serialQueue, ^{
        NSLog(@"任务2 begin");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"任务2 stop");
    });
    dispatch_async(serialQueue, ^{
        NSLog(@"任务3 begin");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"任务3 stop");
    });
}
///并行队列-----运行时间大概一秒
-(void)concurrentQueueFun{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("queue_2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"任务1.1 begin");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"任务1.2 stop");
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"任务2.1 begin");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"任务2.2 stop");
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"任务3.1 begin");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"任务3.2 stop");
    });
}
///多个SerialQueue是并行的-----运行时间大概一秒
-(void)multipleSerialQueueFun{
    dispatch_queue_t queue1 = dispatch_queue_create("queue_1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("queue_2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue3 = dispatch_queue_create("queue_3", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue1, ^{
        NSLog(@"任务1 begin");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"任务1 stop");
    });
    dispatch_async(queue2, ^{
        NSLog(@"任务2 begin");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"任务2 stop");
    });
    dispatch_async(queue3, ^{
        NSLog(@"任务3 begin");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"任务3 stop");
    });
}
//目标队列  队列是并行还是串行跟性质有关
-(void)targetQueueFun{
    ///串行
    dispatch_queue_t targetQueue = dispatch_queue_create("target_queue", DISPATCH_QUEUE_SERIAL);
    ///并行
//    dispatch_queue_t targetQueue = dispatch_queue_create("target_queue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_queue_t queue1 = dispatch_queue_create("queue_1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("queue_2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue3 = dispatch_queue_create("queue_3", DISPATCH_QUEUE_SERIAL);

    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_set_target_queue(queue2, targetQueue);
    dispatch_set_target_queue(queue3, targetQueue);

    dispatch_async(queue1, ^{
        NSLog(@"任务1 begin");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"任务1 stop");
    });
    dispatch_async(queue2, ^{
        NSLog(@"任务2 begin");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"任务2 stop");
    });
    dispatch_async(queue3, ^{
        NSLog(@"任务3 begin");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"任务3 stop");
    });
}
-(void)isMainThread{
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        NSLog(@"--main thread");
    } else {
        NSLog(@"--other thread");
    }
}
@end
