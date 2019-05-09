//
//  MBProgressHUD+Custom.m
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/9.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import "MBProgressHUD+Custom.h"

static MBProgressHUDCancelBlock staticCancelBlock = nil;

@implementation MBProgressHUD (Custom)

/**
 *  显示在window上loading
 */
+ (void)showLoadingMessagesAtWindow:(NSString *)message
                    withCancelBlock:(MBProgressHUDCancelBlock)cancelBlock {
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];

  //custom No text
  hud.backgroundColor = [UIColor clearColor];
  hud.mode = MBProgressHUDModeCustomView;

  [hud showAnimated:YES];
  hud.userInteractionEnabled = YES;

  staticCancelBlock = cancelBlock;

  //add taget
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDissmisLoadingAtWindow)];
  [hud addGestureRecognizer:tapGesture];
}

+ (void)tapDissmisLoadingAtWindow {
  if (staticCancelBlock) {
    staticCancelBlock();
    //clear
    staticCancelBlock = nil;
  }
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  [self hideHUDForView:window animated:YES];
}


/**
 *  取消windowloading
 */
+ (void)dissmisLoadingAtWindow {
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  [self hideHUDForView:window animated:YES];
}


/**
 *  显示在window上提示,白色背景
 */
+ (void)showTipsMessagesAtWindow:(NSString *)message
                           image:(UIImage *)image
                 withCancelBlock:(MBProgressHUDCancelBlock)cancelBlock {
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];

  if (image) {
    hud.customView = [[UIImageView alloc]initWithImage:image];
  }
  hud.backgroundColor = [UIColor colorWithHexColorString:@"262626" alpha:0.2];
  hud.mode = MBProgressHUDModeCustomView;
  hud.detailsLabel.text = message;
  staticCancelBlock = cancelBlock;

  //add taget
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDissmisLoadingAtWindow)];
  [hud addGestureRecognizer:tapGesture];
}

/**
 *  取消Tip
 */
+ (void)dissmisTipsAtWindow {
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  [self hideHUDForView:window animated:YES];
}

/**
 *  显示提示消息,白色背景
 */
+ (void)showTipsAtWindowAutoHide:(NSString *)message {
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
  hud.mode = MBProgressHUDModeText;
  hud.backgroundColor = [UIColor colorWithHexColorString:@"262626" alpha:0.2];
  hud.bezelView.color = [UIColor whiteColor];
  hud.label.textColor = [UIColor colorWithHexColorString:@"bbbbbb"];
  hud.detailsLabel.textColor = [UIColor blackColor];
  hud.detailsLabel.text = message;
  hud.detailsLabel.font = [UIFont systemFontOfSize:20.0f];
  [hud showAnimated:YES];
  [hud hideAnimated:YES afterDelay:1.5f];
}

+ (void)showMessagesAtView:(UIView *)view autoHide:(NSString *)messgae {
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
  hud.mode = MBProgressHUDModeText;
  hud.detailsLabel.text = messgae;
  hud.detailsLabel.font = [UIFont systemFontOfSize:20.0f];
  [hud showAnimated:YES];
  [hud hideAnimated:YES afterDelay:1.5f];
}

/**
 *  显示提示消息
 */
+ (void)showMessagesAtWindowAutoHide:(NSString *)message
                          afterDelay:(NSTimeInterval)delay {
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
  hud.mode = MBProgressHUDModeText;
  hud.detailsLabel.text = message;
  hud.detailsLabel.font = [UIFont systemFontOfSize:20.0f];
  [hud showAnimated:YES];

  [hud hideAnimated:YES afterDelay:delay];
}

/**
 *  显示在window上带自定义图标、消息、及延时自动消失
 */
+ (void)showAlertMessagesWithIconAtWindow:(NSString *)message
                                    image:(UIImage *)image
                               afterDelay:(NSTimeInterval)delay {
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
  hud.mode = MBProgressHUDModeCustomView;
  hud.margin = 0.0f;
  hud.bezelView.color = [UIColor colorWithHexColorString:@"222222" alpha:0.9];
  UIView *customAlertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 90)];
  customAlertView.center = hud.center;
  UIImageView *alertImageView = [[UIImageView alloc]initWithFrame:CGRectMake(138, 20, 24, 24)];
  [alertImageView setImage:image];
  [customAlertView addSubview:alertImageView];
  UILabel *alertMessageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
  alertMessageLabel.text = message;
  alertMessageLabel.textColor = [UIColor whiteColor];
  alertMessageLabel.textAlignment = NSTextAlignmentCenter;
  alertMessageLabel.numberOfLines = 0;
  alertMessageLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"size:16.f];
  [customAlertView addSubview:alertMessageLabel];
  NSDictionary *dict = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular"size:16.f]};
  CGRect lineSize = [message boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading) attributes:dict context:nil];
  alertMessageLabel.frame = CGRectMake(15, 54, 270, lineSize.size.height);
  customAlertView.frame = CGRectMake(0, 0, 300, 84+lineSize.size.height);
  hud.customView = customAlertView;
  [hud showAnimated:YES];
  [hud hideAnimated:YES afterDelay:delay];

}

/**
 *  自动消失，并回调
 */
+ (void)showMessagesAtWindowAutoHide:(NSString *)message
                     withCancelBlock:(MBProgressHUDCancelBlock)cancelBlock {
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
  hud.mode = MBProgressHUDModeText;
  hud.detailsLabel.text = message;
  hud.detailsLabel.font = [UIFont systemFontOfSize:20.0f];
  [hud showAnimated:YES];
  [hud hideAnimated:YES afterDelay:1.5f];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    if(cancelBlock)
      cancelBlock();
  });
}

+ (void)showMessagesAtWindow:(NSString *)message {
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  UIView* view = [[UIView alloc] initWithFrame:window.bounds];
  view.backgroundColor = [UIColor blackColor];
  view.alpha = 0.4;
  [window addSubview:view];
  staticCancelBlock =^{
    [UIView animateWithDuration:0.3 animations:^{
      view.alpha = 0 ;} completion:^(BOOL finished) {
        [view removeFromSuperview];
      }];
  };

  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
  hud.mode = MBProgressHUDModeText;
  hud.detailsLabel.text = message;
  hud.detailsLabel.font = [UIFont systemFontOfSize:14.0f];
  [hud showAnimated:YES];

  hud.userInteractionEnabled = YES;
  //add taget
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDissmisLoadingAtWindow)];
  [hud addGestureRecognizer:tapGesture];
}

/**
 *  取消loading
 */
+ (void)dissmisLoadingAtView:(UIView *)view {
  [self hideHUDForView:view animated:YES];
}

@end
