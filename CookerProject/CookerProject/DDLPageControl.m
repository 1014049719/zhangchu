//
//  DDLPageControl.m
//  CookerProject
//
//  Created by vera on 15-1-22.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#define circleWidth 5.0

#import "DDLPageControl.h"

@interface DDLPageControl ()
{
    //背景
    UIImageView *circleImageView;
    
    CGFloat space;
    CGFloat xOffset;
}

@end

@implementation DDLPageControl

//构造方法
- (id)initWithFrame:(CGRect)frame numberOfPage:(NSInteger)numberOfPage
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        
        space = (self.frame.size.width - numberOfPage*circleWidth)/(numberOfPage+1);
        
        //初始化圆点
        for (int i = 0; i < numberOfPage; i++)
        {
            UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(space*(i+1) + circleWidth*i, (self.frame.size.height-circleWidth)/2, circleWidth, circleWidth)];
            circleView.backgroundColor = [UIColor whiteColor];
            circleView.layer.cornerRadius = 3;
            [self addSubview:circleView];
        }
        
        CGFloat bigWidth = 20;
        
        xOffset = space + circleWidth/2 - bigWidth/2;
        
        circleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"首页-页数选"]];
        circleImageView.frame = CGRectMake(xOffset, self.frame.size.height/2 - bigWidth/2, bigWidth, bigWidth);
        [self addSubview:circleImageView];
        
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, circleImageView.frame.size.width, circleImageView.frame.size.height)];
        numberLabel.text = @"1";
        numberLabel.tag = 1;
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.font = [UIFont systemFontOfSize:15];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [circleImageView addSubview:numberLabel];
    }
    
    return self;
}

//更新页数
- (void)updatePageIndexWithCurrentIndex:(NSInteger)currentIndex count:(NSInteger)count
{
    CGFloat widthOffset = (self.frame.size.width - 2*space - circleWidth)/(count-1);
    
    CGRect frame = circleImageView.frame;
    frame.origin.x = xOffset + widthOffset*currentIndex;
    circleImageView.frame = frame;
    
    //修改数字
    UILabel *numberLabel = (UILabel *)[self viewWithTag:1];
    numberLabel.text = [NSString stringWithFormat:@"%d",currentIndex+1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
