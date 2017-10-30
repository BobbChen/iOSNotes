//
//  StatusTwoModel.h
//  RunTime01
//
//  Created by 侨品汇 on 2017/10/30.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


@interface StatusTwoModel : NSObject
@property (nonatomic, copy) NSString * attitudes_count;
@property (nonatomic, copy) NSString * created_at;
@property (nonatomic, copy) NSString * source;
@property (nonatomic, copy) NSString * text;
@property (nonatomic, strong) User * user;
@end
