//
//  DesEncryptionManager.m
//  加密算法
//
//  Created by 侨品汇 on 2017/11/14.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "DesEncryptionManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation DesEncryptionManager

+ (NSString *)encryptUseDes:(NSString *)plainText key:(NSString *)key
{
    
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    size_t dataLength = [plainText length];
    //==================
    
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (dataLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    NSString *testString = key;
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    Byte *iv = (Byte *)[testData bytes];
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          (void *)bufferPtr, bufferPtrSize,
                                          &movedBytes);
    if (cryptStatus == kCCSuccess) {
        
        ciphertext= [self parseByte2HexString:bufferPtr :(int)movedBytes];
        
    }
    ciphertext=[ciphertext uppercaseString];//字符变大写
    
    return ciphertext ;
    
}

+ (NSString *) parseByte2HexString:(Byte *) bytes:(int)len
{
    
    NSString *hexStr = @"";
    
    if(bytes)
    {
        for(int i=0;i<len;i++)
        {
            NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; ///16进制数
            if([newHexStr length]==1)
                hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
            else
            {
                hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
            }
            
            NSLog(@"%@",hexStr);
        }
    }
    
    return hexStr;
}

@end
