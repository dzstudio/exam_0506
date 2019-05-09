//
//  SGBaseNavigationController.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/9.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "SGBaseNavigationController.h"

@interface SGBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation SGBaseNavigationController

- (void)viewDidLoad {
  [self setNavigationBarHidden:YES];
  // 解决navigationVC侧滑手势卡住问题
  self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  if (self.viewControllers.count <= 1 ) {
    return NO;
  }
  return YES;
}

@end
