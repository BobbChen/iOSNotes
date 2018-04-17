//
//  ViewController.m
//  AotoreleasePool
//
//  Created by 陈博 on 2018/3/3.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 100000; i ++ ) {
        @autoreleasepool{
            NSString * str = @"hello";
            str = [str stringByAppendingFormat:@"- %d",i];
            str = [str uppercaseString];
            NSLog(@"%@",str);

        }
    }
    
}


@end
