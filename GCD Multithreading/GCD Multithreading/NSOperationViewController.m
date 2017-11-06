//
//  NSOperationViewController.m
//  GCD Multithreading
//
//  Created by 侨品汇 on 2017/11/1.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "NSOperationViewController.h"

@interface NSOperationViewController ()

@end

@implementation NSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     **/
    [self NSOperationQueuesuspended_demo];
    
    
}

- (void)NSInvocationOperation_demo
{
    // 注意操作对象只有添加到NSOperationQueue才会异步执行，否则都是默认在主线程中执行
    NSInvocationOperation * operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperationAction) object:nil];
    [operation start];
}
- (void)NSBlockOperation_demo
{
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"当前的线程---%@",[NSThread currentThread]);
    }];
    
    // 只要NSBlockOperation封装的操作数大于1，就会异步执行操作
    [operation addExecutionBlock:^{
        NSLog(@"当前的线程---%@",[NSThread currentThread]);
        
    }];
    
    [operation addExecutionBlock:^{
        NSLog(@"当前的线程---%@",[NSThread currentThread]);
        
    }];

    [operation start];
}

/*
 将NSInvocationOperation或者NSBlockOperation对象放入NSOperationQueue中，可以开启异步线程
 
 **/
- (void)NSOperationQueue_demo
{
    NSInvocationOperation * operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(OperationQueueTest1) object:nil];
    
    NSInvocationOperation * operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(OperationQueueTest2) object:nil];
    
    NSBlockOperation * operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation3-线程-%@",[NSThread currentThread]);
    }];
    
    [operation3 addExecutionBlock:^{
        NSLog(@"operation3-1-线程-%@",[NSThread currentThread]);
    }];
    
    /* 将operation放到queue中
     NSOperationQueue包含两种队列:主队列和其它队列
     **/
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    
    /* maxConcurrentOperationCount 最大并发数
       maxConcurrentOperationCount 默认为-1.并发执行，不进行限制
        maxConcurrentOperationCount = 1，串行执行，开启一条子线程
       maxConcurrentOperationCount = 0,不执行队列任务
     maxConcurrentOperationCount > 1，并发执行，不会超过系统的限制
     **/
    queue.maxConcurrentOperationCount = 1;
}
#pragma mark - 操作依赖
- (void)Dependency_demo
{
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    NSBlockOperation * operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务1");
    }];
    NSBlockOperation * operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务2");
    }];
    
    // operation之间的相互依赖会发生死锁
    [operation2 addDependency:operation1];
    
//    [operation1 addDependency:operation2];
    [queue addOperation:operation1];
    [queue addOperation:operation2];

}
#pragma mark - 任务的取消
- (void)operationCacncel_demo
{
    NSBlockOperation * operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务1");
    }];
    NSBlockOperation * operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务2");
    }];
    
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2; // 并发
    [queue addOperation:operation1]; // 将任务添加到queue之后会自动调用start
    [queue addOperation:operation2];
    
    
    // 取消任务1
    [operation1 cancel];
    // 取消整个队列的任务
    [queue cancelAllOperations];
    
}
#pragma mark - NSOperationQueue的暂停和恢复
- (void)NSOperationQueuesuspended_demo
{
    NSBlockOperation * operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务1");
    }];
    NSBlockOperation * operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务2");
    }];
    
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    
    // 暂停queue中的所有operation
    queue.suspended = true;
    
    // 恢复queue中所有的operation
    //queue.suspended = false;

    [queue addOperation:operation1]; // 将任务添加到queue之后会自动调用start
    [queue addOperation:operation2];
    

}


#pragma mark - 任务组
- (void)OperationQueueTest1
{
    NSLog(@"OperationQueueTest1- %@",[NSThread currentThread]);
}

- (void)OperationQueueTest2
{
    NSLog(@"OperationQueueTest2- %@",[NSThread currentThread]);
}

- (void)invocationOperationAction
{
    NSLog(@"当前的线程---%@",[NSThread currentThread]);
    
}


@end
