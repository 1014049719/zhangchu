//
//  DDLMaterial.h
//  CookerProject
//
//  Created by vera on 15-1-27.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDLMaterial : NSObject

/**
 id
 */
@property (nonatomic,copy) NSString *materialId;

/**
 材料名字
 */
@property (nonatomic,copy) NSString *materialName;

/**
 图片路径
 */
@property (nonatomic,copy) NSString *imagePath;

/**
 调料
 */
@property (nonatomic,strong) NSMutableArray *flavourArray;

@end
