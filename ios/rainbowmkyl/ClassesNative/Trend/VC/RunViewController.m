//
//  RunViewController.m
//  rainbowmkyl
//
//  Created by dodremteam on 2017/8/26.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "RunViewController.h"
#import "RunPageViewController.h"
#import "RunOpenBallModel.h"
#import "RNBridgeModule.h"

@interface RunViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) UIButton *headerOldBut; // 记录头部View上一次点的button

@property (nonatomic, strong) NSArray *openDataModelArr;
@property (nonatomic, assign) NSInteger moreNum;  // 走势多少列
@property (nonatomic, copy) NSString *kindGame; // 当前彩种的js_tag
@property (nonatomic, copy) NSString *gameID;  // 当前彩种的ID
@property (nonatomic, copy) NSString *tempgameid; // 临时的gameid。切换彩种请求失败时不改变gameID
@property (nonatomic, strong) NSMutableArray *openBallArr; // 开奖的号
@property (nonatomic, strong) NSMutableArray *qiShuDataArr; // 期数
@property (nonatomic, assign) BOOL isBuyEnter; // 是不是从购彩进入的
@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, strong) UILabel *errLabel;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation RunViewController

- (void)dealloc {
  // 移除我不喜欢的通知！
  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LoadingRunView" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadingRunView:) name:@"LoadingRunView" object:nil];
  
    _openDataModelArr = [NSArray array];
    _openBallArr = [NSMutableArray array];
    _isFirst = YES;
    RunInfo.sharedRunInfo.currentIdx = 0; // 换彩种重置。
  
    [self handleRN_Gameid];
}

- (void)handleRN_Gameid {
 
  if (RunInfo.sharedRunInfo.isBuyEnter) {
    // 从购彩进入的
    _isBuyEnter = YES;
    _tempgameid = RunInfo.sharedRunInfo.RN_gameid;
    RunInfo.sharedRunInfo.isBuyEnter = NO; // 走了重置。否则重新点主界面的走势会出错
    RunInfo.sharedRunInfo.RN_gameid = @"";
    // 请求走势图数据
    [self getOpensData: _tempgameid isRefresh:NO];
    
    
  } else if (_isFirst && RunInfo.sharedRunInfo.isBuyEnter != YES) {
    _isFirst = NO;
    _isBuyEnter = RunInfo.sharedRunInfo.isBuyEnter;
    _tempgameid = RunInfo.sharedRunInfo.RN_gameid;
    RunInfo.sharedRunInfo.isBuyEnter = NO; // 走了重置。
    RunInfo.sharedRunInfo.RN_gameid = @"";
    
    // 请求走势图数据
    [self getOpensData: _tempgameid isRefresh:NO];
  }
}

- (void)loadingRunView:(NSNotification *)info {
  NSString *gameID = info.userInfo[@"Gameid"];
  _isFirst = NO;
  // 请求走势图数据
  _tempgameid = gameID;
  [self getOpensData: gameID isRefresh:NO];
}

