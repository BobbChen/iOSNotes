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
    [self NSOperationQueue_demo];
    
    
    
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
    
    // 将operation放到queue中
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
}
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
