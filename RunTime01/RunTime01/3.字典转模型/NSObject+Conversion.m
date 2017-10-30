//
//  NSObject+Conversion.m
//  RunTime01
//
//  Created by 侨品汇 on 2017/10/30.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import "NSObject+Conversion.h"
#import <objc/message.h>


@implementation NSObject (Conversion)
// 根据模型中的属性 去字典中取出key对应的value并且赋值
+ (instancetype)modelWithDatadict:(NSDictionary *)dict
{
    // 创建对象
    id objc = [[self alloc] init];
    
    /* 用runtime给对象中的属性赋值
     获取类里面属性 class_copyPropertyList
     获取类中的所有成员变量 class_copyIvarList
     这里次用 class_copyIvarList 防止部分属性没有采用@property声明而漏掉该属性
     **/
    unsigned int count = 0;
    
    // &count： 传入int变量地址会自动赋值
    Ivar * ivarList = class_copyIvarList(self, &count);
    
    // 开始遍历所有成员变量
    for (int i = 0; i < count; i ++) {
        // 取出成员变量
        Ivar ivar = ivarList[i];
        
        // 获取成员变量名字
        NSString * ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 处理成员变量的名称(去掉_)
        NSString * key = [ivarName substringFromIndex:1];
        
        // 根据成员属性名称(key)在数据字典中查找对应的value
        id value = dict[key];
        
        // 处理模型数量大于数据字典的键值对，非空判断
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}
+ (instancetype)modelWithNestedDict:(NSDictionary *)dict
{
    id objc = [[self alloc] init];
    unsigned int count = 0;
    Ivar * ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSString * ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 在这里获取模型属性的类型
        NSString * ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        // 获取的ivaeType 是 “key\” -->"@key"
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        NSString * key = [ivarName substringFromIndex:1];
        // 根据成员变量名在字典中查找value
        id value = dict[key];
        
#warning 二级转换
        /* 如果字典之中还有字典，需要将对应的字典转换成模型
           判断value是否是字典，并且是自定义对象才需要转换
         **/
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            /* 将对应的字典转换成对应的模型
             NSClassFromString:根据类名生成类对象,不需要import，适用于嵌套类
             **/
            
            Class modelClass =NSClassFromString(ivarType);
            
            
            if (modelClass) {
                
                value = [modelClass modelWithNestedDict:value];
            }
        }
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}
@end
