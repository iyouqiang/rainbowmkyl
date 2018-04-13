//
//  BallView.h
//  rainbowmkyl
//
//  Created by dodremteam on 2017/8/27.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BallView : UIView

// vertical：垂直(列)； horizontal：水平(行)
- (instancetype)initWithFrame:(CGRect)frame widthKindGame:(NSString *)kindGame widthData:(NSArray *)data vertical:(NSInteger)vertical horizontal:(NSInteger)horizontal;

@end
