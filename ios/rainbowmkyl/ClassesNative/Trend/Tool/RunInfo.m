//
//  RunInfo.m
//  rainbowmkyl
//
//  Created by Money on 2017/9/21.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "RunInfo.h"

@implementation RunInfo

static RunInfo *_info = nil;

+ (instancetype)sharedRunInfo {
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    
    _info = [[RunInfo alloc] init];
    
    _info.url_str = @"";
    _info.mainColor = @"";
    _info.RN_gameid = @"";
    _info.isBuyEnter = NO;
    _info.isRefresh = NO;
    _info.scrollInsetsTop = 0;
    _info.currentIdx = 0;
  });
  return _info;
  
}

@end
