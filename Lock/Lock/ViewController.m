//
//  ViewController.m
//  Lock
//
//  Created by 侨品汇 on 2017/11/13.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "ViewController.h"
#import <os/lock.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nsrecursiveLock_demo];
    
    
}
#pragma mark - @synchronized - 性能最差
- (void)synchronized_demo
{
    NSObject * objc = [[NSObject alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(objc){
            NSLog(@"任务1执行");
            sleep(2);
            NSLog(@"任务3执行");
        }
        
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(objc){
            NSLog(@"任务2执行");
        }
        
    });
    
}

#pragma mark - dispatch_semaphore
- (void)dispatch_semaphore_demo
{
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // dispatch_semaphore_wait: 会使signal信号量的值减 1，如果此时signal的值为0，那么就阻塞当前线程直到signal值大于0或者阻塞的时间已经大于time，也会继续向下执行
        dispatch_semaphore_wait(signal, time);
        NSLog(@"任务1");
        sleep(2);
        NSLog(@"任务3");
        
        // dispatch_semaphore_signal使信号量signal的值加 1
        dispatch_semaphore_signal(signal);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(signal, time);
        NSLog(@"任务2");
        dispatch_semaphore_signal(signal);
    });
}

#pragma mark - NSLock
-(void)nslock_demo
{
    
    NSLock * lock = [[NSLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        
        NSLog(@"任务1执行");
        sleep(2);
        NSLog(@"任务3执行");
        [lock unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // tryLock: 如果当前锁已经被锁住返回NO,不会阻塞线程,可以避免死锁
        if ([lock tryLock]) {
            NSLog(@"任务2执行");
            [lock unlock];

        }else{
            NSLog(@"当前锁不可用");
        }
        
    });
}

#pragma mark - 递归锁NSRecursiveLock 常用于循环或者是递归
- (void)nsrecursiveLock_demo
{
    
    
    
    //NSLock *lock = [[NSLock alloc] init];
    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        static void (^RecursiveMethod)(int);
        
        RecursiveMethod = ^(int value) {
            // 如果在这里使用NSLock，会在第二次进入block的时候阻塞该线程，导致死锁，

            [lock lock];
            if (value > 0) {
                
                NSLog(@"value = %d", value);
                sleep(1);
                RecursiveMethod(value - 1);
            }
            [lock unlock];
        };
        
        RecursiveMethod(5);
    });
}

#pragma mark - NSConditionLock 条件锁
- (void)nsconditionLock_demo
{
    
}

#pragma mark - OSSpinLock自旋锁 不安全，多线程中会造成优先级反转问题
- (void)osspinLock_demo
{

}




@end
