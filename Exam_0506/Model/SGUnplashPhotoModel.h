//
//  SGUnplashPhotoModel.h
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SGUnplashPhotoUrlsModel;

@interface SGUnplashPhotoUrlsModel : JSONModel

@property (nonatomic) NSString *raw;
@property (nonatomic) NSString *full;
@property (nonatomic) NSString *regular;
@property (nonatomic) NSString *small;
@property (nonatomic) NSString *thumb;

@end

@interface SGUnplashPhotoModel : JSONModel

@property (nonatomic) NSString *photoId;
@property (nonatomic) NSDate *createdAt;
@property (nonatomic) NSDate *updatedAt;
@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger height;
@property (nonatomic) NSString *color;
@property (nonatomic) NSInteger likes;
@property (nonatomic) NSString<Optional> *desc;
@property (nonatomic) SGUnplashPhotoUrlsModel *urls;

@end

NS_ASSUME_NONNULL_END


//
//{
//  "id": "LBI7cgq3pbM",
//  "created_at": "2016-05-03T11:00:28-04:00",
//  "updated_at": "2016-07-10T11:00:01-05:00",
//  "width": 5245,
//  "height": 3497,
//  "color": "#60544D",
//  "likes": 12,
//  "liked_by_user": false,
//  "description": "A man drinking a coffee.",
//  "urls": {
//    "raw": "https://images.unsplash.com/face-springmorning.jpg",
//    "full": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg",
//    "regular": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=1080&fit=max",
//    "small": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=400&fit=max",
//    "thumb": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=200&fit=max"
//  }
//  },
