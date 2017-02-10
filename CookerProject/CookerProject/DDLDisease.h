//
//  DDLDisease.h
//  CookerProject
//
//  Created by vera on 15-1-24.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDLDisease : NSObject

/**
 id
 */
@property (nonatomic,copy) NSString *diseaseId;
/**
 疾病名字
 */
@property (nonatomic,copy) NSString *diseaseName;

/**
 图片名字
 */
@property (nonatomic,copy) NSString *imageName;

/**
 饮食保健
 */
@property (nonatomic,copy) NSString *fitEat;

/**
 疾病描述
 */
@property (nonatomic,copy) NSString *diseaseDescribe;

/**
 生活保健
 */
@property (nonatomic,copy) NSString *lifeSuit;

@end
