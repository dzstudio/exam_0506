//
//  SGHomeViewController.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/7.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "SGHomeViewController.h"
#import "SGGalleryView.h"
#import "SGHomeViewModel.h"
#import "SGPhotoViewController.h"

@interface SGHomeViewController ()<SGGalleryViewDelegate>

@property (nonatomic, strong) SGGalleryView *galleryView;
@property (nonatomic, strong) SGHomeViewModel *galleryViewModel;

@end

@implementation SGHomeViewController

// 初始化视图
- (void)initUI {
  CGFloat offset =  iPhoneX ? 45 : 0;
  CGRect frame = CGRectMake(0, offset, SG_SCREEN_WIDTH, SG_SCREEN_HEIGHT - offset);
  self.galleryView = [[SGGalleryView alloc] initWithFrame:frame delegate:self];
  self.galleryView.clipsToBounds = YES;
  [self.view addSubview:self.galleryView];
}

// 初始化数据
- (void)initData {
  self.galleryViewModel = [SGHomeViewModel new];
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  hud.mode = MBProgressHUDModeIndeterminate;
  [hud showAnimated:YES];
  [self onSGGalleryViewRefresh];
}

#pragma mark - SGGalleryViewDelegate
// 下拉刷新触发回调
- (void)onSGGalleryViewRefresh {
  WeakSelf(self);
  [self.galleryViewModel refreshUnsplashPhotos:^(NSArray<SGUnplashPhotoModel *> *photos) {
    if (photos) {
      [weakSelf.galleryView refreshPhotos:photos];
    }
    [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
  }];
}

// 上拉加载触发回调
- (void)onSGGalleryViewLoadMore {
  [self.galleryViewModel loadUnsplashPhotos:^(NSArray<SGUnplashPhotoModel *> *photos) {
    if (photos) {
      [self.galleryView appendPhotos:photos];
    }
  }];
}

// 单击图片回调
- (void)onSGGalleryViewTapDetail:(SGUnplashPhotoModel *)photo {
  SGPhotoViewController *photoVC = [[SGPhotoViewController alloc] initWithNibName:@"SGPhotoViewController" bundle:nil];
  [photoVC setPhoto:photo];
  [self.navigationController pushViewController:photoVC animated:YES];
}

@end
