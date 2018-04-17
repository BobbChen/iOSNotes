/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"
#import <CodePush/CodePush.h>
#import <UMMobClick/MobClick.h>

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  UMConfigInstance.appKey = @"5a9aad288f4a9d3f620004dd";
  UMConfigInstance.channelId = @"App Store";

  [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
  NSURL *jsCodeLocation;
  jsCodeLocation = [CodePush bundleURL];

//  #ifdef DEBUG
//        jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
//    #else
//    #endif

  
//    jsCodeLocation = [NSURL URLWithString:@"http://192.168.10.101:8081/index.bundle?platform=ios&dev=true"];
//  jsCodeLocation = []

  
  

  

  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"customNav"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
