//
//  JVRotateView.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "JVRotateView.h"

@interface JVRotateView ()

@property (nonatomic , strong)UIImageView *imgViewLoad;
@property (nonatomic , assign)BOOL         isAnimation;

@end

@implementation JVRotateView

- (instancetype)init
{
    self = [self initWithImage:[UIImage imageNamed:@"jv_refresh"]];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
{
    CGFloat fwidth = 0.0f;
    CGFloat fheight = 0.0f;
    if (image) {
        fwidth = image.size.width;
        fheight = image.size.height;
    }
    CGRect frame = CGRectMake(0, 0, fwidth, fheight);
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializationWithImage:image];
    }
    return self;
}

- (void)initializationWithImage:(UIImage*)image
{
    if (image) {
        _imgViewLoad = [[UIImageView alloc]initWithImage:image];
        [self addSubview:_imgViewLoad];
    }
    self.backgroundColor = [UIColor clearColor];
    _isAutoStartAnimation = YES;
    _viscous = 10;
}



#pragma mark ===== LoadingView

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    if (hidden) {
        [self stopAnimating];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_isAutoStartAnimation) {
        [self startAnimating];
    }
}

- (void)removeFromSuperview
{
    [self stopAnimating];
    [super removeFromSuperview];
}

#pragma mark - Helper Method

- (void)startRotateAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    NSNumber *angle = [self.layer valueForKeyPath:@"transform.rotation.z"];
    animation.fromValue = angle;
    animation.toValue = @(2*M_PI+[angle floatValue]);
    animation.duration = 1.5f;
    animation.repeatCount = INT_MAX;
    [self.layer addAnimation:animation forKey:@"keyFrameAnimation"];
}

- (void)stopRotateAnimation
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.layer removeAllAnimations];
        self.alpha = 1;
    }];
}

#pragma mark - Public Method

- (BOOL)isAnimation
{
    return _isAnimation;
}

- (void)startAnimating
{
    if (_isAnimation) {
        return;
    }
    _isAnimation = YES;
    if (self.hidden == YES) {
        self.hidden = NO;
    }
    [self startRotateAnimation];
}

- (void)stopAnimating
{
    if (!_isAnimation) {
        return;
    }
    _isAnimation = NO;
    [self stopRotateAnimation];
}



@end
