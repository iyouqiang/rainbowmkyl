//
//  RunLineView.h
//  rainbowmkyl
//
//  Created by dodremteam on 2017/8/27.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunLineView : UIView

// vertical：垂直(列)； horizontal：水平(行)
- (instancetype)initWithFrame:(CGRect)frame vertical:(NSInteger)vertical horizontal:(NSInteger)horizontal;

@end
