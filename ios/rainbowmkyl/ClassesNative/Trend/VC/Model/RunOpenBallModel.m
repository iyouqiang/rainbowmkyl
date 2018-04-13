//
//  RunOpenBallModel.m
//  rainbowmkyl
//
//  Created by dodremteam on 2017/8/27.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "RunOpenBallModel.h"

@implementation RunOpenBallModel

+ (NSArray<RunOpenBallModel *> *)runOpenBallArr:(NSArray *)dataArr {
    
    NSMutableArray *muArr = [NSMutableArray array];
    
    for (NSDictionary *dic in dataArr) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            
            RunOpenBallModel *model = [[RunOpenBallModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [muArr addObject:model];
        }
    }
    return muArr;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
