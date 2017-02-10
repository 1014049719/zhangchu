//
//  DDLUIKit.h
//  CookerProject
//
//  Created by vera on 15-1-23.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DDLUIKit : NSObject

/**
 提示框
 */
+ (void)showAlertViewWithMessage:(NSString *)message;

//显示网络提示
+ (void)showMBProgessHUDSuperView:(UIView *)superView animate:(BOOL)animate;
//隐藏网络提示
+ (void)hideAllProgessHUDSuperView:(UIView *)superView animate:(BOOL)animate;

@end
