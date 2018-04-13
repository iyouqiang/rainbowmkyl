//
//  UIColor+MCColor.h
//  rainbowmkyl
//
//  Created by dodreamteam on 17/2/18.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MCColor)

//从十六进制字符串获取颜色
//color：支持@“#123456”、@"0X123456"、@“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
