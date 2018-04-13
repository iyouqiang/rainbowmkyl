//
//  NetRequest.m
//  rainbowmkyl
//
//  Created by dodreamteam on 2017/2/15.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "NetRequest.h"
#import "AFNetworking.h"

@implementation NetRequest

+ (void)posRequestWithUrl:(NSString *)url parameter:(NSDictionary *)parameter succeed:(Succeed)succeed failure:(Failure)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  
    manager.requestSerializer.timeoutInterval = 20.0;

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
  
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (succeed) {
           succeed(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (failure) {
           failure(error);
        }
    }];
}

@end
