//
//  JVRefreshFooterView.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "JVRefreshFooterView.h"

@interface JVRefreshFooterView ()

@property (nonatomic , strong) UIImageView *imgViewNoData;
@property (nonatomic , assign) CGFloat heightForNoDataFooter;
@property (nonatomic , assign) BOOL isNoDataState;

@end

@implementation JVRefreshFooterView

#pragma mark - Note Method


+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    return [super footerWithRefreshingBlock:refreshingBlock];
}

+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    return [super footerWithRefreshingTarget:target refreshingAction:action];
}

- (void)noticeNoMoreData
{
    [super endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData
{
    [self setFooterDefault];
    [super resetNoMoreData];
}

- (void)beginRefreshing
{
    [super beginRefreshing];
}

- (void)endRefreshing
{
    [super endRefreshing];
}

- (BOOL)isRefreshing
{
    return [super isRefreshing];
}


#pragma mark - override

- (void)prepare
{
    [super prepare];
    self.stateLabel.textColor = [UIColor colorWithRed:185/255.f green:186/255.f blue:187/255.f alpha:1.0];
    [self setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    UIImageView *imgViewNoData = [[UIImageView alloc]initWithFrame:CGRectMake(0, 25, SG_SCREEN_WIDTH, 40)];
    [imgViewNoData setImage:[UIImage imageNamed:@"history_end"]];
    [imgViewNoData setContentMode:UIViewContentModeScaleAspectFit];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:imgViewNoData];
    self.imgViewNoData = imgViewNoData;
    [self.imgViewNoData setHidden:YES];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews{
    [super placeSubviews];
    if (self.isNoDataState) {
         self.stateLabel.frame = CGRectMake(0, self.imgViewNoData.mj_size.height, self.bounds.size.width, 21);
    }
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
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
//    if (self.isNoDataState && !self.arrowView.hidden) {
//        self.arrowView.hidden = YES;
//    }
}

- (BOOL)isNoDataState
{
    return self.mj_h == self.heightForNoDataFooter;
}

- (CGFloat)heightForNoDataFooter
{
    return MJRefreshFooterHeight + self.imgViewNoData.image.size.height/2;
}

- (void)setFooterDefault
{
    if (self.isNoDataState) {
//        self.scrollView.mj_insetB -= self.mj_h;
        self.mj_h = MJRefreshFooterHeight;
        [self.imgViewNoData setHidden:YES];
    }
}

- (void)setFooterNoData
{
    if (!self.isNoDataState) {
//        [self.arrowView setHidden:YES];
        self.mj_h = self.heightForNoDataFooter;
//        self.scrollView.mj_insetB += self.mj_h;
        [self.imgViewNoData setHidden:NO];
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshState theOldState = self.state;
    if (state == theOldState) return;
    if (self.isNoDataState) return;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self setFooterDefault];
            break;
        case MJRefreshStatePulling:
            [self.imgViewNoData setHidden:YES];
            break;
        case MJRefreshStateRefreshing:
            [self.imgViewNoData setHidden:YES];
            break;
        case MJRefreshStateNoMoreData:
            [self setFooterNoData];
            break;
        default:
            break;
    }
    
    MJRefreshCheckState;
    //error when MJRefreshStateNoMoreData arrowView hiden Yes after animation,it was reseted NO
}

@end
