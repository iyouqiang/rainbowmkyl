//
//  RunPageViewController.m
//  rainbowmkyl
//
//  Created by dodremteam on 2017/8/27.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "RunPageViewController.h"
#import "RunLineView.h"
#import "BallView.h"
#import "QiShuView.h"

@interface RunPageViewController ()<UIScrollViewDelegate>
{
    NSArray *_openBallArr;
    NSArray *_qiShuArr;
    NSInteger _moreNum;
    NSString *_kindGame;
    BOOL _isBuyEnter;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) RunLineView *lineView;
@property (nonatomic, strong) BallView *ballView;
@property (nonatomic, strong) QiShuView *qiShuView;

@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activity;

@end

@implementation RunPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recoverScrollViewPositions) name:@"recoverScrollViewPosition" object:nil];
    
    _openBallArr = self.dictionary[@"openBallArr"];
    _qiShuArr = self.dictionary[@"qiShuArr"];
    _moreNum = [self.dictionary[@"moreNum"] integerValue];
    _kindGame = self.dictionary[@"kindGame"];
    _isBuyEnter = [self.dictionary[@"isBuyEnter"] boolValue];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.lineView]; // 线放最底下。
    [self.scrollView addSubview:self.ballView];
    [self.scrollView addSubview:self.qiShuView];
    
    // 设置滚动的Size
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, CGRectGetMaxY(self.lineView.frame));
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat offsetY = scrollView.contentOffset.y;
  // 70限度
  if (_isRefresh) {
    [self.activity startAnimating];
    self.headLabel.text = @"正在刷新数据...";
  } else if (offsetY < -70) {
    [self.activity stopAnimating];
    self.headLabel.text = @"松开可以刷新";
  } else {
    [self.activity stopAnimating];
    self.headLabel.text = @"下拉可以刷新";
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  CGFloat offsetY = scrollView.contentOffset.y;
  
  // 70限度
  if (offsetY < -70) {
    _isRefresh = true;
    // self.getOpenData() 请求数据。
    self.refreshBlock();
    
    [UIView animateWithDuration:0.3 animations:^{
      self.scrollView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
      RunInfo.sharedRunInfo.scrollInsetsTop = 60;
    }];
  }
}

- (void)recoverScrollViewPositions {
  [UIView animateWithDuration:0.5 animations:^{
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    RunInfo.sharedRunInfo.scrollInsetsTop = 0;
  } completion:^(BOOL finished) {
    _isRefresh = NO;
  }];
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        
        NSInteger btnCount = [self.dictionary[@"btnCount"] integerValue];
        CGFloat height = 0.0;
        if (btnCount <= 5) {
            height = 43 * AdaptionHeight();
        } else {
            height = 79 * AdaptionHeight();
        }
      
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat tabbarHeight = 49 + 7;
        if (statusBarHeight == 44) {
          tabbarHeight = 83;
        }
      
        CGFloat bottom = 0.0;
        if (_isBuyEnter) {
            bottom = tabbarHeight * AdaptionHeight();
        } else {
            bottom = 49 + tabbarHeight * AdaptionHeight();
        }
      
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ((44+statusBarHeight) - 7) + height, self.view.bounds.size.width, kHeight - ((44+statusBarHeight) - 7) - height - bottom)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
      
        // _scrollView.bounces = NO;
        // RN发个信过来。 刷新打开这个。
      if (RunInfo.sharedRunInfo.isRefresh) {
        
        CGFloat contenHeight = 40 * AdaptionHeight() + _openBallArr.count * 35 * AdaptionHeight() + 2 * 50* AdaptionHeight();
        CGFloat scrollHeight = kHeight - ((44+statusBarHeight) - 7) - height - bottom;
        
        _scrollView.contentInset = UIEdgeInsetsMake(RunInfo.sharedRunInfo.scrollInsetsTop, 0, contenHeight < scrollHeight ? scrollHeight - contenHeight + 10 : 0, 0);
        _scrollView.delegate = self;
        [_scrollView addSubview:self.headView];
      }
      
    }
    return _scrollView;
}

- (UIView *)headView {
  if (!_headView) {
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, -60, kWidth, 60)];
    
    _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 60)];
    _headLabel.textAlignment = NSTextAlignmentCenter;
    [_headView addSubview:_headLabel];
    
    _activity = [[UIActivityIndicatorView alloc] init];
    _activity.center = CGPointMake(kWidth/2-80, 30);
    _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activity.hidesWhenStopped = NO; // 停止仍显示
    [_headView addSubview:_activity];
    
  }
  return _headView;
}


#warning lineView 和 ballView的Frame要一致！！！如果不一致要去LineView里面改位置。
- (RunLineView *)lineView {
    if (!_lineView) {
        // 30 * 35: 是个数*预计的方格行高
        _lineView = [[RunLineView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (_openBallArr.count+4) * 35* AdaptionHeight()) vertical:_moreNum horizontal:_openBallArr.count];
    }
    return _lineView;
}
- (BallView *)ballView {
    if (!_ballView) {
        _ballView = [[BallView alloc] initWithFrame:CGRectMake(55*AdaptionWith(), 0, self.view.bounds.size.width - 55*AdaptionWith(), (_openBallArr.count + 4) * 35* AdaptionHeight()) widthKindGame:_kindGame widthData:_openBallArr vertical:_moreNum horizontal:_openBallArr.count];
    }
    return _ballView;
}

- (QiShuView *)qiShuView {
    if (!_qiShuView) {
        
        _qiShuView = [[QiShuView alloc] initWithFrame:CGRectMake(0, 0, 55*AdaptionWith(), (_qiShuArr.count + 4) * 35* AdaptionHeight()) data:_qiShuArr labelHeight:35* AdaptionHeight()];
    }
    return _qiShuView;
}

@end
