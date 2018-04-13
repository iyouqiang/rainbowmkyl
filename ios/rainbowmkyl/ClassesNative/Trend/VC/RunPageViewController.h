//
//  RunPageViewController.h
//  rainbowmkyl
//
//  Created by dodremteam on 2017/8/27.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshData)();

@interface RunPageViewController : UIViewController

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, copy) RefreshData refreshBlock;

@end
