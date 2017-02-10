//
//  DDLUtility.h
//  CookerProject
//
//  Created by vera on 15-1-21.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DDLUtility : NSObject



/**
 根据文字计算范围
 */
+ (CGSize)getTextSizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;


@end
