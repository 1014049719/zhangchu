//
//  DDLPageControl.h
//  CookerProject
//
//  Created by vera on 15-1-22.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDLPageControl : UIView

//构造方法
- (id)initWithFrame:(CGRect)frame numberOfPage:(NSInteger)numberOfPage;

/*
 第1个参数：当前页数
 第2个参数：实际总页数
 */
- (void)updatePageIndexWithCurrentIndex:(NSInteger)currentIndex count:(NSInteger)count;

@end
