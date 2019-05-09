//
//  JVRotateView.h
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_INLINE CGFloat distansBetween(CGPoint p1 , CGPoint p2) {
    return sqrtf((p1.x - p2.x)*(p1.x - p2.x) + (p1.y - p2.y)*(p1.y - p2.y));
}

@interface JVRotateView : UIView

@property (nonatomic , assign)CGFloat viscous;


#pragma mark - LoadingView

//default YES
@property (nonatomic , assign) BOOL isAutoStartAnimation;



- (instancetype)initWithImage:(UIImage*)image;

- (BOOL)isAnimation;

- (void)startAnimating;

- (void)stopAnimating;


@end
