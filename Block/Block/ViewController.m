//
//  ViewController.m
//  Block
//
//  Created by 陈博 on 2018/1/7.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self block_test];
    
    
    
}


- (void)block_test
{
    int val = 10;
    
    // block截获自动变量的值是保存该变量的瞬间值
    void(^blk)(void) = ^{
        NSLog(@"%d",val);
    };
    // 在执行block语法之后即时改写自动变量的值也不会影响block执行时自动变量的值
    val = 2;
    blk();
}

- (void)block_value
{
    // __block 作用域修饰符会将val变量从栈上复制到堆上
    __block int val = 0;
    void(^blk)(void) = ^{
        val = 1;
    };
    blk();
    NSLog(@"%d",val);
}

- (void)blokc_object
{
    NSMutableArray * array = [NSMutableArray array];
    void(^blk)(void) = ^{
        id object = [[NSObject alloc] init];
        [array addObject:object];
    };
    blk();
    NSLog(@"%@",array);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
