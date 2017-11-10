//
//  ViewController.m
//  SourceCodeDemo
//
//  Created by 侨品汇 on 2017/8/28.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <YYCache.h>
#import <UIImageView+WebCache.h>
#import <UIImageView+YYWebImage.h>
#import "NetDataManager.h"
#import "UserObject.h"
#import <YYModel.h>

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
    
    //
    [self YYModel_demo2];
    
    
    
    
    

    
    
}
#pragma mark - YYModel
- (void)YYModel_demo
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data.json" ofType:@""];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    
    UserObject * model = [UserObject yy_modelWithJSON:data];
    
    
    
}
- (void)YYModel_demo2
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data02.json" ofType:@""];
    NSData *data = [NSData dataWithContentsOfFile:path];
    Book * model = [Book yy_modelWithJSON:data];
    
    NSLog(@"%@",model.bookID);
    
    
}

#pragma mark - YYCache
- (void)YYCache_demo
{
    // 使用YYCache进行缓存先检查是否有缓存数据，如果有直接调用，如果没有再进行网络请求
    NSString * cycleKey = @"cycleKey";
    YYCache * cache = [YYCache cacheWithName:@"YYCache_demo"];
    if([cache containsObjectForKey:cycleKey]){
        // 缓存存在从缓存中获取数据
        [cache objectForKey:cycleKey withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
            NSLog(@"从缓存中获取的数据--%@",object);
        }];
        
    }else{
        [[NetDataManager shareManager] requestGoodsDescDataWithBlock:^(NSArray * cycleArray, NSArray * ouzhouArray, NSError * error) {
            NSLog(@"网络获取的数据---%@",cycleArray);
            
        }];
    }
    
    
    
    
    
}

#pragma mark - SDWebImage
- (void)SDWebImage_demo{
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    
    imageView.center = self.view.center;
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageView];
    
    UIImageView * imageViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, self.view.frame.size.width, 100)];
    imageViewTwo.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageViewTwo];
    
    NSURL * picUrl = [NSURL URLWithString:@"http://ocgjuvwhb.bkt.clouddn.com/IMG_0223.PNG"];
    
    [imageViewTwo sd_setImageWithURL:picUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    
    [imageView sd_setImageWithURL:picUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
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
    }];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


@end
