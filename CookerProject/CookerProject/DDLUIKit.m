//
//  DDLUIKit.m
//  CookerProject
//
//  Created by vera on 15-1-23.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLUIKit.h"
#import "MBProgressHUD.h"

@implementation DDLUIKit

+ (void)showAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}

//显示网络提示
+ (void)showMBProgessHUDSuperView:(UIView *)superView animate:(BOOL)animate
{
    //提示
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:animate];
    //设置文字
    hud.labelText = @"正在加载...";
    //hud.detailsLabelText = @"请稍后";
}

//隐藏网络提示
+ (void)hideAllProgessHUDSuperView:(UIView *)superView animate:(BOOL)animate
{
    //隐藏
    [MBProgressHUD hideAllHUDsForView:superView animated:animate];
}

@end
