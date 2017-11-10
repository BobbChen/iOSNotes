//
//  UserObject.h
//  SourceCodeDemo
//
//  Created by 侨品汇 on 2017/11/10.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>
@interface Author: NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSDate *birthday;
@end

@interface UserObject : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger pages;
@property (nonatomic, strong) Author *author;
@end


@interface Book: NSObject
@property NSString *name;
@property NSInteger page;
@property NSString *desc;
@property NSString *bookID;
@end

