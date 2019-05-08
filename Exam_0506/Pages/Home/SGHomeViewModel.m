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

- (void)refreshUnsplashPhotos:(SGLoadPhotoSuccess)complete {
  self.pageNum = 1;
  WeakSelf(self);
  [[SGUnsplashRequest instance] requestPhotos:@(self.pageNum) success:^(NSArray<SGUnplashPhotoModel *> *photos) {
    weakSelf.photos = [photos mutableCopy];
    complete(weakSelf.photos);
  } failure:^(NSError *error) {

  }];
}

- (void)loadUnsplashPhotos:(SGLoadPhotoSuccess)complete {
  if (_isLoadingMore) {
    return;
  }
  if (!self.photos) {
    self.photos = [NSMutableArray new];
  }
  _isLoadingMore = YES;
  WeakSelf(self);
  [[SGUnsplashRequest instance] requestPhotos:@(self.pageNum+1) success:^(NSArray<SGUnplashPhotoModel *> *photos) {
    weakSelf.pageNum++;
    [weakSelf.photos addObjectsFromArray:photos];
    complete(weakSelf.photos);
    weakSelf.isLoadingMore = NO;
  } failure:^(NSError *error) {
    weakSelf.isLoadingMore = NO;
  }];
}

@end
