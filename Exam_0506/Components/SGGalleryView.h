//
//  SGGalleryView.h
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SGUnplashPhotoModel;

@protocol SGGalleryViewDelegate <NSObject>

@optional
- (void)onSGGalleryViewRefresh;
- (void)onSGGalleryViewLoadMore;
- (void)onSGGalleryViewTapDetail:(SGUnplashPhotoModel *)photo;

@end

@interface SGGalleryView : UICollectionView

@property (nonatomic, weak) NSArray *photos; // 数据源

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<SGGalleryViewDelegate>)delegate;
- (void)refreshPhotos:(NSArray *)array;
- (void)appendPhotos:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
