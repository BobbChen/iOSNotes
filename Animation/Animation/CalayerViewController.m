//
//  CalayerViewController.m
//  Animation
//
//  Created by 侨品汇 on 2017/11/10.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "CalayerViewController.h"

@interface CalayerViewController ()
@property (nonatomic, strong)dispatch_source_t timer;

@end

@implementation CalayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /*
     1.UIView是UIKit的(只能iOS使用)，CALayer是QuartzCore的(iOS和mac os通用)
     
     2.UIView继承UIResponder,CALayer继承NSObject,UIView比CALayer多了一个事件处理的功能，也就是说，CALayer不能处理用户的触摸事件，而UIView可以
     
     3.UIView来自CALayer，是CALayer的高层实现和封装，UIView的所有特性来源于CALayer支持
     
     4.CABasicAnimation，CAAnimation，CAKeyframeAnimation等动画类都需要加到CALayer上
     
     5.CALayer是定义在QuartzCore框架中的(Core Animation),CGImageRef、CGColorRef两种数据类型是定义在CoreGraphics框架中的
        UIColor、UIImage是定义在UIKit框架中的
     
     其实UIView之所以能显示在屏幕上，完全是因为它内部的一个图层
     
     在创建UIView对象时，UIView内部会自动创建一个图层(即CALayer对象)，通过UIView的layer属性可以访问这个层
     
     @property(nonatomic,readonly,retain) CALayer *layer;
     
     当UIView需要显示到屏幕上时，会调用drawRect:方法进行绘图，并且会将所有内容绘制在自己的图层上，绘图完毕后，系统会将图层拷贝到屏幕上，于是就完成了UIView的显示
     
     换句话说，UIView本身不具备显示的功能，是它内部的层才有显示功能
     **/
    [self CAShapeLayer_demo];
    
}
#pragma mark - CALayer的子类 - CAShapeLayer
- (void)CAShapeLayer_demo
{
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 150, 100) cornerRadius:30];
    // path和UIBezierPath相互联系，在设置了path之后不要再设置position或bounds
    shapeLayer.path = path.CGPath;
    
    // 填充色
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = 10;
    [self.view.layer addSublayer:shapeLayer];
}

- (void)CAShapeLayer_FillRule_demo
{
    
}


@end
