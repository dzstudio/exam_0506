//
//  JVRefreshFooterView.h
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import <MJRefresh/MJRefreshAutoNormalFooter.h>

@interface JVRefreshFooterView : MJRefreshAutoNormalFooter

/** 创建footer */
+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建footer */
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 提示没有更多的数据 */
- (void)noticeNoMoreData;
/** 重置没有更多的数据（消除没有更多数据的状态） */
- (void)resetNoMoreData;

/** 进入刷新状态 */
- (void)beginRefreshing;
/** 结束刷新状态 */
- (void)endRefreshing;
/** 是否正在刷新 */
- (BOOL)isRefreshing;

@end
