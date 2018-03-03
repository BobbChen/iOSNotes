//
//  ViewController.m
//  EventResponseChain
//
//  Created by 陈博 on 2018/3/1.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)A_Click:(UIButton *)sender {
    NSLog(@"%s",__func__);
}
- (IBAction)B_Click:(id)sender {
    NSLog(@"%s",__func__);

}
- (IBAction)C_Click:(id)sender {
    NSLog(@"%s",__func__);
    NSLog(@"C按钮的父控件是%@",[sender superview]);

}

- (IBAction)D_Click:(id)sender {
    NSLog(@"%s",__func__);

}
- (IBAction)E_Click:(id)sender {
    NSLog(@"%s",__func__);

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
