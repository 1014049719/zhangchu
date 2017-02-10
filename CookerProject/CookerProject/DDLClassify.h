//
//  DDLClassify.h
//  CookerProject
//
//  Created by vera on 15-1-27.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDLClassify : NSObject

/**
 分类id
 */
@property (nonatomic,copy) NSString *classify_ID;

/**
 分类名字
 */
@property (nonatomic,copy) NSString *classify_name;

/**
 分类图片
 */
@property (nonatomic,copy) NSString *classify_imagePath;

/**
 分类下蔬菜列表
 */
@property (nonatomic,strong) NSMutableArray *vegetableArray;

@end
