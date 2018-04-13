//
//  NetRequest.h
//  rainbowmkyl
//
//  Created by dodreamteam on 2017/2/15.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Succeed)(id response);
typedef void(^Failure)(NSError *error);

@interface NetRequest : NSObject

+(void)posRequestWithUrl:(NSString *)url parameter:(NSDictionary *)parameter succeed:(Succeed)succeed failure:(Failure)failure;


@end
