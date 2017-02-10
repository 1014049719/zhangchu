//
//  DDLFoodListCollectionViewCell.h
//  CookerProject
//
//  Created by vera on 15-1-26.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDLFood.h"

@interface DDLFoodListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *freeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tapCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//赋值
- (void)setFoodModel:(DDLFood *)food;

@end
