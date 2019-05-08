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

@interface SGHomeViewController ()<SGGalleryViewDelegate>

@property (nonatomic, strong) SGGalleryView *galleryView;
@property (nonatomic, strong) SGHomeViewModel *galleryViewModel;

@end

@implementation SGHomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)initUI {
  CGFloat offset =  iPhoneX ? 45 : 64;
  CGRect frame = CGRectMake(0, offset, SG_SCREEN_WIDTH, SG_SCREEN_HEIGHT - offset);
  self.galleryView = [[SGGalleryView alloc] initWithFrame:frame delegate:self];
  [self.view addSubview:self.galleryView];
}

- (void)initData {
  self.galleryViewModel = [SGHomeViewModel new];
  [self onSGGalleryViewRefresh];
}

#pragma mark - SGGalleryViewDelegate
- (void)onSGGalleryViewRefresh {
  [self.galleryViewModel refreshUnsplashPhotos:^(NSArray<SGUnplashPhotoModel *> *photos) {
    [self.galleryView refreshPhotos:photos];
  }];
}

- (void)onSGGalleryViewLoadMore {
  [self.galleryViewModel loadUnsplashPhotos:^(NSArray<SGUnplashPhotoModel *> *photos) {
    [self.galleryView appendPhotos:photos];
  }];
}

- (void)onSGGalleryViewTapDetail:(NSString *)photo {

}

@end
