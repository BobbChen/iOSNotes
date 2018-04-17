//
//  ViewController.m
//  CollectionView_WaterfallFlow
//
//  Created by 陈博 on 2018/3/8.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import "ViewController.h"
#import "WaterCollectionViewCell.h"



@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * demoCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((self.view.frame.size.width - 15) / 2, 300);
    
    _demoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    [_demoCollectionView registerClass:[WaterCollectionViewCell class] forCellWithReuseIdentifier:@"WaterCollectionViewCell"];
    _demoCollectionView.backgroundColor = [UIColor grayColor];
    _demoCollectionView.delegate = self;
    _demoCollectionView.dataSource = self;
    [self.view addSubview:_demoCollectionView];
    
}
#pragma mark - UICollectionViewDelegate&&UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaterCollectionViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[WaterCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width - 15) / 2, 300)];
        
    }
    return cell;
}

@end
