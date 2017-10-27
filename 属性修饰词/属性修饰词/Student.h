//
//  Student.h
//  属性修饰词
//
//  Created by 侨品汇 on 2017/10/27.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^study)(void);
typedef void (^studyMore)(NSString * name);

@interface Student : NSObject
@property (copy , nonatomic) NSString *name;
@property (copy , nonatomic) study study;
@property (copy , nonatomic) studyMore studyMore;

@end

