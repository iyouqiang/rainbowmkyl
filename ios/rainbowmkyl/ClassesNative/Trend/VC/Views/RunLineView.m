//
//  RunLineView.m
//  rainbowmkyl
//
//  Created by dodremteam on 2017/8/27.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "RunLineView.h"

@interface RunLineView ()

{
    NSInteger _horizontal;
    NSInteger _vertical;
    CGFloat _height;
    CGFloat _width;
}

@end

@implementation RunLineView

// vertical：垂直(列)； horizontal：水平(行)
- (instancetype)initWithFrame:(CGRect)frame vertical:(NSInteger)vertical horizontal:(NSInteger)horizontal {
    self = [super initWithFrame:frame];
    if (self) {
        
        _vertical = vertical;
        _horizontal = horizontal;
        _width = self.bounds.size.width;
        _height = self.bounds.size.height;
        
        [self initUI];
    }
    return self;
}

#warning 上边留出40, 左边留出55; 下边加长（4*35 = 140 == 40 + 50 + 50）

- (void)initUI {
    
    // 水平
    for (int i = 0; i <= _horizontal; i++) {
        
        if (i == 0) {
            UIView *lineW0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, 1)];
            lineW0.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self addSubview:lineW0];
        }
        
        UIView *lineW = [[UIView alloc] initWithFrame:CGRectMake(0, 40 * AdaptionHeight() + i * 35 * AdaptionHeight(), _width, 1)];
        lineW.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:lineW];
        
        if (i == _horizontal) {
            
            for (int j = 0; j < 2; j++) {
                UIView *lineW1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40 * AdaptionHeight() + i * 35 * AdaptionHeight() + (j + 1) * 50* AdaptionHeight(), _width, 1)];
                lineW1.backgroundColor = [UIColor groupTableViewBackgroundColor];
                [self addSubview:lineW1];
            }
        }
    }
    
    // 垂直
    for (int j = 0; j <= _vertical; j++) {
        // 55是留给放期数的， 35是水平的行高；
        UIView *lineH = [[UIView alloc] initWithFrame:CGRectMake(55*AdaptionWith() + j * ((_width - 55*AdaptionWith())/ _vertical), 0, 1, 35 * AdaptionHeight() * (_horizontal + 4))];
        lineH.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:lineH];
    }
}

@end