#pragma mark - 创建头，和获取数据
- (void)initHeadView_Button {
    
    NSArray *array = [NSArray array];
  
    if ([_kindGame isEqualToString:@"k3"]) {
        array = @[@"百位",@"十位",@"个位"];
        
    } else if ([_kindGame isEqualToString:@"ssc"]) {
        
        if ([_gameID intValue] != 3) {
            array = @[@"万位",@"千位",@"百位",@"十位",@"个位"];
        } else {
            array = @[@"百位",@"十位",@"个位"];
        }
        
    } else if ([_kindGame isEqualToString:@"11x5"]) {
        array = @[@"一位",@"二位",@"三位",@"四位",@"五位"];
        
    } else if ([_kindGame isEqualToString:@"3d"]) {
        array = @[@"百位",@"十位",@"个位"];
        
    } else if ([_kindGame isEqualToString:@"pk10"]) {
        array = @[@"一位",@"二位",@"三位",@"四位",@"五位",@"六位",@"七位",@"八位",@"九位",@"十位"];
        
    }else if ([_kindGame isEqualToString:@"pcdd"]){
        array = @[@"特码一",@"特码二",@"特码三"];
    }
    
    [self initHeadView_ButtonWithData:array];

#warning 在这里拼上所有想要的数据。
    _pageArray = [NSMutableArray array];
    for (int i = 0; i < _openBallArr.count; i++) {
        NSArray *ballArr = _openBallArr[i];
        
        NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
        [muDic setObject:ballArr forKey:@"openBallArr"]; // 开奖的号码
        [muDic setObject:@(_openBallArr.count).stringValue forKey:@"btnCount"]; // 头部按钮的总数;显示高度用到
        [muDic setObject:@(_moreNum).stringValue forKey:@"moreNum"]; // 开奖那个列
        [muDic setObject:_qiShuDataArr forKey:@"qiShuArr"];
        [muDic setObject:_kindGame forKey:@"kindGame"];
        [muDic setObject:@(_isBuyEnter) forKey:@"isBuyEnter"];  // 记录是不是从购彩进入的
        [_pageArray addObject:muDic];
    }
    
#warning 一定要在请求到数据后 再添加到视图
    // 这是删除重新加载
    for (UIView *view in self.pageViewController.view.subviews) {
        [view removeFromSuperview];
    }
    [self.pageViewController.view removeFromSuperview];
    self.pageViewController = nil;
  
    [self.view addSubview:self.pageViewController.view];
    // 置于最底层
    [self.view sendSubviewToBack:self.pageViewController.view];
}


