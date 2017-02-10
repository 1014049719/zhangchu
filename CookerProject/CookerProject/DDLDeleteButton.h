//
//  DDLDeleteButton.h
//  CookerProject
//
//  Created by vera on 15-1-29.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDLDeleteButton;

@protocol DDLDeleteButtonDelegate <NSObject>

- (void)didClickDeleteButton:(DDLDeleteButton *)button;

@end

@interface DDLDeleteButton : UIButton

@property (nonatomic,assign)id<DDLDeleteButtonDelegate> delegate;

//赋值
- (void)setDeleteButtonTitle:(NSString *)title;

//设置文字字体大小
- (void)setDeleteButtonTitleFont:(UIFont *)font;

//设置文字颜色
- (void)setDeleteButtonTitleColor:(UIColor *)color;


@end
