//
//  SGUnsplashRequest.h
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGUnplashPhotoModel;

typedef void(^SGUnsplashRequestSuccess)(NSArray<SGUnplashPhotoModel *> *photos);
typedef void(^resultErrBlock)(NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface SGUnsplashRequest : NSObject

+ (SGUnsplashRequest *)instance;

- (void)requestPhotos:(NSNumber *)page
              success:(SGUnsplashRequestSuccess)succBlock
              failure:(resultErrBlock)errBlock;

@end

NS_ASSUME_NONNULL_END
