//
//  NetApiClient.h
//  QiaoPinHui
//
//  Created by 侨品汇 on 2017/6/29.
//  Copyright © 2017年 Yunwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;

@interface NetApiClient : AFHTTPSessionManager

+ (instancetype)shareJsonClient;
- (void)requestDataWithUrl:(NSString *)url andParams:(NSDictionary *)params andMethodType:(NetworkMethod)method andBlock:(void(^)(id data , NSError * error))block;


@end
