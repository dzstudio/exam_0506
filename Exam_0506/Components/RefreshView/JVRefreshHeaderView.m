//
//  JVRefreshHeaderView.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "JVRefreshHeaderView.h"
#import "JVRotateView.h"

#define Notification_JVRefreshHeaderView_Animation_Resume @"Notification_JVRefreshHeaderView_Animation_Resume"

#define Notification_JVRefreshHeaderView_Animation_Pause @"Notification_JVRefreshHeaderView_Animation_Pause"

@interface JVRefreshHeaderView()

@property (weak , nonatomic)JVRotateView *loading;
@end

@implementation JVRefreshHeaderView

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.state == MJRefreshStateRefreshing) {
        if (self.loading) {
            [self.loading startAnimating];
        }
    }
}

- (void)prepare
{
    [super prepare];
    
    CGFloat offset = iPhoneX ? 10 : 0;
    self.mj_h += offset;

    JVRotateView *loading = [[JVRotateView alloc]init];
    loading.isAutoStartAnimation = NO;
    [self addSubview:loading];
    self.loading = loading;
    
}

- (void)placeSubviews
{
    [super placeSubviews];
    CGFloat offset = iPhoneX ? 15 : 0;
    self.loading.center = CGPointMake(self.mj_w*0.5, self.mj_h * 0.5 + offset);
}


#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            break;
        case MJRefreshStateRefreshing:
            [self.loading startAnimating];
            break;
        default:
            break;
    }
}

- (void)endRefreshing
{
    [UIView transitionWithView:self.loading
                      duration:0.3f
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^
     {
         self.loading.layer.transform = CATransform3DRotate(
                                                            CATransform3DMakeScale(0.01f, 0.01f, 0.1f), -M_PI, 0, 0, 1);
     } completion:^(BOOL finished)
     {
         [super endRefreshing];
     }];
}

- (void)endRefreshingWithoutAnimation {
    self.loading.layer.transform = CATransform3DRotate(
                                                       CATransform3DMakeScale(0.01f, 0.01f, 0.1f), -M_PI, 0, 0, 1);
    [super endRefreshing];
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    CGFloat r = pullingPercent*M_PI*2;
    self.loading.layer.transform = CATransform3DMakeRotation(r, 0, 0, 1.0);
}


#pragma mark - Helper Resume Method

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillAppearNotify:) name:Notification_JVRefreshHeaderView_Animation_Resume object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillDisappearNotify:) name:Notification_JVRefreshHeaderView_Animation_Pause object:nil];
    
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppearNotify:(NSNotification *)ntfication
{
    UIViewController *weak = ntfication.object;
    if (weak && [weak isKindOfClass:[UIViewController class]] && [weak isEqual:[self getViewController]]) {
        if (self.state == MJRefreshStateRefreshing  && self.loading) {
            [self.loading startAnimating];
        }
    }
}

- (void)viewWillDisappearNotify:(NSNotification *)ntfication
{
    UIViewController *weak = ntfication.object;
    if (weak && [weak isKindOfClass:[UIViewController class]] && [weak isEqual:[self getViewController]]) {
        if (self.state == MJRefreshStateRefreshing  && self.loading) {
            [self.loading stopAnimating];
        }
    }
    
}

- (UIViewController*)getViewController {
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

#pragma mark - Note Method 

- (void)beginRefreshing
{
    [super beginRefreshing];
}

- (BOOL)isRefreshing
{
    return [super isRefreshing];
}

+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    return [super headerWithRefreshingBlock:refreshingBlock];
}
/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    return [super headerWithRefreshingTarget:target refreshingAction:action];
}
@end


#pragma mark - UIViewController (JVRefreshHeaderView)
#pragma mark -

@implementation UIViewController (JVRefreshHeaderView)

+(void)swizzleMethod:(Class)srcClass srcSel:(SEL)srcSel tarClass:(Class)tarClass tarSel:(SEL)tarSel{
    if (!srcClass) {
        return;
    }
    if (!srcSel) {
        return;
    }
    if (!tarClass) {
        return;
    }
    if (!tarSel) {
        return;
    }
    
    @try {
        Method srcMethod = class_getInstanceMethod(srcClass,srcSel);
        Method tarMethod = class_getInstanceMethod(tarClass,tarSel);
        method_exchangeImplementations(srcMethod, tarMethod);
    }
    @catch (NSException *exception) {
    }
    @finally {
        
    }
}

- (void)replaceViewWillAppear:(BOOL)animated
{
    [self replaceViewWillAppear:animated];
    
    __weak UIViewController *weakSelf = self;
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_JVRefreshHeaderView_Animation_Resume object:weakSelf];
}


- (void)replaceViewWillDisappear:(BOOL)animated
{
    [self replaceViewWillDisappear:animated];
    __weak UIViewController *weakSelf = self;
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_JVRefreshHeaderView_Animation_Pause object:weakSelf];
}

+ (void) load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzleMethod:[self class] srcSel:@selector(replaceViewWillAppear:) tarClass:[UIViewController class] tarSel:@selector(viewWillAppear:)];
        [self swizzleMethod:[self class] srcSel:@selector(replaceViewWillDisappear:) tarClass:[UIViewController class] tarSel:@selector(viewWillDisappear:)];
    });
}

@end


