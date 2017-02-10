//
//  DDLDeleteButton.m
//  CookerProject
//
//  Created by vera on 15-1-29.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLDeleteButton.h"

@interface DDLDeleteButton ()
{
    UILabel *titleLabel;
}

@end

@implementation DDLDeleteButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundImage:[UIImage imageNamed:@"智能选菜-材料背景"] forState:UIControlStateNormal];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 30, self.frame.size.height)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        int buttonHeight = 30;
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), self.frame.size.height/2-buttonHeight/2, buttonHeight, buttonHeight);
        [deleteButton setBackgroundImage:[UIImage imageNamed:@"智能选菜-删除"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
    }
    return self;
}

//删除
- (void)deleteButtonClick
{
    //回调
    if ([_delegate respondsToSelector:@selector(didClickDeleteButton:)])
    {
        [_delegate didClickDeleteButton:self];
    }
}

//赋值
- (void)setDeleteButtonTitle:(NSString *)title
{
    titleLabel.text = title;
}

//设置文字字体大小
- (void)setDeleteButtonTitleFont:(UIFont *)font
{
    titleLabel.font = font;
}

//设置文字颜色
- (void)setDeleteButtonTitleColor:(UIColor *)color
{
    titleLabel.textColor = color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
