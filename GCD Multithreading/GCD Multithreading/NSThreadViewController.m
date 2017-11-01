//
//  NSThreadViewController.m
//  GCD Multithreading
//
//  Created by 侨品汇 on 2017/10/31.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "NSThreadViewController.h"

@interface NSThreadViewController ()

@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self nsthread_createDemo];
}
#pragma mark - NSThread 创建线程方法
- (void)nsthread_createDemo
{
    // NSThread 需要自己创建线程
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRun) object:nil];
    thread.name = @"demoThread";
    
    // 线程优先级，不决定线程调用顺序，决定的是被CPU调用的频率
    thread.threadPriority = 1;
    
    // 栈区的大小
    //thread.stackSize = 16;
    
    [thread start];
}
- (void)nsthread_createDemoTwo
{
    // 调用该方法立即启动
    [NSThread detachNewThreadSelector:@selector(threadRun) toTarget:self withObject:nil];
}

#pragma mark - 线程延迟执行
- (void)threadDelayedexecution_demo
{
    [NSThread sleepForTimeInterval:2.0f];
    // [NSDate distantFuture] 随机返回一个比较遥远的未来时间
    
    [NSThread sleepUntilDate:[NSDate distantFuture]];
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0f]];
}

- (void)nsthread_createDemoThree
{
    // 隐式创建线程
    [self performSelectorInBackground:@selector(threadRun) withObject:nil];
}


- (void)threadRun
{
    NSLog(@"%d",[NSThread isMainThread]);
    
    NSLog(@"当前线程是:%@",[NSThread currentThread]);
    
}
#pragma mark - 线程间通讯
- (void)Threadcommunication_demo
{
    // 主线程执行
    [self performSelectorOnMainThread:@selector(threadRun) withObject:nil waitUntilDone:YES];
    
    // 当前线程执行
    [self performSelector:@selector(threadRun) withObject:nil];
    
    
}


@end
