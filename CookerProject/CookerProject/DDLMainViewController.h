//
//  DDLMainViewController.h
//  CookerProject
//
//  Created by vera on 15-1-20.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDLMainViewController : UIViewController

/**
 日
 */
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

/**
 年和月份
 */
@property (weak, nonatomic) IBOutlet UILabel *yearAndMonthLabel;

/**
 农历
 */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

/**
 宜,忌
 */
@property (weak, nonatomic) IBOutlet UIImageView *helpImageView;

/**
 跑马灯
 */
@property (weak, nonatomic) IBOutlet UIView *recommentView;

//中文名字
@property (weak, nonatomic) IBOutlet UILabel *chNameLabel;
//英文名字
@property (weak, nonatomic) IBOutlet UILabel *enNameLabel;

//二维码扫描
- (IBAction)zBarButtonClick:(id)sender;
//二维码生成
- (IBAction)createZBarButtonClick:(id)sender;

@end
