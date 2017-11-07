//
//  NetDataManager.m
//  SourceCodeDemo
//
//  Created by 侨品汇 on 2017/11/7.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import "NetDataManager.h"
#import "NetApiClient.h"
#import <YYCache.h>

@implementation NetDataManager
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    static NetDataManager * manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
- (void)requestGoodsDescDataWithBlock:(void (^)(NSArray *, NSArray *, NSError *))block
{
    
    
    
    
    [[NetApiClient shareJsonClient] requestDataWithUrl:@"/index.php?s=/Advs/AdvsList" andParams:nil andMethodType:Get andBlock:^(id data, NSError *error) {
        
        NSArray * cycleArray;
        NSArray *ouzhouArray;
        
        //
        if (data) {
            BOOL success = data[@"code"];
            if (success) {
                NSArray *dataArray = data[@"list"];
                NSDictionary *bannerDict = dataArray[0];
                if ([bannerDict[@"id"] isEqualToString:@"100"]) {
                    cycleArray = bannerDict[@"list"];
                    // 获取到数据之后进行缓存操作
                    YYCache * cache = [YYCache cacheWithName:@"YYCache_demo"];
                    [cache setObject:cycleArray forKey:@"cycleKey"];
                }
            }
            ouzhouArray =  data[@"ouzhou"];
        }
        
        
        
        block(cycleArray,ouzhouArray,nil);
    }];

}





@end
