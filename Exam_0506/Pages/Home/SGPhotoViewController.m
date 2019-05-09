//
//  SGPhotoViewController.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/9.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "SGPhotoViewController.h"
#import "SGUnplashPhotoModel.h"

@interface SGPhotoViewController ()<UIGestureRecognizerDelegate> {
  CGFloat _lastScale;
  CGRect _oldFrame;    //保存图片原来的大小
  CGRect _largeFrame;  //确定图片放大最大的程度
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SGPhotoViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:NO];
  [self.navigationController setHidesBarsOnTap:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.navigationController setNavigationBarHidden:YES];
  [self.navigationController setHidesBarsOnTap:NO];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Photo";
  if (_photo) {
    // 自动计算图片视图的frame，视图可手动缩放，所以不能用autolayout.
    CGFloat photoWidth = SG_SCREEN_WIDTH;
    CGFloat photoHeight = SG_SCREEN_WIDTH * _photo.height / _photo.width;
    CGFloat offsetTop = (SG_SCREEN_HEIGHT - photoHeight) / 2;
    _imageView.frame = CGRectMake(0, offsetTop, photoWidth, photoHeight);

    _oldFrame = _imageView.frame;
    _largeFrame = CGRectMake(0 - SG_SCREEN_WIDTH, 0 - SG_SCREEN_HEIGHT, 3 * _oldFrame.size.width, 3 * _oldFrame.size.height);

    // 注册缩放等手势
    [self addGestureRecognizerToView:_imageView];
    [self.view addSubview:_imageView];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    WeakSelf(self);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_photo.urls.regular] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
      [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
  }
}

// 添加所有的手势
- (void)addGestureRecognizerToView:(UIView *)view {
  // 旋转手势
  UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
  [view addGestureRecognizer:rotationGestureRecognizer];

  // 缩放手势
  UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
  [view addGestureRecognizer:pinchGestureRecognizer];

  // 移动手势
  UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
  [view addGestureRecognizer:panGestureRecognizer];
}

// 处理缩放手势
- (void)pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
  UIView *view = pinchGestureRecognizer.view;
  if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
    CGAffineTransform transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    CGFloat newWidth = transform.a * SG_SCREEN_WIDTH;
    if (newWidth < _oldFrame.size.width) {
      _imageView.frame = _oldFrame;
      //让图片无法缩得比原图小
    } else if (newWidth > 3 * _oldFrame.size.width) {
      _imageView.frame = _largeFrame;
    } else {
      view.transform = transform;
    }
    pinchGestureRecognizer.scale = 1;
  }
}

// 处理旋转手势
- (void)rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer {
  UIView *view = rotationGestureRecognizer.view;
  if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
    view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
    [rotationGestureRecognizer setRotation:0];
  }
}

// 处理拖拉手势
- (void)panView:(UIPanGestureRecognizer *)panGestureRecognizer {
  UIView *view = panGestureRecognizer.view;
  if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
    CGPoint translation = [panGestureRecognizer translationInView:view.superview];
    [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
    [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
  }
}

@end
