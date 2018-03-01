//
//  ViewController.m
//  LifeCycle
//
//  Created by 陈博 on 2018/3/1.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end



/**
 UIViewController生命周期
 // Application First Load
 ①viewDidLoad
 ②viewWillAppear
 ③viewWillLayoutSubviews
 ④viewDidLayoutSubviews
 ⑤viewDidAppear
 
 // Push To Next Page
 ⑥viewWillDisappear
 ⑦viewDidDisappear
 
 
 // Return from the next page
 ⑧viewWillAppear
 ⑨viewDidAppear
 
 */

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSLog(@"%s", __FUNCTION__);
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"awakeFromNib");
}


-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    
}
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");

}
-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"viewWillDisappear");

}
- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"viewDidDisappear");

}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"%s", __FUNCTION__);

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");

    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.view.center;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
}
- (void)nextPage{
    [self.navigationController pushViewController:[[SecondViewController alloc] init] animated:YES];
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning");

}


@end
