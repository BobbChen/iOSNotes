//
//  NetDataManager.h
//  SourceCodeDemo
//
//  Created by 侨品汇 on 2017/11/7.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetDataManager : NSObject
+ (instancetype)shareManager;
- (void)requestGoodsDescDataWithBlock:(void (^)(NSArray *, NSArray *, NSError *))block;

@end
