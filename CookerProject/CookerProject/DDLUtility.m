//
//  DDLUtility.m
//  CookerProject
//
//  Created by vera on 15-1-21.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLUtility.h"

@implementation DDLUtility



/**
 根据文字计算范围
 */
+ (CGSize)getTextSizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
        return rect.size;
    }
    else
    {
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, 10000)];
        
        return size;
    }
}

@end
