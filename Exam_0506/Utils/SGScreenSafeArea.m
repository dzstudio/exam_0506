//
//  JVScreenSafeArea.m
//  oversea_jv
//
//  Created by 严虎 on 2018/10/16.
//  Copyright © 2018 JD.com International Limited. All rights reserved.
//

#import "SGScreenSafeArea.h"

@implementation SGScreenSafeArea

+ (UIEdgeInsets)safeAreaInsets {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11, *)) {
        insets = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets;
    }
    return insets;
}

+ (BOOL)safeAreaIsPhoneXFamily {
    if (@available(iOS 11, *)) {
        UIEdgeInsets insets = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets;
        if (insets.top - 0.001 > 20.0f) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isIPhoneXSeries {
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (screenHeight == 812.0f || screenHeight == 896.0f) {
        return YES;
    }
    return NO;
}

@end
