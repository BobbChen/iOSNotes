/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIView+WebCacheOperation.h"

#if SD_UIKIT || SD_MAC

#import "objc/runtime.h"

static char loadOperationKey;

typedef NSMutableDictionary<NSString *, id> SDOperationsDictionary;

@implementation UIView (WebCacheOperation)

- (SDOperationsDictionary *)operationDictionary {
    SDOperationsDictionary *operations = objc_getAssociatedObject(self, &loadOperationKey);
    if (operations) {
        return operations;
    }
    // 如果根据loadOperationKey没有获取到相关的操作，用objc_setAssociatedObject对NSMutableDictionary这个类添加自定义的属性
    operations = [NSMutableDictionary dictionary];
    
    objc_setAssociatedObject(self, &loadOperationKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return operations;
}

- (void)sd_setImageLoadOperation:(nullable id)operation forKey:(nullable NSString *)key {
    if (key) {
        [self sd_cancelImageLoadOperationWithKey:key];
        if (operation) {
            SDOperationsDictionary *operationDictionary = [self operationDictionary];
            operationDictionary[key] = operation;
        }
    }
}

- (void)sd_cancelImageLoadOperationWithKey:(nullable NSString *)key {
    // 获取到operation操作
    SDOperationsDictionary *operationDictionary = [self operationDictionary];
    
    // 根据key获取对应的operation
    id operations = operationDictionary[key];
    NSLog(@"sd_cancelImageLoadOperationWithKey----%@",key);
    
    if (operations) {
        
        
        // 判断类型
        if ([operations isKindOfClass:[NSArray class]]) {
            for (id <SDWebImageOperation> operation in operations) {
                
                if (operation) {
                    [operation cancel];
                }
            }
            // 不是集合就是一个下载对象，conformsToProtocol：判断operations是否遵循SDWebImageOperation协议
        } else if ([operations conformsToProtocol:@protocol(SDWebImageOperation)]){
            NSLog(@"在这里进行了单个的取消下载操作！");
            [(id<SDWebImageOperation>) operations cancel];
        }
        // 删除key
        [operationDictionary removeObjectForKey:key];
    }
}

- (void)sd_removeImageLoadOperationWithKey:(nullable NSString *)key {
    if (key) {
        SDOperationsDictionary *operationDictionary = [self operationDictionary];
        [operationDictionary removeObjectForKey:key];
    }
}

@end

#endif
