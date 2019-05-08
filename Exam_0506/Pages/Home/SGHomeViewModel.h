//
//  SGHomeViewModel.h
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SGLoadPhotoSuccess)(NSArray<SGUnplashPhotoModel *> *photos);

NS_ASSUME_NONNULL_BEGIN

@interface SGHomeViewModel : NSObject

@property (nonatomic) NSInteger pageNum;
@property (nonatomic, strong) NSMutableArray *photos; // 数据源

- (void)refreshUnsplashPhotos:(SGLoadPhotoSuccess)complete;
- (void)loadUnsplashPhotos:(SGLoadPhotoSuccess)complete;

@end

NS_ASSUME_NONNULL_END
