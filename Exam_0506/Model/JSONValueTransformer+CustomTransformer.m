//
//  JSONValueTransformer+CustomTransformer.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "JSONValueTransformer+CustomTransformer.h"

@implementation JSONValueTransformer (CustomTransformer)

- (NSDate *)NSDateFromNSString:(NSString *)string {
  NSDateFormatter *formatter = [NSDateFormatter new];
  formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";

  return [formatter dateFromString:string];
}

- (NSString *)JSONObjectFromNSDate:(NSDate *)date {
  NSDateFormatter *formatter = [NSDateFormatter new];
  formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";

  return [formatter stringFromDate:date];
}

@end
