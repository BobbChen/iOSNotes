//
//  LoginViewModel.h
//  ReactiveCocoa
//
//  Created by 侨品汇 on 2017/11/20.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface LoginViewModel : NSObject
@property (nonatomic, strong) Account * account;
@property (nonatomic, strong) RACSignal * enableLoginSignal;
@property (nonatomic, strong) RACCommand * LoginCommand;

@end
