//
//  ViewController.m
//  KVO-KVC
//
//  Created by 陈博 on 2018/1/5.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@property (nonatomic, strong) Person * p1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.p1 = [[Person alloc] init];
    self.p1.name = @"name1";
    [self.p1 printInfo];
    [self.p1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    self.p1.name = @"name2";
    [self.p1 printInfo];
    [self.p1 removeObserver:self forKeyPath:@"name"];
    
    [self.p1 printInfo];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    NSLog(@"监听到了%@的属性%@发生变化",object,keyPath);
    NSLog(@"%@",change);
}

- (void)dealloc
{
    [self.p1 removeObserver:self forKeyPath:@"name"];
}


@end
