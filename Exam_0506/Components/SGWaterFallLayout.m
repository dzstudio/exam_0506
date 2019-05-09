//
//  SGWaterFallLayout.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "SGWaterFallLayout.h"

@interface SGWaterFallLayout()

/**
 item 的高度数组
 */
@property (nonatomic, copy) NSArray<NSNumber *> *arrItemHeight;
@property (nonatomic, strong) NSArray<UICollectionViewLayoutAttributes *> *arrAttributes;

@end

@implementation SGWaterFallLayout

/**
 瀑布流布局方法
 @param width item的宽度
 @param heightArray item的高度数组
 */
- (void)flowLayoutWithItemWidth:(CGFloat)width itemHeightArray:(NSArray<NSNumber *> *)heightArray {
  self.itemSize = CGSizeMake(width, 0);
  self.arrItemHeight = heightArray;
  [self.collectionView reloadData];
}

- (void)prepareLayout {
  [super prepareLayout];
  if ([self.arrItemHeight count] == 0) {
    return;
  }

  // 计算一行可以放多少个项
  NSInteger nItemInRow = (self.collectionViewContentSize.width - self.sectionInset.left - self.sectionInset.right + self.minimumInteritemSpacing) / (self.itemSize.width + self.minimumInteritemSpacing);

  // 对列的长度进行累计
  NSMutableArray *arrmColumnLength = [NSMutableArray arrayWithCapacity:100];
  for (NSInteger i = 0; i < nItemInRow; i++) {
    [arrmColumnLength addObject:@0];
  }

  NSMutableArray *arrmTemp = [NSMutableArray arrayWithCapacity:100];
  // 遍历设置每一个item的布局
  for (NSInteger i = 0; i < [self.arrItemHeight count]; i++) {
    // 设置每个item的位置等相关属性
    NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
    // 创建每一个布局属性类，通过indexPath来创建
    UICollectionViewLayoutAttributes *attris = [self layoutAttributesForItemAtIndexPath:index];
    CGRect recFrame = attris.frame;
    // 有数组得到的高度
    recFrame.size.height = [self.arrItemHeight[i] doubleValue];
    // 最短列序号
    NSInteger nNumShort = 0;
    // 最短的长度
    CGFloat fShortLength = [arrmColumnLength[0] doubleValue];
    // 比较是否存在更短的列
    for (int i = 1; i < [arrmColumnLength count]; i++) {
      CGFloat fLength = [arrmColumnLength[i] doubleValue];
      if (fLength < fShortLength) {
        nNumShort = i;
        fShortLength = fLength;
      }
    }
    // 插入到最短的列中
    recFrame.origin.x = self.sectionInset.left + (self.itemSize.width + self.minimumInteritemSpacing) * nNumShort;
    recFrame.origin.y = fShortLength + self.minimumLineSpacing;
    // 更新列的累计长度
    arrmColumnLength[nNumShort] = [NSNumber numberWithDouble:CGRectGetMaxY(recFrame)];

    // 更新布局
    attris.frame = recFrame;
    [arrmTemp addObject:attris];
  }
  self.arrAttributes = arrmTemp;

  // 因为使用了瀑布流布局使得滚动范围是根据 item 的大小和个数决定的，所以以最长的列为基准，将高度平均到每一个 cell 中
  // 最长列序号
  NSInteger nNumLong = 0;
  // 最长的长度
  CGFloat fLongLength = [arrmColumnLength[0] doubleValue];
  // 比较是否存在更短的列
  for (int i = 1; i < [arrmColumnLength count]; i++) {

    CGFloat fLength = [arrmColumnLength[i] doubleValue];
    if (fLength > fLongLength) {

      nNumLong = i;
      fLongLength = fLength;
    }
  }
  // 在大小一样的情况下，有多少行
  NSInteger nRows = ([self.arrItemHeight count] + nItemInRow - 1) / nItemInRow;
  self.itemSize = CGSizeMake(self.itemSize.width, (fLongLength + self.minimumLineSpacing) / nRows - self.minimumLineSpacing);
}

// 返回所有的 cell 布局数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  return [[NSArray alloc] initWithArray:self.arrAttributes copyItems:YES];
}

@end
