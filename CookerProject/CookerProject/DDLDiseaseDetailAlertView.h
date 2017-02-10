//
//  DDLDiseaseDetailAlertView.h
//  CookerProject
//
//  Created by vera on 15-1-24.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDLDiseaseDetailAlertView;

@protocol DDLDiseaseDetailAlertViewDelegate <NSObject>

//dismiss
- (void)dismissAlertView:(DDLDiseaseDetailAlertView *)alertView;

@end

@interface DDLDiseaseDetailAlertView : UIView

/**
 title
 */
@property (nonatomic,copy) NSString *title;

/**
 疾病简介
 */
@property (nonatomic,copy) NSString *diseaseDetailText;

/**
 饮食保健
 */
@property (nonatomic,copy) NSString *fitEatText;
/**
 生活保健
 */
@property (nonatomic,copy) NSString *lifeSuitText;

@property (nonatomic,assign) id<DDLDiseaseDetailAlertViewDelegate> delegate;

//赋值
- (void)setAlertViewText:(NSString *)title detailText:(NSString *)detailText fitText:(NSString *)fitText liftText:(NSString *)liftText;

@end
