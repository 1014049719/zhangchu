//
//  DDLBottomTabbarView.h
//  CookerProject
//
//  Created by vera on 15-1-20.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDLBottomTabbarViewDelegate <NSObject>

- (void)didSelectBottomTabbarViewAtIndex:(NSInteger)index;

@end

@interface DDLBottomTabbarView : UIView

//delegate
@property (nonatomic,assign) id<DDLBottomTabbarViewDelegate> delegate;

//设置图片和文字
- (void)setBottomTabbarViewImageWithImageNames:(NSArray *)imageNames
                            selectedImageNames:(NSArray *)selectedImageNames titles:(NSArray *)titles isScroll:(BOOL)isScroll;

@end
