//
//  ViewController.m
//  Animation
//
//  Created by 侨品汇 on 2017/11/10.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray * dataSurceArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSurceArray = @[@"CalayerViewController"];
    
    UITableView * demoTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    demoTableView.delegate = self;
    demoTableView.dataSource = self;
    [self.view addSubview:demoTableView];
}
#pragma mark - UITabelViewDeleaget && UITableViewDataSource
#pragma mark -
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSurceArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * vcStr =_dataSurceArray[indexPath.row];
    UIViewController * pushVc = [[NSClassFromString(vcStr) alloc] init];
    pushVc.title = vcStr;
    [self.navigationController pushViewController:pushVc animated:YES];
}



@end
