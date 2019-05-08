//
//  SGUnsplashRequest.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "SGUnsplashRequest.h"
#import "UnsplashAPIHelper.h"
#import "SGUnplashPhotoModel.h"

@implementation SGUnsplashRequest

SYNTHESIZE_SINGLETON_FOR_CLASS(SGUnsplashRequest);

#pragma mark singleton implementation
+ (SGUnsplashRequest *)instance {
  return [self sharedSGUnsplashRequest];
}

- (void)requestPhotos:(NSNumber *)page success:(SGUnsplashRequestSuccess)succBlock failure:(resultErrBlock)errBlock {
  [[UnsplashAPIHelper instance] asyncGetWithPath:@"/photos" andParams:@{@"page":page} andSuccess:^(id res) {
    NAILog(@"Request", @"%@", res);
    if ([res isKindOfClass:[NSArray class]]) {
      __block NSMutableArray *result = [NSMutableArray new];
      [(NSArray *)res enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSError *err;
        SGUnplashPhotoModel *photo = [[SGUnplashPhotoModel alloc] initWithDictionary:obj error:&err];
        if (photo) {
          [result addObject:photo];
        }
      }];
      succBlock(result);
    }
  } andFailure:^(NSError *error) {
    errBlock(error);
  }];
}

@end
