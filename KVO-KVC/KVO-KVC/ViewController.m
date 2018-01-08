//
//  ViewController.m
//  KVO-KVC
//
//  Created by 陈博 on 2018/1/5.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;


@property (nonatomic, strong) Person * p1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:self.tableView];
    
    [self kvo_test];
    
    
    
    
    
}
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    return cell;
}

- (void)kvo_test
{
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
    CGFloat offset = self.tableView.contentOffset.y;
    CGFloat delta = offset / 64.f + 1.f;
    delta = MAX(0, delta);
    
    self.navigationController.navigationBar.alpha = MIN(1, delta);
}

- (void)dealloc
{
    [self.p1 removeObserver:self forKeyPath:@"name"];
}


@end
