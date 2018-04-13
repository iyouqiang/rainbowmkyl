//
//  QiShuView.m
//  rainbowmkyl
//
//  Created by dodremteam on 2017/8/27.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "QiShuView.h"

@implementation QiShuView

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data labelHeight:(CGFloat)labelHeight
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSMutableArray *muData = [data mutableCopy];
        [muData insertObject:@"期数" atIndex:0];
        [muData addObject:@"平均\n遗漏"];
        [muData addObject:@"最大\n遗漏"];
        
        for (int i = 0 ; i < muData.count; i++) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 0;
            label.font = SystemFont_MinFont(16, 13.5);
            label.text = muData[i];
            [self addSubview:label];
            
            // 40+50+50 =140; 4*35 =140
            if (i == 0) {
                
                label.frame = CGRectMake(0, 0, self.bounds.size.width, 40 * AdaptionHeight());
                
            } else if (i == muData.count - 2) {
                
                label.frame = CGRectMake(0, 40 * AdaptionHeight() + (i - 1) * labelHeight, self.bounds.size.width, 50* AdaptionHeight());
                
            } else if (i == muData.count - 1) {
                
                label.frame = CGRectMake(0, 40 * AdaptionHeight() + (i - 2) * labelHeight + 50* AdaptionHeight(), self.bounds.size.width, 50* AdaptionHeight());
                
            } else {
                
                label.frame = CGRectMake(0, 40 * AdaptionHeight() + (i - 1) * labelHeight, self.bounds.size.width, labelHeight);
            }
        }
    }
    return self;
}

@end
