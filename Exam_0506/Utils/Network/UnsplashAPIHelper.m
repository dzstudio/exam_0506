//
//  RestAPIHelper.m
//  ios-newsapp-practice
//
//  Created by DillonZhang on 15/5/24.
//  Copyright (c) 2015年 dillonzhang. All rights reserved.
//

#import "UnsplashAPIHelper.h"
#import "SynthesizeSingleton.h"

#ifdef DEBUG
#define SERVER_URL        @"http://demo.bwker.com:8080"
#else
#define SERVER_URL        @"http://cjh.cjh168.com:8080"
#endif

const NSTimeInterval REQUEST_TIMEOUT = 30.;

@interface UnsplashAPIHelper()

@end

@implementation UnsplashAPIHelper

SYNTHESIZE_SINGLETON_FOR_CLASS(UnsplashAPIHelper);

#pragma mark singleton implementation
+ (UnsplashAPIHelper *)instance {
    return [self sharedRestAPIHelper];
}

+ (NSString *)serverUrl {
    return SERVER_URL;
}

- (void)buildCommonHeaders {
    [self.manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"platform"];
    [self.manager.requestSerializer setValue:[[Utils instance] getAppVersion] forHTTPHeaderField:@"apiVer"];
    [self.manager.requestSerializer setValue:[[Utils instance] getDeviceNo] forHTTPHeaderField:@"deviceNo"];
    [self.manager.requestSerializer setValue:Preferences.channelId forHTTPHeaderField:@"channelId"];
    [self.manager.requestSerializer setValue:Preferences.token forHTTPHeaderField:@"token"];
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
    NADLog(@"RestAPIHelper: ", @"%@%@", SERVER_URL, path);
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

- (id)syncPostRequestWithPath:(NSString *)path andParams:(NSDictionary *)params {
    [self buildCommonHeaders];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setTimeoutInterval:REQUEST_TIMEOUT];
	[urlRequest setCachePolicy:NSURLRequestReloadIgnoringCacheData];
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"content-type"];
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[urlRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/la/api%@", SERVER_URL, path]]];
  
	NSData *requestData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
	urlRequest.HTTPBody = requestData;
	NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
  
	return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
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
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.requestSerializer.timeoutInterval = REQUEST_TIMEOUT;
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }

    return _manager;
}

@end
