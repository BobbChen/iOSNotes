//
//  SecondViewController.h
//  ReactiveCocoa
//
//  Created by 侨品汇 on 2017/11/17.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface SecondViewController : UIViewController
@property (nonatomic, strong) RACSubject *delegateSignal;
@end
