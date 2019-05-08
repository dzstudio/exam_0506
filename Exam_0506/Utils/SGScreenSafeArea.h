//
//  SGScreenSafeArea.h
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define iPhoneX [SGScreenSafeArea isIPhoneXSeries]

@interface SGScreenSafeArea : NSObject

+ (UIEdgeInsets)safeAreaInsets;

+ (BOOL)safeAreaIsPhoneXFamily;

+ (BOOL)isIPhoneXSeries;

@end

