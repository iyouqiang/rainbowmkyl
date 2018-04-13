//
//  RunOpenBallModel.h
//  rainbowmkyl
//
//  Created by dodremteam on 2017/8/27.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunOpenBallModel : NSObject

@property (nonatomic, copy) NSString *ba_0;
@property (nonatomic, copy) NSString *ba_1;
@property (nonatomic, copy) NSString *ba_2;
@property (nonatomic, copy) NSString *ba_3;
@property (nonatomic, copy) NSString *ba_4;
@property (nonatomic, copy) NSString *ba_5;
@property (nonatomic, copy) NSString *ba_6;
@property (nonatomic, copy) NSString *ba_7;
@property (nonatomic, copy) NSString *ba_8;
@property (nonatomic, copy) NSString *ba_9;
@property (nonatomic, copy) NSString *qishu;

+ (NSArray <RunOpenBallModel *> *)runOpenBallArr:(NSArray *)dataArr;

@end
