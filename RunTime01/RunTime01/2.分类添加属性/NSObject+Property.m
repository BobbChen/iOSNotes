//
//  NSObject+Property.m
//  RunTime01
//
//  Created by 侨品汇 on 2017/10/26.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/message.h>

@implementation NSObject (Property)
// 即使是自己创建了setter和getter方法，也不能在这两个方法中使用_name(不会生成)
- (void)setName:(NSString *)name
{
    /* 将某个值和某个对象关联起来，将某个值存储到某个对象中
     self : 给哪个对象添加属性
     @"name" : 属性名称
     name : 属性值
     OBJC_ASSOCIATION_RETAIN_NONATOMIC : 保存的策略
     **/
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (NSString *)name
{
    return objc_getAssociatedObject(self, @"name");
}




@end
