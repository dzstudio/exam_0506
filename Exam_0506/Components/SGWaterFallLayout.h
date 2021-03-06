//
//  SGWaterFallLayout.h
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGWaterFallLayout : UICollectionViewFlowLayout

- (void)flowLayoutWithItemWidth:(CGFloat)width itemHeightArray:(NSArray<NSNumber *> *)heightArray;

@end

NS_ASSUME_NONNULL_END
