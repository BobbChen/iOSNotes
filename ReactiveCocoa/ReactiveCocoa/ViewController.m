//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by 侨品汇 on 2017/11/16.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Person.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/RACDelegateProxy.h>

@interface ViewController ()
@property (nonatomic, strong) Person * person;
@property (weak, nonatomic) IBOutlet UITextField *demoTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *demoBtn;
@property (nonatomic, strong) RACDelegateProxy * proxy;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[Person alloc] init];
    [self kvo_demo];
    [self RACSignal_demo];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.person.name = [NSString stringWithFormat:@"zhang %d",arc4random_uniform(100)];
    
}
#pragma mark - KVO监听
- (void)kvo_demo
{
    [RACObserve(self.person, name) subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [RACObserve(self.person, pw) subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

#pragma mark - 文本输入框监听
- (void)textFiled_demo
{
    [[self.demoTextFiled rac_textSignal] subscribeNext:^(id x) {
        
        self.person.name = x;
    }];
}

#pragma mark - 文本框组合信号监听
- (void)combinTextField_demo
{
    id signals = @[[self.demoTextFiled rac_textSignal],[self.pwTextFiled rac_textSignal]];
    @weakify(self);
    /* 将两个信号合并
     **/

    [[RACSignal combineLatest:signals] subscribeNext:^(RACTuple * x) {
        NSString * name = [x first];
        NSString * pw = [x second];
        @strongify(self);
        if (name.length > 0 && pw.length > 0) {
            self.person.name = name;
            self.person.pw = pw;
            NSLog(@"可以使用！");
        }
    }];
}
#pragma mark - 按钮监听
- (void)button_demo
{
    @weakify(self);
    [[self.demoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.person.name = @"点击了按钮";
    }];
}

#pragma mark - 代理方法
- (void)delegate_demo
{
    self.proxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UITextFieldDelegate)];
    
    // 代理去注册文本框的监听方法
    [[self.proxy rac_signalForSelector:@selector(textFieldShouldReturn:)] subscribeNext:^(id x) {
        if (self.demoTextFiled.hasText) {
            
            
            [self.pwTextFiled becomeFirstResponder];
        }
    }];
    self.demoTextFiled.delegate = (id<UITextFieldDelegate>)self.proxy;

}

#pragma mark - 通知
- (void)nsnorfication_demo
{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(id x) {
       
        NSLog(@"打印键盘的通知信息--%@",x);
        
    }];
}

#pragma mark - RACSignal信号
- (void)RACSignal_demo
{
    /*
     RACSignal: 信号类，如果数据发生变化，就会立刻发出信号(需要有订阅者--调用subscribeNext就行)
     默认的RACSignal都是冷信号(需要被订阅并且值改变了才能发出信号)
     **/
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        /* RACSubscriber
            帮助信号发送数据
         
         **/
        
        [subscriber sendNext:@1];
        
        
        [subscriber sendCompleted];
        
        /* RACDisposable
            取消订阅或者清理资源，信号发送完成或者发生错误会自动调用，也可以主动调用取消信号
         
         **/
        return  [RACDisposable disposableWithBlock:^{
            // 信号发送完成或者发送错误就会执行这个block
            NSLog(@"信号被销毁");
        }];
    }];
    
    // 订阅信号，信号被激活
    [signal subscribeNext:^(id x) {
        NSLog(@"发送的信号是:%@",x);
    }];
    
}
#pragma mark - RACSubject



@end
