//
//  StatusOneModel.m
//  RunTime01
//
//  Created by 侨品汇 on 2017/10/27.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import "StatusOneModel.h"

@implementation StatusOneModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        /*
         1.setValuesForKeysWithDictionary会遍历传入的字典dict所有的key和value，然后再调用setValue:forkey:的方法给模型赋值
         2.setValue:forkey: 先查找有没有setAttitudes_count这个方法(@property)如果有直接调用set方法进行赋值，如果没有再查找模型中有没有这个属性如果有调用attitudes_count = dict[@"attitudes_count"]进行赋值找不到attitudes_count查找_attitudes_count直接给变量赋值。如果都没有直接报错
         **/
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
