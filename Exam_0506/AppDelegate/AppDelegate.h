//
//  AppDelegate.h
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/7.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

void exeBlockInMain(dispatch_block_t block);
void exeBlockInBack(dispatch_block_t block);
void exeDelayBlockInMain(NSInteger second,dispatch_block_t block);
void exeDelayBlockInBack(NSInteger second,dispatch_block_t block);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

