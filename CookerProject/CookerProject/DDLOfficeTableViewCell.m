//
//  DDLOfficeTableViewCell.m
//  CookerProject
//
//  Created by vera on 15-1-23.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLOfficeTableViewCell.h"

@implementation DDLOfficeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

//设置label居中
- (void)setNameLabelToCenter
{
    CGRect frame = _officeNameLabel.frame;
    frame.origin.y = self.frame.size.height/2 - frame.size.height/2;
    _officeNameLabel.frame = frame;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
