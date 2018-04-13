//
//  RunRnView.m
//  
//
//  Created by Money on 2017/9/18.
//  Copyright © 2017年 Money. All rights reserved.
//

#import "RunRnView.h"
#import "RunViewController.h"

@interface RunRnView()

// strong持有一下。不然接下来你会发现点击出问题了！
@property (nonatomic, strong) RunViewController *RunVC;

@end

@implementation RunRnView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    self.RunVC = [[RunViewController alloc] init];
    [self addSubview:self.RunVC.view];
    
  }
  return self;
}


@end
