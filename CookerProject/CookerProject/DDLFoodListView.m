//
//  DDLFoodListView.m
//  CookerProject
//
//  Created by vera on 15-1-26.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLFoodListView.h"
#import "DDLFoodListCollectionViewCell.h"
#import "DDLFood.h"

@interface DDLFoodListView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *foodListCollectionView;
    
    NSArray *listArray;
}

@end

@implementation DDLFoodListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //item大小
        layout.itemSize = CGSizeMake(145, 130);
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
        
        
        foodListCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        foodListCollectionView.backgroundColor = [UIColor clearColor];
        foodListCollectionView.delegate = self;
        foodListCollectionView.dataSource = self;
        [self addSubview:foodListCollectionView];
        
        //注册
        [foodListCollectionView registerNib:[UINib nibWithNibName:@"DDLFoodListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    }
    return self;
}

//更新
- (void)updateCollectionViewWithDataSource:(NSArray *)list
{
    //1.赋值
    listArray = list;
    
    //2.刷新
    [foodListCollectionView reloadData];
}

#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDLFoodListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    //赋值
    if (listArray.count > 0)
    {
        [cell setFoodModel:listArray[indexPath.item]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(didSelectedCollectionView:indexPath:)])
    {
        [_delegate didSelectedCollectionView:foodListCollectionView indexPath:indexPath];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
