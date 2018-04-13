//
//  BallView.m
//  rainbowmkyl
//
//  Created by dodremteam on 2017/8/27.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "BallView.h"

@interface BallView ()
{
    NSInteger _horizontal;
    NSInteger _vertical;
    CGFloat _height;
    CGFloat _width;
    NSString *_kindGame;
    NSMutableArray *_maxNumArr; // 最大遗漏
    NSMutableArray *_aveNumArr; // 平均遗漏
}
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *muPointArr; // 存绘制点的中心位置。

@end

@implementation BallView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    for (int i = 0; i < _muPointArr.count; i++) {
        
        NSString *pointStr = _muPointArr[i];
        CGPoint point = CGPointFromString(pointStr);
        
        if (i == 0) {
            CGContextMoveToPoint(context, point.x, point.y);
        } else {
            CGContextAddLineToPoint(context, point.x, point.y);
        }
    }
    CGContextStrokePath(context);
}


- (instancetype)initWithFrame:(CGRect)frame widthKindGame:(NSString *)kindGame widthData:(NSArray *)data vertical:(NSInteger)vertical horizontal:(NSInteger)horizontal {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _dataArr = data;
        _vertical = vertical;
        _horizontal = horizontal;
        _kindGame = kindGame;
        _height = self.bounds.size.height;
        _width = self.bounds.size.width;
        _muPointArr = [NSMutableArray array];
        
        // NSLog(@"开奖号 ==== %@", _dataArr);
        [self initHeader];
        [self initCenterContent];
    }
    return self;
}

#pragma mark - 显示走势内容上面那排数字： 1〜10
- (void)initHeader {
    
    for (int i = 0; i < _vertical; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * (_width / _vertical), 0, _width / _vertical, 40 * AdaptionHeight())];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = SystemFont_MinFont(16, 13.5);
        [self addSubview:label];
        
        if ([_kindGame isEqualToString:@"k3"] || [_kindGame isEqualToString:@"11x5"] || [_kindGame isEqualToString:@"pk10"]) {
            label.text = [NSString stringWithFormat:@"%d", i + 1];
        } else {
            label.text = [NSString stringWithFormat:@"%d", i];
        }
    }
}

#pragma mark - 底下的遗漏

- (void)initBottomLabel_withY:(CGFloat)y {
    
    for (int k = 0; k < 2; k++) {
        
        if (_vertical == _aveNumArr.count) {
            for (int i = 0; i < _vertical; i++) {
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * (_width / _vertical), 40 * AdaptionHeight() + y * 35* AdaptionHeight() + k * 50* AdaptionHeight(), _width / _vertical, 50 * AdaptionHeight())];
                label.textAlignment = NSTextAlignmentCenter;
                label.font = SystemFont_MinFont(16, 13.5);
                [self addSubview:label];
                
                if (k == 0) {
                    label.text = _aveNumArr[i];
                } else {
                    label.text = _maxNumArr[i];
                }
            }
        }
    }
}

