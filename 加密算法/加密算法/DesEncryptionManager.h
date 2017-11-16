//
//  DesEncryptionManager.h
//  加密算法
//
//  Created by 侨品汇 on 2017/11/14.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesEncryptionManager : NSObject

+ (NSString *)encryptUseDes:(NSString *)plainText key:(NSString *)key;

@end
