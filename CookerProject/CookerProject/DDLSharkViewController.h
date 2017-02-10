//
//  DDLSharkViewController.h
//  CookerProject
//
//  Created by vera on 15-1-29.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDLSharkViewController : UIViewController

//中文名字
@property (weak, nonatomic) IBOutlet UILabel *chNameLabel;
//英文名字
@property (weak, nonatomic) IBOutlet UILabel *enNameLabel;
//图片
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;

@end