#pragma mark - 中间的走势内容
- (void)initCenterContent {
    // vertical：垂直(列)； horizontal：水平(行)
    // 一行一行画。
    NSMutableArray *muIdxArr = [NSMutableArray array];
    NSMutableArray *maxNumArr = [NSMutableArray array]; // 最大
    NSMutableArray *addAllMaxNumArr = [NSMutableArray array]; // 最大数 相加
    NSMutableArray *openNumCountArr = [NSMutableArray array]; // 开奖的号码个数
    
    for (int k = 0; k < _vertical; k++) {
        [muIdxArr addObject:@"1"];
        [maxNumArr addObject:@"1"];
        [addAllMaxNumArr addObject:@"0"];
        [openNumCountArr addObject:@"0"];
    }
    
    CGFloat labelWidth = (_width / _vertical) > 30*AdaptionWith() ? 30*AdaptionWith() : (_width / _vertical);
    
    for (int i = 0; i < _horizontal; i++) {
        
        NSString *balli = _dataArr[i];
        
        for (int j = 0; j < _vertical; j++) {
            
            NSString *idxStr = muIdxArr[j];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(((_width / _vertical - labelWidth) * 0.5) + j * (_width / _vertical), 40 * AdaptionHeight() + ((35 * AdaptionHeight() - labelWidth)*0.5) + i * 35* AdaptionHeight(), labelWidth, labelWidth)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = SystemFont_MinFont(16, 13.5);
            [self addSubview:label];
            
            // 是不是从1开始
            BOOL isOneStart = ([_kindGame isEqualToString:@"k3"] || [_kindGame isEqualToString:@"11x5"] || [_kindGame isEqualToString:@"pk10"]);
            
            if (isOneStart ? [balli intValue] == j + 1 : [balli intValue] == j) {
                
                label.backgroundColor = [UIColor redColor];
                label.textColor = [UIColor whiteColor];
                
                // 号码前面加个0.
                if ([_kindGame isEqualToString:@"11x5"] || [_kindGame isEqualToString:@"pk10"]) {
                    label.text = [NSString stringWithFormat:@"%02d",[balli intValue]];
                    
                } else {
                    label.text = [NSString stringWithFormat:@"%d",[balli intValue]];
                }
                
                
                // 把红圈的改小一点。
                CGRect rect = label.frame;
                rect.size.width -= 5*AdaptionWith();
                rect.size.height -= 5*AdaptionWith();
                rect.origin.x += 2.5*AdaptionWith();
                rect.origin.y += 2.5*AdaptionWith();
                label.frame = rect;
                
                label.layer.cornerRadius = label.bounds.size.width * 0.5;
                label.clipsToBounds = YES;
                // 保存label的中心位置
                [_muPointArr addObject:NSStringFromCGPoint(label.center)];
                
                
                NSInteger maxNum = [maxNumArr[j] integerValue];
                NSInteger idx = [muIdxArr[j] integerValue];
                // 比较哪个大，就存那个
                if (idx > maxNum) {
                    maxNumArr[j] = @(idx - 1).stringValue;
                }
                
                // 记录开奖的个数 加1;
                NSInteger openCount = [openNumCountArr[j] integerValue];
                openCount ++;
                openNumCountArr[j] = @(openCount).stringValue;
                
                // 算平均遗漏的 累加
                int maxNumAdd = [addAllMaxNumArr[j] intValue];
                
                if (i > 0 && [muIdxArr[j] intValue] == 1 && i != _horizontal - 1) {
                    // 连号不加了。
                } else {
                    maxNumAdd += [muIdxArr[j] intValue];
                }
                addAllMaxNumArr[j] = [NSString stringWithFormat:@"%d", maxNumAdd];
                
                muIdxArr[j] = @"1"; // 重置为1,又从1开始。
                
            } else {
                
                if (i == _horizontal - 1) {
                    // 算平均遗漏的 累加
                    int maxNumAdd = [addAllMaxNumArr[j] intValue];
                    maxNumAdd += [muIdxArr[j] intValue];
                    addAllMaxNumArr[j] = [NSString stringWithFormat:@"%d", maxNumAdd];
                }
                
                label.textColor = [UIColor lightGrayColor];
                label.text = idxStr;
                // 拿记录数组的值出来++；替换。
                int idx = [idxStr intValue];
                idx ++;
                muIdxArr[j] = [NSString stringWithFormat:@"%d", idx];
            }
            
            // 判断如果最后一个是最大的时候，要重新替换
            if (i == _horizontal - 1) {
                NSInteger maxNum = [maxNumArr[j] integerValue];
                NSInteger idx = [muIdxArr[j] integerValue];
                // 比较哪个大，就存那个
                if (idx > maxNum) {
                    maxNumArr[j] = @(idx - 1).stringValue;
                }
            }
        }
    }
    
    // NSLog(@"addAllMaxNumArr = %@", addAllMaxNumArr);
    // NSLog(@"openNumCountArr = %@", openNumCountArr);
  
    // 平均遗漏要除开号的个数
    for (int i = 0; i < addAllMaxNumArr.count; i++) {
        float ave = [addAllMaxNumArr[i] floatValue];
        float openCount = [openNumCountArr[i] floatValue];
        if (openCount == 0) {
            ave = 0;
        } else {
            ave = ave / openCount;
        }
        
        ave = roundf(ave); // 四舍五入
        addAllMaxNumArr[i] = [NSString stringWithFormat:@"%.f", ave];
    }
    _aveNumArr = addAllMaxNumArr;
    _maxNumArr = maxNumArr;
    
    [self initBottomLabel_withY: _horizontal];
}

@end
