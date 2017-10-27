//
//  ViewController.m
//  属性修饰词
//
//  Created by 侨品汇 on 2017/10/27.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"

@interface ViewController ()
@property (copy,nonatomic) NSString *name;
@property (strong, nonatomic) Student *stu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retainCycleTwo];

}

// 循环引用
- (void)retainCycle
{
    // Student本身持有block，在block内部又强引用了Student造成循环引用
    Student * student = [[Student alloc] init];
    student.name = @"name";
    student.study = ^{
        NSLog(@"name is = %@",student.name);
    };
}

- (void)retainCycleTwo
{
    // student.name是作为形参传入的，并不会造成循环引用
    Student * student = [[Student alloc] init];
    student.name = @"name";
    student.studyMore = ^(NSString * name){
        NSLog(@"name is = %@",name);
    };
    student.studyMore(student.name);

}

//



@end
