//
//  JVScreenSafeArea.h
//  oversea_jv
//
//  Created by 严虎 on 2018/10/16.
//  Copyright © 2018 JD.com International Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define iphoneX [JVScreenSafeArea isIPhoneXSeries]

@interface SGScreenSafeArea : NSObject

+ (UIEdgeInsets)safeAreaInsets;

+ (BOOL)safeAreaIsPhoneXFamily;

+ (BOOL)isIPhoneXSeries;

@end

