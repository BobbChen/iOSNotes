//
//  ViewController.m
//  GCD Multithreading
//
//  Created by 侨品汇 on 2017/10/30.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dispatch_barrier_async_Demo];
    
//    [self Note1];
}
- (void)Note1
{
    /**
       Dispatch Queue的创建方式-1
     @param label#> 指定queue名称，调式方便，也可以为NULL description#>
     @param attr#> 指定queue串行或者并发，如果为NULL，则默认为串行 description#>
     如果低于iOS6.0或者Mac OS X 10.8 dispatch_release(mySerialDispatchQueue);
     */
    
    dispatch_queue_t mySerialDispatchQueue = dispatch_queue_create("com.example.gcd.MySerialDispatchQueue", DISPATCH_QUEUE_CONCURRENT);
    
    
    /* Dispatch Queue的创建方式-2获取系统queue
         Main Dispatch Queue / Global Dispatch Queue
     **/
    dispatch_queue_t mainDispatchQueue = dispatch_get_main_queue(); // 获取系统主线程
    /*
     DISPATCH_QUEUE_PRIORITY_LOW
     DISPATCH_QUEUE_PRIORITY_HIG
     DISPATCH_QUEUE_PRIORITY_BACKGROUND
     DISPATCH_QUEUE_PRIORITY_DEFAULT
     **/
    dispatch_queue_t globalDispatchQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    // 使用
    dispatch_async(globalDispatchQueueHigh, ^{
        // code
        dispatch_async(mainDispatchQueue, ^{
            // code
        });

    });
    
}
#pragma mark - dispatch_set_target_queue
- (void)dispatch_set_target_queueDemo
{
    /* dispatch_set_target_queue - 改变队列的执行优先级和执行层次
     使用dispathc_queue_create生成的队列的优先级都与Global Dispatch Queue默认的执行优先级相同
     执行层次:防止并发队列并行执行
     **/
    
    dispatch_queue_t targetQueue = dispatch_queue_create("targetQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_set_target_queue(queue2, targetQueue);
    dispatch_async(queue2, ^{
        NSLog(@"job3 in");
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"job3 out");
    });
    
    dispatch_async(queue2, ^{
        NSLog(@"job2 in");
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"job2 out");
        
    });
    dispatch_async(queue1, ^{
        NSLog(@"job1 in");
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"job1 out");
    });
}
#pragma mark - dispatch_after
- (void)dispatch_after_Demo
{
    
    /**
     获取从dispatch_time_no到delta指定的时间后的时间

     @param dispatch_time_no 指定的时间开始
     @param delta 指定的毫微秒时间
     @return 指定的时间后的时间
     NSEC_PER_SEC : 毫微秒
     ull : C语言的数值字面量，显示表示类型
     3ull * NSEC_PER_SEC : 3秒后
     150ull * NSEC_PER_MSEC : 150毫秒后
     */
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    
    
    
    /**
     指定时间后执行处理

     @param when#> dispatch_time_t description#>
     @param queue#> 指定队列，如果是主线程会受到主线程延时事物的影响 description#>
     @param void 处理的的block
     
     @return
     */
    dispatch_after(time, dispatch_get_main_queue(), ^{
        // code
    });
    
}

#pragma mark - Dispatch Group
- (void)dispatch_group_Demo
{
    //
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"blk0");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"blk1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"blk2");

    });
    
    // 1、采用dispatch_group_notify可以监听追加到dispatch_group的block完成
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"完成");
//    });
    // 2、也可以用dispatch_group_wait(group, DISPATCH_TIME_FOREVER).DISPATCH_TIME_FOREVER: 只要group的处理未结束就一直等待
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    
    
    long result =  dispatch_group_wait(group, time);
    if (result == 0) {
        // 在指定的时间内group完成了全部操作
        NSLog(@"group 全出处理完成");
    }else{
        // 指定的时间内还有操作未完成
        NSLog(@"group 还在执行中");
    }
}
#pragma mark - dispatch_barrier_async
- (void)dispatch_barrier_async_Demo
{
    /*
     为了防止资源竞争，dispatch_barrier_async可以保证在任意时间，对同一数据的写入操作只有一个线程执行
     **/
    dispatch_queue_t queue = dispatch_queue_create("dispatch_barrier_async_Demo", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"读取资源");
    });
    dispatch_async(queue, ^{
        NSLog(@"读取资源");
    });
    
    // dispatch_barrier_async会等待它前面的队列任务完成之后才开始，并且它后面的任务要等它结束也才能开始
    dispatch_barrier_async(queue, ^{
        NSLog(@"写入资源");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"读取资源");
    });
    dispatch_async(queue, ^{
        NSLog(@"读取资源");
    });
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
