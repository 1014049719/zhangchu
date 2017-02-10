//
//  DDLDiseaseDetailAlertView.m
//  CookerProject
//
//  Created by vera on 15-1-24.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLDiseaseDetailAlertView.h"
#import "DDLUtility.h"

@interface DDLDiseaseDetailAlertView ()
{
    //标题
    UILabel *titleLabel;
    //疾病详情
    UILabel *diseaseDetailLabel;
    //饮食保健
    UILabel *fitEatLabel;
    //生活保健
    UILabel *lifeEatLabel;
    
    UIScrollView *contentScrollView;
}

@end

@implementation DDLDiseaseDetailAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
        
        //圆角
        self.layer.cornerRadius = 10;
        
        self.clipsToBounds = YES;
        
        
        //初始化titleLabel
        titleLabel = [self createLabelWithFrame:CGRectMake(0, 5, self.frame.size.width, 25) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor]];
        titleLabel.text = @"测试";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        NSInteger buttonWidth = 25;
        NSInteger buttonHeight = 25;
        
        //取消按钮
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(self.frame.size.width - buttonWidth, 5, buttonWidth, buttonHeight);
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(removeAlertView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 10, self.frame.size.width, self.frame.size.height - CGRectGetMaxY(titleLabel.frame) - 20)];
        [self addSubview:contentScrollView];
        
        CGFloat xTitleOffset = 10;
        CGFloat xDetailOffset = 30;
        
        NSArray *titles = @[@"疾病简介",@"饮食保健",@"生活保健"];
        
        for (int i = 0; i < 3; i++)
        {

            UILabel *diseaseTitleLabel = [self createLabelWithFrame:CGRectMake(10, 0, self.frame.size.width - 2*xTitleOffset, 20) font:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor]];
            diseaseTitleLabel.text = titles[i];
            diseaseTitleLabel.tag = i+1;
            //diseaseTitleLabel.backgroundColor = [UIColor purpleColor];
            [contentScrollView addSubview:diseaseTitleLabel];
            
            //疾病简介
            UILabel *detaiLabel = [self createLabelWithFrame:CGRectMake(xDetailOffset, 0, self.frame.size.width - 2*xDetailOffset, 0) font:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor]];
            detaiLabel.numberOfLines = 0;
            //detaiLabel.backgroundColor = [UIColor redColor];
            [contentScrollView addSubview:detaiLabel];
            
            if (i == 0)
            {
                diseaseDetailLabel = detaiLabel;
            }
            else if (i == 1)
            {
                fitEatLabel = detaiLabel;
            }
            else
            {
                lifeEatLabel = detaiLabel;
            }
        }
        
    }
    return self;
}

//赋值
- (void)setAlertViewText:(NSString *)title detailText:(NSString *)detailText fitText:(NSString *)fitText liftText:(NSString *)liftText
{
    //1.赋值
    titleLabel.text = title;
    diseaseDetailLabel.text = detailText;
    fitEatLabel.text = fitText;
    lifeEatLabel.text = liftText;
    
    _diseaseDetailText = detailText;
    _fitEatText = fitText;
    _lifeSuitText = liftText;
    
    //2.修改坐标
    [self resetFrame];
}

- (void)resetFrame
{
    //修改疾病详情
    UILabel *label = (UILabel *)[contentScrollView viewWithTag:1];
    
    CGSize size = [DDLUtility getTextSizeWithText:_diseaseDetailText font:[UIFont systemFontOfSize:15] width:diseaseDetailLabel.frame.size.width];
    
 
    CGRect frame = diseaseDetailLabel.frame;
    frame.origin.y = CGRectGetMaxY(label.frame)+10;
    frame.size.height = size.height;
    diseaseDetailLabel.frame = frame;
    
    
    //修改饮食保健
    label = (UILabel *)[contentScrollView viewWithTag:2];
    
    frame = label.frame;
    frame.origin.y = CGRectGetMaxY(diseaseDetailLabel.frame) + 10;
    label.frame = frame;
    
    size = [DDLUtility getTextSizeWithText:_fitEatText font:[UIFont systemFontOfSize:15] width:fitEatLabel.frame.size.width];
    
    frame = fitEatLabel.frame;
    frame.origin.y = CGRectGetMaxY(label.frame) + 10;
    frame.size.height = size.height;
    fitEatLabel.frame = frame;

    
    //修改生活保健
    label = (UILabel *)[contentScrollView viewWithTag:3];
    
    frame = label.frame;
    frame.origin.y = CGRectGetMaxY(fitEatLabel.frame) + 10;
    label.frame = frame;
    
    size = [DDLUtility getTextSizeWithText:_lifeSuitText font:[UIFont systemFontOfSize:15] width:lifeEatLabel.frame.size.width];
    
    frame = lifeEatLabel.frame;
    frame.size.height = size.height;
    frame.origin.y = CGRectGetMaxY(label.frame) + 10;
    lifeEatLabel.frame = frame;
    
    contentScrollView.contentSize = CGSizeMake(contentScrollView.frame.size.width, CGRectGetMaxY(lifeEatLabel.frame)+10);
}

/*
 移除当前视图
 */
- (void)removeAlertView:(UIButton *)button
{
    
    //button.superview ==== self
    
    //移除当前视图
    [self removeFromSuperview];
    
    //修改按钮选中状态
    if ([_delegate respondsToSelector:@selector(dismissAlertView:)])
    {
        [_delegate dismissAlertView:self];
    }
}

/**
 初始化UILabel
 */
- (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.textColor = textColor;
    
    return label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
