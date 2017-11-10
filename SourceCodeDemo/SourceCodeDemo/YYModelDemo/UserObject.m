//
//  UserObject.m
//  SourceCodeDemo
//
//  Created by 侨品汇 on 2017/11/10.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import "UserObject.h"
#import <YYModel.h>

@implementation UserObject
// 模型中嵌套模型，需要modelContainerPropertyGenericClass进行指定
+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"author" : [Author class]};
}

@end

@implementation Author

@end

@implementation Book

/* 如果模型中的属性与json中的不一致，可以采用modelCustomPropertyMapper将模型中的属性名对应到json中的key
 
    模型中的一个属性可以和多个json中的key产生映射关系，默认使用第一个不为空的值
 
 **/

+  (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"n",
             @"page" : @"p",
             @"desc" : @"ext.desc",
             @"bookID" : @[@"id",@"book_id"]};
}

@end


