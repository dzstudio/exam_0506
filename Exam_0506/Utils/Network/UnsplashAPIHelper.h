//
//  RestAPIHelper.h
//  ios-newsapp-practice
//
//  Created by DillonZhang on 15/5/24.
//  Copyright (c) 2015年 dillonzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface UnsplashAPIHelper : AFHTTPRequestSerializer

@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (NSString *)serverUrl;

- (void)asyncGetWithPath:(NSString *)path andParams:(NSDictionary *)params andSuccess:(void (^)(id res))success andFailure:(void (^)(NSError *error))failure;
- (void)asyncPostWithPath:(NSString *)path andParams:(NSDictionary *)params andSuccess:(void (^)(id res))success andFailure:(void (^)(NSError *error))failure;
- (id)syncPostRequestWithPath:(NSString *)path andParams:(NSDictionary *)params;

@end
