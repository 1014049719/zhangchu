//
//  DDLFoodListCollectionViewCell.m
//  CookerProject
//
//  Created by vera on 15-1-26.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLFoodListCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation DDLFoodListCollectionViewCell

//代码初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

//xib初始化
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
      
        
    }
    return self;
}

//xib初始化
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //NSLog(@"%@",_pictureView);
    
    //旋转38度
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/180 * 38);
    
    _freeLabel.transform = transform;
    
    _nameLabel.adjustsFontSizeToFitWidth = YES;
}

//赋值
- (void)setFoodModel:(DDLFood *)food
{
    [_pictureView setImageWithURL:[NSURL URLWithString:food.pictureUrlString]];
    _tapCountLabel.text = [NSString stringWithFormat:@"%d",food.clickCount];
    _nameLabel.text = food.chName;
    
}

@end
