//
//  DDLBottomTabbarView.m
//  CookerProject
//
//  Created by vera on 15-1-20.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLBottomTabbarView.h"
#import "UIButton+AFNetworking.h"

@interface DDLBottomTabbarView ()
{
    //是否需要滚动
    BOOL _isScroll;
    
    //按钮个数
    NSInteger numberOfButton;
}

@end

@implementation DDLBottomTabbarView

//设置图片和文字
- (void)setBottomTabbarViewImageWithImageNames:(NSArray *)imageNames
                            selectedImageNames:(NSArray *)selectedImageNames titles:(NSArray *)titles isScroll:(BOOL)isScroll
{
    
    _isScroll = isScroll;
    
    //按钮个数
    numberOfButton = imageNames.count;
    
    //按钮宽度
    CGFloat buttonWidth = self.frame.size.width / imageNames.count;
    
    //如果是滚动视图，显示4个按钮
    if (isScroll)
    {
        buttonWidth = self.frame.size.width / 4;
    }
    
    //按钮高度
    CGFloat buttonHeight = 49;
    
    UIScrollView *scrollView = nil;
    
    if (_isScroll)
    {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        scrollView.contentSize = CGSizeMake(buttonWidth * imageNames.count, scrollView.frame.size.height);
        [self addSubview:scrollView];
    }

    for (int i = 0; i < imageNames.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonWidth*i, 0, buttonWidth, buttonHeight);
        
        //如果是url
        if ([imageNames[i] hasPrefix:@"http://"])
        {
            [button setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageNames[i]]];
        }
        else
        {
            [button setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        }
        
        if (selectedImageNames.count > 0)
        {
            [button setBackgroundImage:[UIImage imageNamed:selectedImageNames[i]] forState:UIControlStateSelected];
        }
        
    
        
        //文字根据字体大小自动适应
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.titleEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
        button.tag = i+1;
        [button addTarget:self action:@selector(butonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        //如果是滚动视图添加到滚动视图
        if (isScroll)
        {
            [scrollView addSubview:button];
        }
        else
        {
            [self addSubview:button];
        }
    }
}

- (void)butonPress:(UIButton *)button
{
    
    if (_isScroll)
    {
        //标记为没有选中
        for (int i = 0; i < numberOfButton; i++)
        {
            UIButton *btn = (UIButton *)[self viewWithTag:i+1];
            btn.selected = NO;
        }
        
        //标记为选中
        button.selected = YES;
    }
    
   
    
    //回调
    if ([_delegate respondsToSelector:@selector(didSelectBottomTabbarViewAtIndex:)])
    {
        [_delegate didSelectBottomTabbarViewAtIndex:button.tag - 1];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
