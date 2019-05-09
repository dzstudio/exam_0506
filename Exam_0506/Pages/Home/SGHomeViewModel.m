//
//  SGHomeViewModel.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "SGHomeViewModel.h"

@interface SGHomeViewModel()

@property (nonatomic, assign) BOOL isLoadingMore;

@end

@implementation SGHomeViewModel

// 下拉刷新action处理器
- (void)refreshUnsplashPhotos:(SGLoadPhotoSuccess)complete {
  self.pageNum = 1;
  WeakSelf(self);
  [[SGUnsplashRequest instance] requestPhotos:@(self.pageNum) success:^(NSArray<SGUnplashPhotoModel *> *photos) {
    weakSelf.photos = [photos mutableCopy];
    complete(weakSelf.photos);
  } failure:^(NSError *error) {
    complete(nil);
  }];
}

// 上拉加载action处理器
- (void)loadUnsplashPhotos:(SGLoadPhotoSuccess)complete {
  // 多次收到加载下一页消息时，同时刻只发送一个网络请求
  if (_isLoadingMore) {
    return;
  }
  if (!self.photos) {
    self.photos = [NSMutableArray new];
  }
  _isLoadingMore = YES;
  WeakSelf(self);
  [[SGUnsplashRequest instance] requestPhotos:@(self.pageNum + 1) success:^(NSArray<SGUnplashPhotoModel *> *photos) {
    // 持有当前页码，数据获取成功后自动更新
    weakSelf.pageNum++;
    [weakSelf.photos addObjectsFromArray:photos];
    complete(weakSelf.photos);
    weakSelf.isLoadingMore = NO;
  } failure:^(NSError *error) {
    weakSelf.isLoadingMore = NO;
    complete(nil);
  }];
}

@end
