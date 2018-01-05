//
//  Person.h
//  KVO-KVC
//
//  Created by 陈博 on 2018/1/5.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * age;
- (void)printInfo;

@end
