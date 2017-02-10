//
//  DDLFood.h
//  CookerProject
//
//  Created by vera on 15-1-21.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDLFood : NSObject

/**
 图片地址
 */
@property (nonatomic,copy) NSString *pictureUrlString;

/**
 中文名字
 */
@property (nonatomic,copy) NSString *chName;

/**
 英文名字
 */
@property (nonatomic,copy) NSString *enName;

/**
 点击次数
 */
@property (nonatomic, assign) NSInteger clickCount;

/**
 蔬菜id
 */
@property (nonatomic, copy) NSString *vegetableId;

/**
 烹饪时间
 */
@property (nonatomic, copy) NSString *timeLength;

/**
 口味
 */
@property (nonatomic, copy) NSString *taste;

/**
 烹饪方法
 */
@property (nonatomic, copy) NSString *cookingMethod;

/**
 功效
 */
@property (nonatomic, copy) NSString *effect;

/**
 适合人群
 */
@property (nonatomic, copy) NSString *fittingCrowd;

/**
 材料视频url
 */
@property (nonatomic, copy) NSString *materialVideoPath;

/**
 制作过程视图url
 */
@property (nonatomic, copy) NSString *productionProcessPath;

/**
 原料
 */
@property (nonatomic, copy) NSString *material;

/**
 调料
 */
@property (nonatomic, copy) NSString *flavour;



@end
