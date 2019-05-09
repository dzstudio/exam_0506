//
//  SGGalleryViewCell.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/8.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "SGGalleryViewCell.h"

@interface SGGalleryViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SGGalleryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(6, 6)];
  CAShapeLayer *maskLayer = [CAShapeLayer new];
  maskLayer.frame = _imageView.bounds;
  maskLayer.path = maskPath.CGPath;
  _imageView.layer.mask = maskLayer;
}

- (void)setImage:(NSString *)imgUrl {
  [_imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}

@end
