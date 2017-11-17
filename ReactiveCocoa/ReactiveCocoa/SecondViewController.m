//
//  SecondViewController.m
//  ReactiveCocoa
//
//  Created by 侨品汇 on 2017/11/17.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UITextField *secondTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)secondButtonEvent:(UIButton *)sender {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:self.secondTextFiled.text];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
