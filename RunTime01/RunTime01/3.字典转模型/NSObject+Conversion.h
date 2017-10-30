//
//  NSObject+Conversion.h
//  RunTime01
//
//  Created by 侨品汇 on 2017/10/30.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Conversion)
// 一级模型解析
+ (instancetype)modelWithDatadict:(NSDictionary *)dict;

// 二级模型解析(模型中嵌套模型)
+ (instancetype)modelWithNestedDict:(NSDictionary *)dict;

@end
