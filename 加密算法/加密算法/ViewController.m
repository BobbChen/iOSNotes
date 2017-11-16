//
//  ViewController.m
//  加密算法
//
//  Created by 侨品汇 on 2017/11/14.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "ViewController.h"
#import "DesEncryptionManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"加密后的结果:%@",[DesEncryptionManager encryptUseDes:@"123" key:@"hew"]);
}



@end
