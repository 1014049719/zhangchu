//
//  DDLOffice.h
//  CookerProject
//
//  Created by vera on 15-1-22.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDLOffice : NSObject

//id
@property (nonatomic,copy) NSString *officeId;

//名字
@property (nonatomic,copy) NSString *officeName;

//疾病名字
@property (nonatomic,copy) NSString *diseaseNames;

//图片url
@property (nonatomic,copy) NSString *imagePath;

@end
