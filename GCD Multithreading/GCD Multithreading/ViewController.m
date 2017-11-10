//
//  ViewController.m
//  GCD Multithreading
//
//  Created by 侨品汇 on 2017/10/30.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)dispatch_source_t timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"ndkwqndknw");
    [self disatch_source_t_demo];
    
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
#pragma mark - dispatch_queue_attr_make_with_qos_class 队列优先级
- (void)dispatch_queue_attr_make_with_qos_class_demo
{
    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, -1);
    dispatch_queue_t queue = dispatch_queue_create("com.starming.gcddemo.qosqueue", attr);
    
    

}


#pragma mark - dispatch_after
- (void)dispatch_after_Demo
{
    
    /**
     获取从dispatch_time_no到delta指定的时间后的时间
     dispatch_time_no 指定的时间开始
     delta 指定的毫微秒时间
     指定的时间后的时间
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

#pragma mark - dispathc_sync
- (void)dispatch_sync_demo
{
    // dispatch_sync同步将队列加入到线程中，会等待block执行完成之后再执行接下来的程序，简化版的dispatch_group_wait,dispatch_sync有可能引起死锁
    dispatch_sync(dispatch_get_main_queue(), ^{
        // 这种情况下会发生死锁
        NSLog(@"产生了死锁！");
    });
    
    // dispatch_async将队列异步加入线程，不会等待block的结束就会接着执行以后的程序
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}
#pragma mark - dispatch_apply
- (void)dispatch_apply_demo
{
    //
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    // 按照指定的次数将指定的block追加到指定的queue中，会等待全部执行完毕之后再执行以后的程序
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"index = %ld",index);
    });
    NSLog(@"dispatch_apply执行完毕！");
    
}
#pragma mark - dispatch_suspend/dispatch_resume
- (void)dispatch_supend_demo
{
    //创建DISPATCH_QUEUE_SERIAL队列
    dispatch_queue_t queue1 = dispatch_queue_create("com.iOSChengXuYuan.queue1", 0);
    dispatch_queue_t queue2 = dispatch_queue_create("com.iOSChengXuYuan.queue2", 0);
    
    //创建group
    dispatch_group_t group = dispatch_group_create();
    
    //异步执行任务
    dispatch_async(queue1, ^{
        NSLog(@"任务 1 ： queue 1...");
        sleep(1);
        NSLog(@":white_check_mark:完成任务 1");
    });
    
    dispatch_async(queue2, ^{
        NSLog(@"任务 1 ： queue 2...");
        sleep(1);
        NSLog(@":white_check_mark:完成任务 2");
    });
    
    //将队列加入到group
    dispatch_group_async(group, queue1, ^{
        NSLog(@":no_entry_sign:正在暂停 1");
        dispatch_suspend(queue1);
    });
    
    dispatch_group_async(group, queue2, ^{
        NSLog(@":no_entry_sign:正在暂停 2");
        dispatch_suspend(queue2);
    });
    
    //等待两个queue执行完毕后再执行
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"＝＝＝＝＝＝＝等待两个queue完成, 再往下进行...");
    
    //异步执行任务
    dispatch_async(queue1, ^{
        NSLog(@"任务 2 ： queue 1");
    });
    dispatch_async(queue2, ^{
        NSLog(@"任务 2 ： queue 2");
    });
    
    //在这里将这两个队列重新恢复
    dispatch_resume(queue1);
    dispatch_resume(queue2);
    
}

#pragma mark - Dispatch_Semaphore
- (void)dispatch_Semaphore_demo
{
    // 信号量 2表示最多访问资源的线程数
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 1
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"任务1");
        sleep(1);
        NSLog(@"任务1完成");
        dispatch_semaphore_signal(semaphore);
    });
    
    // 2
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"任务2");
        sleep(1);
        NSLog(@"任务2完成");
        dispatch_semaphore_signal(semaphore);

    });

    
    //
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"任务3");
        sleep(1);
        NSLog(@"任务3完成");
        dispatch_semaphore_signal(semaphore);
    });
    

}
#pragma mark - Dispatch I/O
- (void)dispatch_io_demo
{
    // 指定发生错误的block
    //dispatch_io_create(<#dispatch_io_type_t type#>, <#dispatch_fd_t fd#>, <#dispatch_queue_t  _Nonnull queue#>, <#^(int error)cleanup_handler#>)
    
    // 设定一次读取的大小
// dispatch_io_set_low_water(<#dispatch_io_t  _Nonnull channel#>, <#size_t low_water#>)
    
    
    // 开始读取指定的分割文件读取结束会通过block将data传递
//    dispatch_io_read(<#dispatch_io_t  _Nonnull channel#>, <#off_t offset#>, <#size_t length#>, <#dispatch_queue_t  _Nonnull queue#>, <#^(bool done, dispatch_data_t  _Nullable data, int error)io_handler#>)
}


#pragma mark - disatch_source 精确度高于NSTimer的计时器(需要将其设置为成员变量，局部变量会立刻被释放)
- (void)disatch_source_t_demo
{
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    
    // intervalInSeconds : 开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);

    
    
    // leewayInSeconds : 间隔时间
    uint64_t interval = 2.0 * NSEC_PER_SEC;

    dispatch_source_set_timer(self.timer, start, interval, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"dispatch_source_t");

        });
    });
    dispatch_resume(self.timer);
    
}


@end
