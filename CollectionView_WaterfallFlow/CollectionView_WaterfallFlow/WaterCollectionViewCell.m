//
//  WaterCollectionViewCell.m
//  CollectionView_WaterfallFlow
//
//  Created by 陈博 on 2018/3/8.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import "WaterCollectionViewCell.h"

@implementation WaterCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10, 200)];
        self.testImageView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.testImageView];
        
        self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.testImageView.frame), frame.size.width - 10, 30)];
        self.testLabel.font = [UIFont systemFontOfSize:12];
        self.testLabel.text = @"hahahahahaha";
        [self addSubview:self.testLabel];
        
    }
    return self;
}

@end
