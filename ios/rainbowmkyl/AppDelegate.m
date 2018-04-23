/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"
#import "AppDelegate+MMFun.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.launchOptions = launchOptions;

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  
  [self setLoadConfigThirdService];
  
  [self.window makeKeyAndVisible];

  return YES;
}

#warning 需要配置RN环境 参考: http://reactnative.cn/docs/0.51/getting-started.html
#pragma mark - 马甲页面入口  ⭕️推送已经写好，集成别人代码需要将推送功能全部去掉！
// ⭕️ 1. 手动调试代码时在 AppMacros.h 类修改
// 需要修改 BundleIdntifier  版本号 和 Build 两个默认的0.0.1 可以测试
- (UIViewController *)nativeRootController {
  if (!_nativeRootController) {
    
//    // ⭕️  ⚠️壳入口⚠️   UIViewController 替换自己的入口
    _nativeRootController = [[UIViewController alloc] init];
    // 注意改变自己的背景颜色
    _nativeRootController.view.backgroundColor = [UIColor whiteColor];
  }

  return _nativeRootController;
}

@end














