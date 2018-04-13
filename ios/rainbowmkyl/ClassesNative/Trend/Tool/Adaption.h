//
//  Adaption.h
//  rainbowmkyl
//
//  Created by dodremteam on 2017/5/25.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#ifndef Adaption_h
#define Adaption_h

#import <UIKit/UIKit.h>

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth [UIScreen mainScreen].bounds.size.width

#define KAdaptionWith [UIScreen mainScreen].bounds.size.width / 414
#define KAdaptionHeight [UIScreen mainScreen].bounds.size.height / 736

// 7 Plus为参照尺寸
#define kBaseWidth 414
#define kBaseHeight 736

#define Inline static inline

// 适配比例 - 当前的屏幕尺寸／参照尺寸
Inline CGFloat AdaptionWith() {
    return kWidth / kBaseWidth;
}

Inline CGFloat AdaptionHeight() {
    return kHeight / kBaseHeight;
}

Inline CGFloat AdaptionX(CGFloat x) {
    return x * AdaptionWith();
}

Inline CGFloat AdaptionY(CGFloat y) {
    return y * AdaptionHeight();
}

Inline CGRect AdaptionRect(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    x = x * AdaptionWith();
    y = y * AdaptionHeight();
    width = width * AdaptionWith();
    height = height * AdaptionHeight();
    CGRect rect = CGRectMake(x, y, width, height);
    return rect;
}

Inline UIFont *SystemFont(CGFloat font) {
    return [UIFont systemFontOfSize:font * AdaptionWith()];
}

Inline UIFont *SystemFont_MinFont(CGFloat font, CGFloat minFont) {
    CGFloat newFont = font * AdaptionWith();
    newFont = newFont <= minFont ? minFont : newFont;
    return [UIFont systemFontOfSize:newFont];
}


Inline UIFont *BoldSystemFont (CGFloat font) {
    return [UIFont boldSystemFontOfSize:font * AdaptionWith()];
}

Inline UIFont *BoldSystemFont_MinFont(CGFloat font, CGFloat minFont) {
    CGFloat newFont = font * AdaptionWith();
    newFont = newFont <= minFont ? minFont : newFont;
    return [UIFont boldSystemFontOfSize:newFont];
}

#endif /* Adaption_h */
