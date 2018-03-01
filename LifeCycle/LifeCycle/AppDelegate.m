//
//  AppDelegate.m
//  LifeCycle
//
//  Created by 陈博 on 2018/3/1.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/*
 // Application初次加载
 ①didFinishLaunchingWithOptions( (程序首次已经完成启动时执行，一般在这个函数里创建window对象，将程序内容通过window呈现给用户)
)
 
 ②applicationDidBecomeActive
 // 按下HOME键
 ③applicationWillResignActive(
     a.暂停正在执行的任务
     b. 禁止计时器
     c. 减少OpenGL ES帧率
     d. 若为游戏应暂停游戏
 )
 
 ④applicationDidEnterBackground(
     a. 释放共享资源
     b. 保存用户数据(写到硬盘)
     c. 作废计时器
     d. 保存足够的程序状态以便下次修复;
 )
 // 从后台返回
 ⑤applicationWillEnterForeground
 ⑥applicationDidBecomeActive
 
 // 程序退出
 ⑦applicationWillTerminate（保存数据）
 
 **/


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"1.应用程序被加载");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"3.应用程序进入非活跃状态");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"4.应用程序进入后台");

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"5.应用程序将要进入前台");

}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"2.应用程序进入活跃状态");

}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"程序将要退出结束");
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    NSLog(@"内存警告，程序将要终止");
}


@end
