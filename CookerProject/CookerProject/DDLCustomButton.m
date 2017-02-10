//
//  DDLCustomButton.m
//  CookerProject
//
//  Created by vera on 15-1-30.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLCustomButton.h"

@interface DDLCustomButton ()
{
    //图片
    UIImageView *buttonImage;
}

@end

@implementation DDLCustomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundImage:[UIImage imageNamed:@"搜索-分类底"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"搜索-分类底-选"] forState:UIControlStateSelected];
        
        buttonImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:buttonImage];
        
        self.titleEdgeInsets = UIEdgeInsetsMake(50, 0, 0, 0);
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
    }
    return self;
}

//设置文字
- (void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

//设置图片
- (void)setImage:(UIImage *)image
{
    buttonImage.image = image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
