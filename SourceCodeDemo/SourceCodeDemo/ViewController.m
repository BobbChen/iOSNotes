//
//  ViewController.m
//  SourceCodeDemo
//
//  Created by 侨品汇 on 2017/8/28.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>
#import <UIImageView+YYWebImage.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.rowHeight = 80;
    [self.view addSubview:tableview];
    
    
    
    
    

    
    
}
- (void)demoOne{
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    
    imageView.center = self.view.center;
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageView];
    
    UIImageView * imageViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, self.view.frame.size.width, 100)];
    imageViewTwo.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageViewTwo];
    
    NSURL * picUrl = [NSURL URLWithString:@"http://ocgjuvwhb.bkt.clouddn.com/IMG_0223.PNG"];
    
    [imageViewTwo sd_setImageWithURL:picUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"获取的方式是--%ld",(long)cacheType);
    }];
    
    [imageView sd_setImageWithURL:picUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"获取的方式是--%ld",(long)cacheType);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    UIImageView * imageViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    [cell.contentView addSubview:imageViewTwo];
    NSURL * picUrl = [NSURL URLWithString:@"http://ocgjuvwhb.bkt.clouddn.com/IMG_0223.PNG"];
    [imageViewTwo sd_setImageWithURL:picUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"获取的方式是--%ld",(long)cacheType);
    }];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


@end
