//
//  SGGalleryView.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "SGGalleryView.h"
#import "SGGalleryViewCell.h"
#import "SGUnplashPhotoModel.h"
#import "SGWaterFallLayout.h"

static NSString * const GalleryCellReuseTag = @"sg_gallery_view_cell";

@interface SGGalleryView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) id<SGGalleryViewDelegate> galleryDelegate;

@end

@implementation SGGalleryView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<SGGalleryViewDelegate>)delegate {
  if (self = [super initWithFrame:frame collectionViewLayout:[SGWaterFallLayout new]]) {
    self.galleryDelegate = delegate;
    self.delegate = self;
    self.dataSource = self;
    [self initUI];
  }
  
  return self;
}

- (void)initUI {
  // 注册下拉刷新组件
  WeakSelf(self);
  self.mj_header = [JVRefreshHeaderView headerWithRefreshingBlock:^{
    [weakSelf.galleryDelegate onSGGalleryViewRefresh];
  }];

  SGWaterFallLayout *layout = (SGWaterFallLayout *)self.collectionViewLayout;
  layout.minimumLineSpacing = 15;
  layout.minimumInteritemSpacing = 15;
  layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 0);
  self.backgroundColor = [UIColor whiteColor];
  [self registerNib:[UINib nibWithNibName:@"SGGalleryViewCell" bundle:nil] forCellWithReuseIdentifier:GalleryCellReuseTag];
}

- (void)updateFlowLayout {
  CGFloat itemWidth = (SG_SCREEN_WIDTH - 45) / 2;
  NSMutableArray *heightArr = [NSMutableArray arrayWithCapacity:self.photos.count];
  [self.photos enumerateObjectsUsingBlock:^(SGUnplashPhotoModel *photo, NSUInteger idx, BOOL * _Nonnull stop) {
    CGFloat cellHeight = photo.width > 0 ? itemWidth * photo.height / photo.width : itemWidth + 15;
    [heightArr addObject:@(cellHeight)];
  }];
  SGWaterFallLayout *layout = (SGWaterFallLayout *)self.collectionViewLayout;
  [layout flowLayoutWithItemWidth:itemWidth itemHeightArray:heightArr];
}

- (void)refreshPhotos:(NSArray *)array {
  self.photos = array;
  [self updateFlowLayout];
  [self.mj_header endRefreshing];
}

- (void)appendPhotos:(NSArray *)array {
  self.photos = array;
  [self updateFlowLayout];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if ([self.galleryDelegate respondsToSelector:@selector(onSGGalleryViewTapDetail:)]) {
    SGUnplashPhotoModel *photo = [self.photos objectAtIndex:indexPath.row];
    [self.galleryDelegate onSGGalleryViewTapDetail:photo];
  }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.photos.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  SGUnplashPhotoModel *photo = [self.photos objectAtIndex:indexPath.row];
  CGFloat cellWidth = (SG_SCREEN_WIDTH - 45) / 2;
  CGFloat cellHeight = photo.width > 0 ? cellWidth * photo.height / photo.width : cellWidth;

  return CGSizeMake(cellWidth, cellHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  SGGalleryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GalleryCellReuseTag forIndexPath:indexPath];
  SGUnplashPhotoModel *photo = [self.photos objectAtIndex:indexPath.row];
  [cell setImage:photo.urls.thumb];
  // 判断已加载数量，自动请求下一页
  if (self.photos.count - indexPath.row <= 5) {
    if ([self.galleryDelegate respondsToSelector:@selector(onSGGalleryViewLoadMore)]) {
    	[self.galleryDelegate onSGGalleryViewLoadMore];
    }
  }
  
  return cell;
}

@end
