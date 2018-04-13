//
//  RCTRunViewManager.m
//  
//
//  Created by Money on 2017/9/18.
//  Copyright © 2017年 Money. All rights reserved.
//

#import "RCTRunViewManager.h"
#import "RunRnView.h"

@implementation RCTRunViewManager

RCT_EXPORT_MODULE()

// 重写这个方法，返回将要提供给RN使用的视图
- (UIView *)view {
  return [[RunRnView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

// 这也是重写
- (dispatch_queue_t)methodQueue {
  return dispatch_get_main_queue();
}

@end
