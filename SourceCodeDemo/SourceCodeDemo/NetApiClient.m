//
//  NetApiClient.m
//  QiaoPinHui
//
//  Created by 侨品汇 on 2017/6/29.
//  Copyright © 2017年 Yunwan. All rights reserved.
//

#import "NetApiClient.h"
static NetApiClient *_sharedClient = nil;


@implementation NetApiClient
static dispatch_once_t onceToken;

+ (NetApiClient *)shareJsonClient
{
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NetApiClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://qphvip.com"]];
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
    return self;
}
- (void)requestDataWithUrl:(NSString *)url andParams:(NSDictionary *)params andMethodType:(NetworkMethod)method andBlock:(void(^)(id data , NSError * error))block{
    
    [self requestDataWithUrl:url params:params methodType:method autoShowError:YES andBlock:block];
}

- (void)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params methodType:(NetworkMethod)method autoShowError:(BOOL)showError andBlock:(void(^)(id data , NSError * error))block{
    if (url == nil || url.length <= 0) {
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    switch (method) {
        case Get:{
            [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil, error);
            }];
            break;}
            
        case Post:{
            [self POST:url parameters:params constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                block(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"打印报错信息%@",error);
                
                block(nil,error);
            }];
        }
        default:
            break;
    }
}

@end
