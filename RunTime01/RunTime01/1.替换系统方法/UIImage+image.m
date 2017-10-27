//
//  UIImage+image.m
//  RunTime01
//
//  Created by 侨品汇 on 2017/10/26.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import "UIImage+image.h"
#import <objc/message.h>

@implementation UIImage (image)
// 方法交换先获取系统方法，与自己实现的扩展功能的方法进行交换，只交换一次 load方法会在类被加入内存的时候调用
+ (void)load
{
    // 获取系统的imageNamed:方法
    Method imageNameMethod = class_getClassMethod(self, @selector(imageNamed:));
    
    // 获取扩展功能的方法
    Method ln_imageNameMethod = class_getClassMethod(self, @selector(ln_imageName:));
    
    // 交换方法
    method_exchangeImplementations(imageNameMethod, ln_imageNameMethod);
    
    
}
+ (UIImage *)ln_imageName:(NSString *)name
{
    // ln_imageName 其实调用的是已经被交换的系统imageNamed:方法
    UIImage * image = [UIImage ln_imageName:name];
    if (image) {
        NSLog(@"图片添加成功");
    }else{
        NSLog(@"图片添加失败");
    }
    return image;
}
@end
