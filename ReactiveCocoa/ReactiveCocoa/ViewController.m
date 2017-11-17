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
#import "SecondViewController.h"

@interface ViewController ()
@property (nonatomic, strong) Person * person;
@property (weak, nonatomic) IBOutlet UITextField *demoTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *demoBtn;
@property (nonatomic, strong) RACDelegateProxy * proxy;
@property (nonatomic, strong) RACCommand * command;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[Person alloc] init];
    [self kvo_demo];
    [self ractuple_demo];
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
- (void)racsubject_demo
{
    // 创建信号
    RACSubject * subject = [RACSubject subject];


    // 订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者:%@",x);
    }];

    [subject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者:%@",x);
    }];

    // RACSubject只能先订阅信号后才能发送信号
    [subject sendNext:@"1"];
    
    
    
    // RACReplaySubject可以先发送信号，再订阅信号
    RACReplaySubject * replaySubject = [RACReplaySubject subject];
    
    // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];

    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者:%@",x);

    }];
    
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者:%@",x);

    }];
    
}

#pragma mark - RACSubject替换代理

- (IBAction)pushToSecondViewController:(id)sender {
    SecondViewController * secVc = [[SecondViewController alloc] init];
    secVc.delegateSignal = [RACSubject subject];
    [secVc.delegateSignal subscribeNext:^(id x) {
        NSLog(@"第二个页面的文本输入框内容是:%@",x);
    }];
    [self.navigationController pushViewController:secVc animated:YES];
    
}

#pragma mark - RACTuple 和 RACSequence
- (void)ractuple_demo
{
    // RACSequence可以用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典
    NSArray * numArray = @[@1,@2,@3];
    [numArray.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"数组中的元素分别是:%@",x);
    }];
    
    // 遍历字典
    NSDictionary * dict = @{@"name":@"张三",@"age":@"21"};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * x) {
        // 解包元祖
        RACTupleUnpack(NSString * key,NSString * value) = x;
        NSLog(@"遍历字典:%@:%@",key,value);
    }];
}

#pragma mark - RACCommand

- (IBAction)raccommand_demo:(id)sender {
    
    
    //
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"执行命令");
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"请求数据"];
            [subscriber sendCompleted];
            return nil;
        }];
        
    }];
    _command = command;
    
    [command.executionSignals subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }];
    
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    // 4.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
    [[command.executing skip:1] subscribeNext:^(id x) {
        
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            
        }else{
            // 执行完成
            NSLog(@"执行完成");
        }
    }];
    // 5.执行命令
    [self.command execute:@1];
    
}


























@end
