//
//  Person.m
//  KVO-KVC
//
//  Created by 陈博 on 2018/1/5.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person
- (void)printInfo
{
    
    NSLog(@"***************************");
    NSLog(@"isa:%@, supper class:%@",NSStringFromClass(object_getClass(self)),class_getSuperclass(self));
    NSLog(@"self:%@, [self superclass]:%@", self, [self superclass]);
    
    
    NSLog(@"age setter function pointer:%p", class_getMethodImplementation(object_getClass(self), @selector(setAge:)));
    
    NSLog(@"name setter function pointer:%p", class_getMethodImplementation(object_getClass(self), @selector(setName:)));
    NSLog(@"printInfo function pointer:%p", class_getMethodImplementation(object_getClass(self), @selector(printInfo)));
    
}

@end
