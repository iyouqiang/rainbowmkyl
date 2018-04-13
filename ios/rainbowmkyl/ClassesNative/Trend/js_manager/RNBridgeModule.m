//
//  RNBridgeModule.m
//  
//
//  Created by Money on 2017/9/20.
//  Copyright © 2017年 Money. All rights reserved.
//

#import "RNBridgeModule.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+AFNetworking.h"

@implementation RNBridgeModule {
  
  UIImageView *loadImgView;
}

// 这个宏也可以添加一个参数用来指定在Javascript中访问这个模块的名字。如果你不指定，默认就会使用这个Objective-C类的名字
RCT_EXPORT_MODULE(RNBridgeModule)

// RCT_EXPORT_METHOD()宏,它可以指定Javascript方法名。来实现要给Javascript导出的方法
// 对外提供调用方法

RCT_EXPORT_METHOD(NetworkUrl:(NSString *)url) {
  NSLog(@"RN传入原生界面的URL：%@", url);
  RunInfo.sharedRunInfo.url_str = url;
}

RCT_EXPORT_METHOD(MainColor:(NSString *)color) {
  NSLog(@"RN传入原生界面的mainColor：%@", color);
  RunInfo.sharedRunInfo.mainColor = color;
}

RCT_EXPORT_METHOD(isRefresh:(BOOL)refresh) {
  NSLog(@"RN传入原生界面的isRefresh：%d", refresh);
  RunInfo.sharedRunInfo.isRefresh = refresh;
}

RCT_EXPORT_METHOD(Gameid:(NSString *)gameid isBuy:(BOOL)isBuy) {
  NSLog(@"RN传入原生界面请求走势的gameid：%@", gameid);
  RunInfo.sharedRunInfo.isBuyEnter = isBuy;
  RunInfo.sharedRunInfo.RN_gameid = gameid;
  // isBuy不走通知。
  if (!isBuy) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadingRunView" object:nil userInfo:@{@"Gameid":gameid, @"isBuy":@(isBuy)}];
      });
  }
}


RCT_EXPORT_METHOD(savePhoto:(NSString *)urlStr resolver:(RCTResponseSenderBlock)callback) {
  
  [self checkPhotosPermissions:^(BOOL granted) {
    
    if (!granted) {
        callback(@[@"到设置打开访问照片的权限"]);
        return;
    }
    
    [self loadingImage:urlStr callback:^(BOOL granted) {
      
        if (granted) {
          callback(@[@""]);
        }else {
          callback(@[@"保存图片失败"]);
        }
      
    }];
    
  }];
  
}

- (void)checkPhotosPermissions:(void(^)(BOOL granted))callback
{
  PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
  if (status == PHAuthorizationStatusAuthorized) {
    callback(YES);
    return;
  } else if (status == PHAuthorizationStatusNotDetermined) {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
      if (status == PHAuthorizationStatusAuthorized) {
        callback(YES);
        return;
      }else {
        callback(NO);
        return;
      }
    }];
  }else {
    callback(NO);
  }
}

- (void)loadingImage:(NSString *)urlStr callback:(void(^)(BOOL granted))callback{
  
  __weak RNBridgeModule *weakSelf = self;
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    loadImgView = [UIImageView new];
    
    [loadImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
      
      [weakSelf loadImageFinished:image callback:^(BOOL granted) {
        
        if (granted) {
           callback(YES);
        }else {
           callback(NO);
        }
        
      }];
      
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        callback(NO);
    }];
    
  });
  
}

- (void)loadImageFinished:(UIImage *)image callback:(void(^)(BOOL granted))callback
{
  [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
    //写入图片到相册
    [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    
  } completionHandler:^(BOOL success, NSError * _Nullable error) {
    
      if (success){
         callback(YES);
      }else {
         callback(NO);
      }
  }];
}

////////////////////////////////////////////
// OC调RN的方法。

- (NSArray<NSString *> *)supportedEvents {
  return @[@"SpotifyHelper"]; //这里返回的将是你要发送的消息名的数组。
}

- (void)startObserving {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emitEventRun:) name:@"RunZhang" object:nil];
}

- (void)stopObserving {
  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RunZhang" object:nil];
}

- (void)emitEventRun:(NSNotification *)notification {
  [self sendEventWithName:@"SpotifyHelper" body:notification.object];
}

+ (void)postNotifyWithinfo:(NSDictionary *)info {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"RunZhang" object:info];
}



@end
