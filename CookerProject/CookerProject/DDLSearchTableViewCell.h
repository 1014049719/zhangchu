//
//  DDLSearchTableViewCell.h
//  CookerProject
//
//  Created by vera on 15-1-30.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDLSearchTableViewCellDelegate <NSObject>

- (void)didSelectIndexPath:(NSIndexPath *)indexPath;

@end

@interface DDLSearchTableViewCell : UITableViewCell

@property (nonatomic,assign) id<DDLSearchTableViewCellDelegate> delegate;

//背景
@property (weak, nonatomic) IBOutlet UIImageView *bcgImageView;
//分类名字
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//滚动视图
@property (weak, nonatomic) IBOutlet UIScrollView *vegetableScrollView;

//添加按钮
- (void)addButtonToScrollView:(NSArray *)imageNames titles:(NSArray *)titles;

//标记哪个按钮选中
- (void)markButtonStatusToSelect:(NSInteger)index;

@end
