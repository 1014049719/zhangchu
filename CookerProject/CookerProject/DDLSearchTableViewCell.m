//
//  DDLSearchTableViewCell.m
//  CookerProject
//
//  Created by vera on 15-1-30.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLSearchTableViewCell.h"
#import "DDLCustomButton.h"

@implementation DDLSearchTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.vegetableScrollView.showsHorizontalScrollIndicator = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//添加按钮
- (void)addButtonToScrollView:(NSArray *)imageNames titles:(NSArray *)titles
{

    //先移除
    for (UIView *subView in _vegetableScrollView.subviews)
    {
        if ([subView isKindOfClass:[DDLCustomButton class]])
        {
            [subView removeFromSuperview];
        }
    }
    
    //在添加
    int space = 10;
    
    int buttonWidth = (self.frame.size.width - 3*space)/4;
    int buttonHeight = buttonWidth;
    
    int maxWidth = 0;
    
    //添加按钮
    for (int i = 0; i < imageNames.count; i++)
    {
        DDLCustomButton *button = [[DDLCustomButton alloc] initWithFrame:CGRectMake(i*space+buttonWidth*i, 0, buttonWidth, buttonHeight)];
        [button setImage:[UIImage imageNamed:imageNames[i]]];
        
        if (titles.count > 0)
        {
            [button setTitle:titles[i]];
        }
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        //添加到滚动视图上
        [_vegetableScrollView addSubview:button];
        
        maxWidth = CGRectGetMaxX(button.frame);
    }
    
    //滚动视图的contentSize
    _vegetableScrollView.contentSize = CGSizeMake(maxWidth, _vegetableScrollView.contentSize.height);
}

//按钮点击
- (void)buttonClick:(UIButton *)button
{
    
    //修改按钮状态
    for (UIView *subview in _vegetableScrollView.subviews)
    {
        if ([subview isKindOfClass:[DDLCustomButton class]])
        {
            ((DDLCustomButton *)subview).selected = NO;
        }
    }
    
    button.selected = YES;
    
    //回调
    if ([_delegate respondsToSelector:@selector(didSelectIndexPath:)])
    {
        [_delegate didSelectIndexPath:[NSIndexPath indexPathForRow:button.tag inSection:self.tag]];
    }
}

//标记哪个按钮选中
- (void)markButtonStatusToSelect:(NSInteger)index
{
    NSLog(@"====:%d",index);
    
    if (index >= 0)
    {
        DDLCustomButton *button = (DDLCustomButton *)[_vegetableScrollView viewWithTag:index+1];
        button.selected = YES;
    }
}

@end
