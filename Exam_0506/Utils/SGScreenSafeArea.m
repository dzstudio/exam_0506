//
//  SGScreenSafeArea.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
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
