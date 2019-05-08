//
//  RestAPIHelper.h
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface UnsplashAPIHelper : AFHTTPRequestSerializer

@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (UnsplashAPIHelper *)instance;

- (void)asyncGetWithPath:(NSString *)path andParams:(NSDictionary *)params andSuccess:(void (^)(id res))success andFailure:(void (^)(NSError *error))failure;
- (void)asyncPostWithPath:(NSString *)path andParams:(NSDictionary *)params andSuccess:(void (^)(id res))success andFailure:(void (^)(NSError *error))failure;

@end
