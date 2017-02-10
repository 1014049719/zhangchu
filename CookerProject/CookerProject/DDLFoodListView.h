//
//  DDLFoodListView.h
//  CookerProject
//
//  Created by vera on 15-1-26.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDLFoodListViewDelegate <NSObject>

//点击每一个item
- (void)didSelectedCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end

@interface DDLFoodListView : UIView

@property (nonatomic,assign) id<DDLFoodListViewDelegate> delegate;

//更新
- (void)updateCollectionViewWithDataSource:(NSArray *)list;

@end