#pragma mark - 初始化头部Button
- (void)initHeadView_ButtonWithData:(NSArray *)data {
    
    // 先删除了，再添加新的。不然会重复
    UIView *headButContetView = [self.view viewWithTag:1990];
    for (UIButton *btn in headButContetView.subviews) {
        [btn removeFromSuperview];
    }
    [headButContetView removeFromSuperview];
    headButContetView = nil;
    
    
    NSInteger idx = data.count;
    CGFloat viewHeight = 0.0;
    if (idx <= 5) {
        viewHeight = 43;
    } else {
        viewHeight = 79;
    }
    // 这里是真有毒，这个butContetView我想距离导航0个像素，写64不行，更要我减了7个像素，绝逼有毒！！！
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
  UIView *butContetView = [[UIView alloc] initWithFrame:CGRectMake(0, (44 + statusBarHeight) - (statusBarHeight > 22 ? 5 : 7), kWidth, viewHeight*AdaptionHeight())];
    butContetView.tag = 1990;
    [self.view addSubview:butContetView];
    
    for (int i = 0; i < idx; i++) {
        // 414 -  375 = 39 / 6 = 6.5
        // 上下间隔3
        CGRect butFrame;
        if (idx < 5) {
            butFrame = AdaptionRect(6.5 + i * (((414 - (idx+1) * 6.5) / idx) + 6.5), 5, (414 - (idx+1)* 6.5) / idx, 33);
        } else {
            butFrame = AdaptionRect(6.5 + i % 5 * (75 + 6.5), 5 + i / 5 * 36, 75, 33);
        }
      
        UIButton *button = [[UIButton alloc] initWithFrame:butFrame];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.layer.cornerRadius = 8;
        button.clipsToBounds = YES;
        button.tag = 6000 + i;
        button.titleLabel.font = SystemFont_MinFont(16, 14);
        [button setTitle:data[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(headerBut:) forControlEvents:UIControlEventTouchUpInside];
      
        // 如果有下拉刷新的，存了当前选择的位置。刷新时会重新初始化赋值 就显示回刷新前的位置，不默认0位
        if (i == RunInfo.sharedRunInfo.currentIdx) {
            button.selected = YES;
            button.backgroundColor = [UIColor colorWithHexString:RunInfo.sharedRunInfo.mainColor alpha:1];
            _headerOldBut = button;
        }
      
        [butContetView addSubview:button];
    }
}

#pragma mark - 头部View的点击事件
- (void)headerBut:(UIButton *)sender {
    // 如果已经是选择状态了 就直接return；
    if (sender.selected == YES) {
        return;
    }
    
    _headerOldBut.selected = NO;
    _headerOldBut.backgroundColor = [UIColor clearColor];
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        sender.backgroundColor = [UIColor colorWithHexString:RunInfo.sharedRunInfo.mainColor alpha:1];
    } else {
        sender.backgroundColor = [UIColor clearColor];
    }
    _headerOldBut = sender;
    
    // 要跳转的视图控制器的下标 ，当前选中的分段控制器的下标
    NSInteger index = sender.tag - 6000;
    RunInfo.sharedRunInfo.currentIdx = index; // 存当前选择的位置。
    // 根据下标返回控制器
    RunPageViewController *runPageVC = [self viewContrllerAtIndex:index];
    
    // 当前视图控制器的下标， 拿到控制器返回对应的下标
    NSInteger currentIndex = [self indexOfViewController:self.pageViewController.viewControllers.firstObject];
    // 判断要向前还是向后跳转
    if (currentIndex < index) {
        // 前 左
        [self.pageViewController setViewControllers:@[runPageVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    } else {
        // 后 右
        [self.pageViewController setViewControllers:@[runPageVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
}

#pragma mark - UIPageViewControllerDataSource
// 前进(手指向左滑)
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(RunPageViewController *)viewController];
    if (index >= self.pageArray.count) {
        return nil;
    }
    index++;
    return [self viewContrllerAtIndex:index];
}

// 后退(手指向右滑)
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(RunPageViewController *)viewController];
    
    if (index == 0) {
        return nil;
    }
    index--;
    return [self viewContrllerAtIndex:index];
}

// 根据控制器内容 返回下标
- (NSInteger)indexOfViewController:(RunPageViewController *)viewController {
    // 拿到viewController的内容，然后根据内容从pageArray返回下标
    return [self.pageArray indexOfObject:viewController.dictionary];
}

// 根据下标 返回对应控制器
- (RunPageViewController *)viewContrllerAtIndex:(NSInteger)index {
    
    if (self.pageArray.count == 0 || index >= self.pageArray.count) {
        return nil;
    }
    RunPageViewController *runPageVC = [[RunPageViewController alloc]init];
    runPageVC.refreshBlock = ^{
      // 回调请求数据。
      [self getOpensData:_gameID isRefresh:YES];
    };
  
    runPageVC.dictionary = [self.pageArray objectAtIndex:index];
    
    return runPageVC;
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    NSInteger index = [self indexOfViewController:(RunPageViewController *)pageViewController.viewControllers.firstObject];
    
    // 根据tag去拿到按钮，然后变态它的选择状态
    UIButton *button = [self.view viewWithTag:index + 6000];
    // 有时候滑动了一点点的 没有滑到下一页的，就直接return。
    if (button.tag == _headerOldBut.tag) {
        return;
    }
    
    button.selected = YES;
    button.backgroundColor = [UIColor colorWithHexString:RunInfo.sharedRunInfo.mainColor alpha:1];
    RunInfo.sharedRunInfo.currentIdx = index; // 左右划结束也把位置存起来。刷新完数据就直接显示这个位置
    
    // 把上一次点击的按钮 的选择状态设为NO
    _headerOldBut.selected = NO;
    _headerOldBut.backgroundColor = [UIColor clearColor];
    
    // 重新把当前选中的按钮 赋给OldBut
    _headerOldBut = button;
}

#pragma mark - getter
- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationNone)}];
        
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        
        _pageViewController.view.frame = self.view.bounds;
        
        [self addChildViewController:self.pageViewController];
      
        // 默认AtIndex:0,但是加了刷新不能用默认的了，要显示刷新前的位置 从单例取。
        RunPageViewController *runPageVC = [self viewContrllerAtIndex:RunInfo.sharedRunInfo.currentIdx];
        
        [_pageViewController setViewControllers:@[runPageVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    return _pageViewController;
}


- (void)loadingView {
  self.activityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0,100*AdaptionWith(),100*AdaptionWith())];
  self.activityIndicatorView.center=self.view.center;
  [self.activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
  [self.activityIndicatorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
  self.activityIndicatorView.layer.cornerRadius = 8;
  self.activityIndicatorView.layer.masksToBounds = YES;
  [self.view addSubview:self.activityIndicatorView];
  [self.activityIndicatorView startAnimating];

}


- (void)closeLoadingView {
  [self.activityIndicatorView stopAnimating];
}

#pragma mark - 获取开奖数据
- (void)getOpensData:(NSString *)gameID isRefresh:(BOOL)isRefresh {

  if (gameID.length == 0 || gameID == nil) {
    return;
  }
  
  NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:[self filePath]];
  NSDictionary *gameData = [dataDict objectForKey:[NSString stringWithFormat:@"gameID%@",gameID]];
  
  if (gameData != nil && isRefresh == NO) {
    // 存在，并且不是刷新状态
    _gameID = gameID;
    // 有缓存 先渲染视图，不显示加载框。然后再继续去请求数据。
    [self handleData:gameData];
  } else if (isRefresh == YES) {
    // 刷新， // 不用读缓存，不显示加载框
  } else {
    [self loadingView];
  }
  
  NSDictionary *dict = @{@"ac":@"getTrenlistData", @"count":@"40", @"gameid": gameID};
    
    [NetRequest posRequestWithUrl:RunInfo.sharedRunInfo.url_str parameter:dict succeed:^(id response) {
      
      [self closeLoadingView];
      
        if (_gameID != gameID) {
          RunInfo.sharedRunInfo.currentIdx = 0; // (彩种和上次不同时)换彩种重置。
        }
        _gameID = gameID; // 请求成功，再改变gameID
      
        // 恢复视图位置
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recoverScrollViewPosition" object:nil];
      
        NSNumber *num = response[@"msg"];
        NSDictionary *data = response[@"data"];
        
        if ([num isEqual:@0]) {
          
          [self handleData:data];
          NSMutableDictionary *muDatadic = [NSMutableDictionary dictionaryWithContentsOfFile:[self filePath]];
          if (!muDatadic) {
              muDatadic = [NSMutableDictionary dictionary];
           }
          [muDatadic setObject:data forKey:[NSString stringWithFormat:@"gameID%@",gameID]];
          [muDatadic writeToFile:[self filePath] atomically:YES];
        }
    } failure:^(NSError *error) {
      
      [self closeLoadingView];
      
      self.errLabel.text = isRefresh ? @"刷新失败！" : @"加载失败！";
      [self.view addSubview:self.errLabel];
      
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.errLabel removeFromSuperview];
      });
      
      // 恢复视图位置
      [[NSNotificationCenter defaultCenter] postNotificationName:@"recoverScrollViewPosition" object:nil];
    }];
}


