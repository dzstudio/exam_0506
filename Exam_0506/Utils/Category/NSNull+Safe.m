//
//  NSNull+Safe.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/7.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "NSNull+Safe.h"

@implementation NSNull (Safe)

- (void)forwardInvocation:(NSInvocation *)invocation {
    if ([self respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:selector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
  
    return sig;
}

@end
