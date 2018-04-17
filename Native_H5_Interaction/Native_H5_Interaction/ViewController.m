//
//  ViewController.m
//  Native_H5_Interaction
//
//  Created by 陈博 on 2018/3/3.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
/*
 JSContext:JSContext代表一个JavaScript的执行环境的一个实例,是OC和JS之间的一个桥梁
 
 JSValue:用来接收JSContent返回的执行结果，可以是任意类型
 
 JSManagedValue:JSValue的封装，防止循环引用
 
 JSVirtualMachine:
 
 JSExport:一个协议，可以把一个native对象暴露给JS，实现将 Objective-C 类及其实例方法，类方法和属性导出为 JavaScript 代码的协议
 **/
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate,JSObjectDelegate>
@property (nonatomic, strong) UIWebView * WebView;
@property (nonatomic, strong) JSContext * context;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"改变" style:UIBarButtonItemStyleDone target:self action:@selector(changeWebTxet)];
    
    self.WebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    self.WebView.delegate = self;
    [self.WebView loadRequest:request];
    [self.view addSubview:self.WebView];

}
- (void)addEvent
{
    [self
     .navigationController pushViewController:[[FirstViewController alloc] init] animated:YES];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 验证JSContext是否验证成功
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
    };
    
    // 将JS中的‘native’指定为
    self.context[@"native"] = self;
    
    
    __weak typeof(self) weakSelf = self;
    // Block的方式实现JS调用Native
    self.context[@"myAction"] = ^(){
        [weakSelf.navigationController pushViewController:[[FirstViewController alloc] init] animated:YES];
    };
    
    // 接收参数
    self.context[@"log"] = ^(NSString * str){
        NSLog(@"传来的参数是--%@",str);
    };
    
}

- (void)changeWebTxet{
    // 通过JSContext来获取对应的函数，用JSValue接收
    JSValue * labelAction = self.context[@"labelAction"];
    [labelAction callWithArguments:@[@"hello word"]];
}




#pragma mark - JSObjectDelegate
- (void)ocLog
{
    NSLog(@"ocLog");
}



@end
