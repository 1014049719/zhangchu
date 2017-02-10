//
//  DDLOfficeTableViewCell.h
//  CookerProject
//
//  Created by vera on 15-1-23.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDLOfficeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *officeImageView;
@property (weak, nonatomic) IBOutlet UILabel *officeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *officeDiseaseNameLabel;

//设置label居中
- (void)setNameLabelToCenter;

@end