- (void)handleData:(NSDictionary *)data {
  NSArray *list = data[@"list"];
  NSDictionary *dict = @{@"game_id":_gameID, @"game_name":data[@"game_name"], @"isbuy":@(_isBuyEnter)};
  
  [RNBridgeModule postNotifyWithinfo: dict];
  
  _openDataModelArr = [RunOpenBallModel runOpenBallArr:list];
  
  NSMutableArray *ba_0Arr = [[NSMutableArray alloc] init];
  NSMutableArray *ba_1Arr = [[NSMutableArray alloc] init];
  NSMutableArray *ba_2Arr = [[NSMutableArray alloc] init];
  NSMutableArray *ba_3Arr = [[NSMutableArray alloc] init];
  NSMutableArray *ba_4Arr = [[NSMutableArray alloc] init];
  NSMutableArray *ba_5Arr = [[NSMutableArray alloc] init];
  NSMutableArray *ba_6Arr = [[NSMutableArray alloc] init];
  NSMutableArray *ba_7Arr = [[NSMutableArray alloc] init];
  NSMutableArray *ba_8Arr = [[NSMutableArray alloc] init];
  NSMutableArray *ba_9Arr = [[NSMutableArray alloc] init];
  
  _qiShuDataArr = [NSMutableArray array];
  
  NSString *js_tag = data[@"js_tag"];
  _kindGame = js_tag;
  
  if ([js_tag isEqualToString:@"k3"]) {
    _moreNum = 6; // 1 ~ 6
    
  } else if ([js_tag isEqualToString:@"11x5"]) {
    _moreNum = 11; // 1 ~ 11
    
  } else if ([js_tag isEqualToString:@"pk10"]) {
    _moreNum = 10; // 1 ~ 10
    
  } else {
    _moreNum = 10; // 0 ~ 9
  }
  
  for (int i = 0; i < _openDataModelArr.count; i++) {
    
    RunOpenBallModel *ballModel = _openDataModelArr[i];
    
    if (ballModel.ba_1 == nil || ballModel.ba_1.length == 0) {
      return ;
    }
    
    // 期数
    NSString *qishuStr = [ballModel.qishu substringFromIndex:ballModel.qishu.length - 3];
    [_qiShuDataArr addObject:qishuStr];
    
    // 每个彩种都有的前三位。
    [ba_0Arr addObject:ballModel.ba_0];
    [ba_1Arr addObject:ballModel.ba_1];
    [ba_2Arr addObject:ballModel.ba_2];
    
    if ([js_tag isEqualToString:@"ssc"]) {
      
      if ([self.gameID intValue] != 3) {
        [ba_3Arr addObject:ballModel.ba_3];
        [ba_4Arr addObject:ballModel.ba_4];
      }
      
    } else if ([js_tag isEqualToString:@"11x5"]) {
      [ba_3Arr addObject:ballModel.ba_3];
      [ba_4Arr addObject:ballModel.ba_4];
      
    } else if ([js_tag isEqualToString:@"pk10"]) {
      [ba_3Arr addObject:ballModel.ba_3];
      [ba_4Arr addObject:ballModel.ba_4];
      [ba_5Arr addObject:ballModel.ba_5];
      [ba_6Arr addObject:ballModel.ba_6];
      [ba_7Arr addObject:ballModel.ba_7];
      [ba_8Arr addObject:ballModel.ba_8];
      [ba_9Arr addObject:ballModel.ba_9];
    }
  }
  
  _openBallArr = [@[ba_0Arr, ba_1Arr, ba_2Arr] mutableCopy];
  
  if ([js_tag isEqualToString:@"ssc"]) {
    
    if ([self.gameID intValue] != 3) {
      [_openBallArr addObjectsFromArray:@[ba_3Arr, ba_4Arr]];
    }
    
  } else if ([js_tag isEqualToString:@"11x5"]) {
    [_openBallArr addObjectsFromArray:@[ba_3Arr, ba_4Arr]];
    
  } else if ([js_tag isEqualToString:@"pk10"]){
    [_openBallArr addObjectsFromArray:@[ba_3Arr, ba_4Arr, ba_5Arr, ba_6Arr, ba_7Arr, ba_8Arr, ba_9Arr]];
  }
  
  // 没有请求到开奖号码时，制造点出来
  if (_qiShuDataArr.count <= 0) {
    for (int k = 1; k <= 10; k++) {
      [_qiShuDataArr addObject:[NSString stringWithFormat:@"%02d", k]];
      for (int i = 0; i < _openBallArr.count; i++) {
        [_openBallArr[i] addObject:[NSString stringWithFormat:@"-%d", i+1]];
      }
    }
  }
  
  // 初始化头部的按钮 && RunPageViewController的加载
  [self initHeadView_Button];
}

- (NSString *)filePath {
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"opendata.plist"];
  return path;
}

- (UILabel *)errLabel {
  if (!_errLabel) {
    _errLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth * 0.4, 44*AdaptionHeight())];
    _errLabel.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)+CGRectGetMidY(self.view.bounds)*0.5);
    _errLabel.layer.cornerRadius = 8*AdaptionHeight();
    _errLabel.layer.masksToBounds = YES;
    _errLabel.textAlignment = NSTextAlignmentCenter;
    _errLabel.backgroundColor = [UIColor blackColor];
    _errLabel.textColor = [UIColor whiteColor];
    _errLabel.font = SystemFont_MinFont(17, 14);
  }
  return _errLabel;
}

@end
