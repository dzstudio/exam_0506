//
//  RestAPIHelper.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "UnsplashAPIHelper.h"

#define SERVER_URL

static NSString *serverUrl = @"https://api.unsplash.com/";
static NSString *accessKey = @"b94bb97adf24f08915d2d51c0b589372b9b15dcc40ff9702aa63f4b52930f268";

const NSTimeInterval REQUEST_TIMEOUT = 30.;

@implementation UnsplashAPIHelper

SYNTHESIZE_SINGLETON_FOR_CLASS(UnsplashAPIHelper);

#pragma mark singleton implementation
+ (UnsplashAPIHelper *)instance {
  return [self sharedUnsplashAPIHelper];
}

- (void)buildCommonHeaders {
  [self.manager.requestSerializer setValue:[NSString stringWithFormat:@"Client-ID %@", accessKey] forHTTPHeaderField:@"Authorization"];
}

/*
 异步GET API请求
 */
- (void)asyncGetWithPath:(NSString *)path andParams:(NSDictionary *)params andSuccess:(void (^)(id res))success andFailure:(void (^)(NSError *error))failure {
  [self showNetworkActivityIndicator];
  [self buildCommonHeaders];
  [self.manager GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    // 这里可以获取到目前的数据请求的进度
  } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
    // 请求成功，解析数据
    [self hideNetworkActivityIndicator];
    success(responseObject);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    // 请求失败
    [self hideNetworkActivityIndicator];
    failure(error);
  }];
}

/*
 异步POST API请求
 */
- (void)asyncPostWithPath:(NSString *)path andParams:(NSDictionary *)params andSuccess:(void (^)(id res))success andFailure:(void (^)(NSError *error))failure {
  [self buildCommonHeaders];
  path = [NSString stringWithFormat:@"/la/api%@", path];
  [self.manager POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    // 这里可以获取到目前的数据请求的进度
  } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
    // 请求成功，解析数据
    [self hideNetworkActivityIndicator];
    success(responseObject);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    // 请求失败
    [self hideNetworkActivityIndicator];
    failure(error);
  }];
}

/*
 Description:showing network spinning gear in status bar
 */
- (void)showNetworkActivityIndicator {
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

/*
 Description:hide network spinning gear in status bar
 */
- (void)hideNetworkActivityIndicator {
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - Properties
- (AFHTTPSessionManager *)manager {
  if (_manager == nil) {
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:serverUrl]];
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _manager.requestSerializer.timeoutInterval = REQUEST_TIMEOUT;
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
  }

  return _manager;
}

@end

