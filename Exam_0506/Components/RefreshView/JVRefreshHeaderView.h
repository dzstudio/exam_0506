//
//  JVRefreshHeaderView.h
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import <MJRefresh/MJRefreshHeader.h>
#import <MJRefresh/MJRefresh.h>

@interface JVRefreshHeaderView : MJRefreshHeader

/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 进入刷新状态 */
- (void)beginRefreshing;
/** 结束刷新状态 */
- (void)endRefreshing;
/** 无动画结束刷新状态 */
- (void)endRefreshingWithoutAnimation;
/** 是否正在刷新 */
- (BOOL)isRefreshing;

@end

@interface UIViewController (JVRefreshHeaderView)

@end
