//
//  DDLMenuView.h
//  CookerProject
//
//  Created by vera on 15-1-22.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDLDisease;
@class DDLMenuView;

typedef NS_ENUM(NSInteger, DDLMenuViewMaterialType)
{
    DDLMenuViewMaterialTypeForDisease = 0,
    DDLMenuViewMaterialTypeForMaterial,
};

typedef NS_ENUM(NSInteger, DDLMenuViewType)
{
    DDLMenuTypeForRightColse = 0,
    DDLMenuTypeForRightOpen,
};

@protocol DDLMenuViewDelegate <NSObject>

/*
//科回调
- (void)didSelectedOfficeId:(NSString *)officeId;
//疾病回调
- (void)didSelectedDisease:(DDLDisease *)disease;
 */

- (void)didSelectedMenuView:(DDLMenuView *)menuView menuObject:(NSObject *)object;


@end

@interface DDLMenuView : UIView

@property (nonatomic,assign) id<DDLMenuViewDelegate> delegate;

//打开，闭合 类型
@property (nonatomic,assign) DDLMenuViewType menuType;

//对症食疗，食材大全
@property (nonatomic,assign) DDLMenuViewMaterialType materialType;

//刷新数据
- (void)reloadTableViewDataSourceWithTradeArray:(NSArray *)tradeArray isLeft:(BOOL)isLeft;
//打开
- (void)open;
//还原
- (void)colse;

@end
