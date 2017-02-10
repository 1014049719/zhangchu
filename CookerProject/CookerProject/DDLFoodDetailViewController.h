//
//  DDLFoodDetailViewController.h
//  CookerProject
//
//  Created by vera on 15-1-25.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDLFoodDetailViewController : UIViewController

@property (nonatomic,copy) NSString *vegetable_id;

/*
 中文名字
 */
@property (weak, nonatomic) IBOutlet UILabel *chNameLabel;

/*
 英文名字
 */
@property (weak, nonatomic) IBOutlet UILabel *enNameLabel;

/*
 烹饪时间
 */
@property (weak, nonatomic) IBOutlet UILabel *cookTimeLabel;

/*
 口味
 */
@property (weak, nonatomic) IBOutlet UILabel *tasteLabel;

/*
 烹饪方法
 */
@property (weak, nonatomic) IBOutlet UILabel *cookMethodLabel;

/*
 功效
 */
@property (weak, nonatomic) IBOutlet UILabel *effectLabel;

/*
 适合人群
 */
@property (weak, nonatomic) IBOutlet UILabel *fitPersonLabel;

@end
