//
//  ViewController.m
//  RunTime01
//
//  Created by 侨品汇 on 2017/10/25.
//  Copyright © 2017年 侨品汇. All rights reserved.
//

#import "ViewController.h"
#import "PersonOne.h"
#import "PersonTwo.h"
#import <objc/message.h>
#import "UIImage+image.h"
#import "NSObject+Property.h"
#import "StatusOneModel.h"

@interface ViewController ()
@property (nonatomic, copy) NSString * demoStr;

@end

@implementation ViewController
- (void)setDemoStr:(NSString *)demoStr
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self runtimeSubstance];
    /*
     self.demoStr 是通过访问的方法的引用，包含set和get方法 '_demoStr'只是对局部变量的操作
     **/
    _demoStr = @"哈哈";
    NSLog(@"demoStr = %@",self.demoStr);
    // runtime方法交换
    [self methodExchange];
    
    // runtime分类添加属性
    [self dynamicProperty];
    
    // runtime字典转模型
    [self runtimeDictTransitionModel];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获取成员变量
    unsigned int ivarcount = 0;
    Ivar * ivars = class_copyIvarList([PersonTwo class], &ivarcount);
    for (int i = 0 ; i < ivarcount; i ++) {
        Ivar ivar = ivars[i];
        NSLog(@"第%d个成员变量:%s",i,ivar_getName(ivar));
    }
    free(ivars);
    
    // 获取属性
    unsigned int propertyCount = 0;
    objc_property_t * propertyList = class_copyPropertyList([PersonTwo class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = propertyList[i];
        NSLog(@"第%d个属性:%s",i,property_getName(property));
    }
    
    // 获取方法列表
    unsigned int methodCount = 0;
    Method * methods = class_copyMethodList([PersonTwo class], &methodCount);
    for (int i = 0; i < methodCount; i ++) {
        Method method = methods[i];
        NSLog(@"第%d个方法:%s",i,sel_getName(method_getName(method)));
    }
    
}


// 消息机制
- (void)runtimeSubstance
{
    //     PersonOne * persons = [PersonOne alloc];
    PersonOne * persons = objc_msgSend(objc_getClass("PersonOne"), sel_registerName("alloc"));
    
    //     persons = [persons init];
    persons = objc_msgSend(persons, sel_registerName("init"));
    
    //     [persons eat];
    objc_msgSend(persons, @selector(eat));
    
}

// runtime方法交换
- (void)methodExchange
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.image = [UIImage imageNamed:@"subscriIcon"];
    [self.view addSubview:imageView];
}

// runtime动态添加属性
- (void)dynamicProperty{
    NSObject * objc = [[NSObject alloc] init];
    /* 分类中用@property添加的属性不能生成setter和getter方法，直接调用会崩溃
       在分类中使用@propertysh声明属性，只是将该属性添加到了该类的属性列表。即使自己声明了setter和getter方法也不会生成相应的成员变量su所以分类不能添加属性
     **/
    objc.name = @"haha";
    NSLog(@"打印绑定的属性值--%@",objc.name);
}

- (void)runtimeDictTransitionModel
{
    // 获取资源
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"status1.plist" ofType:nil];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    StatusOneModel * model = [StatusOneModel modelWithDict:dict];
    NSLog(@"KVC字典转模型:%@",model);
}
@end
