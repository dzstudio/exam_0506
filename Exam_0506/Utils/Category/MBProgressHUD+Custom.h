//
//  MBProgressHUD+Custom.h
//  Exam_0506
//
//  Created by DillonZhang on 2019/5/9.
//  Copyright © 2019 dzstudio. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

typedef void(^MBProgressHUDCancelBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Custom)

/**
 *  显示在window上loading
 */
+ (void)showLoadingMessagesAtWindow:(NSString *)message
                    withCancelBlock:(MBProgressHUDCancelBlock)cancelBlock;

/**
 *  取消windowloading
 */
+ (void)dissmisLoadingAtWindow;


/**
 *  显示在window上提示,白色背景
 */
+ (void)showTipsMessagesAtWindow:(NSString *)message
                           image:(UIImage *)image
                 withCancelBlock:(MBProgressHUDCancelBlock)cancelBlock;

/**
 *  取消Tip
 */
+ (void)dissmisTipsAtWindow;


/**
 *  显示提示消息,白色背景
 */
+ (void)showTipsAtWindowAutoHide:(NSString *)message;

+ (void)showMessagesAtView:(UIView *)view autoHide:(NSString *)messgae;

/**
 *  显示提示消息
 */
+ (void)showMessagesAtWindowAutoHide:(NSString *)message
                          afterDelay:(NSTimeInterval)delay;

/**
 *  显示在window上带自定义图标、消息、及延时自动消失
 */
+ (void)showAlertMessagesWithIconAtWindow:(NSString *)message
                                    image:(UIImage *)image
                               afterDelay:(NSTimeInterval)delay;

/**
 *  自动消失，并回调
 */
+ (void)showMessagesAtWindowAutoHide:(NSString *)message
                     withCancelBlock:(MBProgressHUDCancelBlock)cancelBlock;

/**
 *  取消loading
 */
+ (void)dissmisLoadingAtView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
