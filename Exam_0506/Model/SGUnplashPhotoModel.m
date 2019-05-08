//
//  SGUnplashPhotoModel.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "SGUnplashPhotoModel.h"
#import "JSONValueTransformer+CustomTransformer.h"

@implementation SGUnplashPhotoUrlsModel

@end

@implementation SGUnplashPhotoModel

+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                @"photoId": @"id",
                                                                @"createdAt": @"created_at",
                                                                @"updatedAt": @"updated_at",
                                                                @"desc": @"description"
                                                                }];
}

@end
