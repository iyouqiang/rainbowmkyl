//
//  RunInfo.h
//  rainbowmkyl
//
//  Created by Money on 2017/9/21.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RunInfo : NSObject

+ (instancetype)sharedRunInfo;

@property (nonatomic, strong) NSString *url_str;
@property (nonatomic, strong) NSString *mainColor;
@property (nonatomic, strong) NSString *RN_gameid;
@property (nonatomic, assign) BOOL isBuyEnter;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) CGFloat scrollInsetsTop;
@property (nonatomic, assign) NSInteger currentIdx;

@end
