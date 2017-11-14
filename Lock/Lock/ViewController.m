//
//  ViewController.m
//  Lock
//
//  Created by 侨品汇 on 2017/11/13.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "ViewController.h"
#import <os/lock.h>
#import <libkern/OSAtomicQueue.h>
#import <pthread.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nsconditionLock_demo];
    
    
}
#pragma mark - 01 - @synchronized - 性能最差
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

#pragma mark - 02 - dispatch_semaphore
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

#pragma mark - 03 - NSLock
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

#pragma mark - 04 - 递归锁NSRecursiveLock 常用于循环或者是递归
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

#pragma mark - 05 -NSConditionLock 条件锁
- (void)nsconditionLock_demo
{
    
    
    //主线程中
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:0]; // 初始化条件为0
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:1]; // 不满足加锁条件，加锁失败，线程阻塞
        NSLog(@"线程1");
        sleep(2);
        [lock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        if ([lock tryLockWhenCondition:0]) { // 满足加锁条件0
            NSLog(@"线程2");
            [lock unlockWithCondition:2]; // 注意，unlockWithCondition并不是满足条件之后才能解锁，而是解锁之后会将条件修改为2！
            NSLog(@"线程2解锁成功");
        } else {
            NSLog(@"线程2尝试加锁失败");
        }
    });
    
    //线程3
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);//以保证让线程2的代码后执行
        if ([lock tryLockWhenCondition:2]) {
            NSLog(@"线程3");
            [lock unlock];
            NSLog(@"线程3解锁成功");
        } else {
            NSLog(@"线程3尝试加锁失败");
        }
    });
    
    //线程4
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3);//以保证让线程2的代码后执行
        if ([lock tryLockWhenCondition:2]) {
            NSLog(@"线程4");
            [lock unlockWithCondition:1];
            NSLog(@"线程4解锁成功");
        } else {
            NSLog(@"线程4尝试加锁失败");
        }
    });
    
    
}

// NSCondition 一般用于多个线程访问同一资源，或者修改
- (void)nscondition_demo
{
    NSCondition *condition = [[NSCondition alloc] init];
    
    NSMutableArray *products = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [condition lock];
            if ([products count] == 0) {
                NSLog(@"wait for product");
                [condition wait]; // 让当前的线程处于等待状态，等待接受CPU发来的信号
            }
            [products removeObjectAtIndex:0];
            NSLog(@"custome a product");
            [condition unlock];
        }
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [condition lock];
            [products addObject:[[NSObject alloc] init]];
            NSLog(@"produce a product,总量:%zi",products.count);
            [condition signal]; // CPU发信号告诉线程不用等待，继续执行
            [condition unlock];
            sleep(1);
        }
        
    });
}

#pragma mark - 06 -OSSpinLock自旋锁 不安全，多线程中会造成优先级反转问题,OSSpinLock如果lock失败会一直轮询，会消耗资源，iOS10.0用os_unfair_lock替换
- (void)osspinLock_demo
{
    __block OSSpinLock theLock = OS_SPINLOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        OSSpinLockLock(&theLock);
        NSLog(@"任务1执行");
        sleep(2);
        NSLog(@"任务2执行");
        OSSpinLockUnlock(&theLock);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        OSSpinLockLock(&theLock);
        NSLog(@"任务3执行");
        OSSpinLockUnlock(&theLock);
    });

}

#pragma mark - 07 - os_unfair_lock 替代OSSpinLock的一种自旋锁
- (void)os_unfair_lock_demo
{
    __block os_unfair_lock theLock = OS_UNFAIR_LOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        os_unfair_lock_lock(&theLock);
        NSLog(@"任务1执行");
        sleep(2);
        NSLog(@"任务2执行");
        os_unfair_lock_unlock(&theLock);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        os_unfair_lock_lock(&theLock);
        NSLog(@"任务3执行");
        os_unfair_lock_unlock(&theLock);
    });
}

#pragma mark - 08 - pthread_mutex pthread_mutex_trylock当锁被使用的时候EBUSY,而不是挂起等待
- (void)pthread_mutex_demo
{
    __block pthread_mutex_t theLock;
    pthread_mutex_init(&theLock, NULL);

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        pthread_mutex_lock(&theLock);
        NSLog(@"任务1执行");
        sleep(2);
        NSLog(@"任务2执行");
        pthread_mutex_unlock(&theLock);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        pthread_mutex_lock(&theLock);
        NSLog(@"任务3执行");
        pthread_mutex_unlock(&theLock);
    });
    
    
}
// pthread_mutex的递归锁的形式,pthread_mutex_init(&theLock, NULL)在递归模式下会产生死锁

- (void)pthread_mutex_recursive_demo
{
    __block pthread_mutex_t theLock;
//    pthread_mutex_init(&theLock, NULL);
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    /*
     PTHREAD_MUTEX_NORMAL 缺省类型，也就是普通锁。当一个线程加锁以后，其余请求锁的线程将形成一个等待队列，并在解锁后先进先出原则获得锁。
     
     PTHREAD_MUTEX_ERRORCHECK 检错锁，如果同一个线程请求同一个锁，则返回 EDEADLK，否则与普通锁类型动作相同。这样就保证当不允许多次加锁时不会出现嵌套情况下的死锁。
     
     PTHREAD_MUTEX_RECURSIVE 递归锁，允许同一个线程对同一个锁成功获得多次，并通过多次 unlock 解锁。
     
     PTHREAD_MUTEX_DEFAULT 适应锁，动作最简单的锁类型，仅等待解锁后重新竞争，没有等待队列。
     
     **/
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&theLock, &attr);
    pthread_mutexattr_destroy(&attr);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveMethod)(int);
        RecursiveMethod = ^(int value){
            pthread_mutex_lock(&theLock);
            if (value > 0) {
                NSLog(@"value = %d",value);
                sleep(1);
                RecursiveMethod(value - 1);
            }
            pthread_mutex_unlock(&theLock);
        };
        RecursiveMethod(5);
    });
}






@end
