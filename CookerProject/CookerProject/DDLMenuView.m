//
//  DDLMenuView.m
//  CookerProject
//
//  Created by vera on 15-1-22.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLMenuView.h"
#import "DDLOffice.h"
#import "UIImageView+AFNetworking.h"
#import "DDLOfficeTableViewCell.h"
#import "DDLDisease.h"
#import "DDLClassify.h"
#import "DDLMaterial.h"

#define rightXOffset 120
#define leftXOffset (-80)

//行高
#define tableViewCellRowHeight 80

@interface DDLMenuView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *leftTableView;
    UITableView *rightTableView;
    
    //数据源
    NSArray *leftArray;//保存的DDLOffice
    NSArray *rightArray; //保存的DDLDisease
    
    //三角箭头
    UIImageView *arrowView;
    
    //标记点击哪一行
    NSInteger selectIndex;
}

@end

@implementation DDLMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //初始化tableView
        [self initTableView];
        //三角箭头
        [self initArrowView];
    }
    return self;
}

- (void)initArrowView
{
    CGFloat arrowWidth = 10;
    
    arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(rightXOffset - arrowWidth + ABS(leftXOffset), tableViewCellRowHeight/2-arrowWidth/2, arrowWidth, arrowWidth)];
    arrowView.image = [UIImage imageNamed:@"三角标"];
    arrowView.hidden = YES;
    [leftTableView addSubview:arrowView];
}

- (void)initTableView
{
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.showsVerticalScrollIndicator = NO;
    //行高
    leftTableView.rowHeight = tableViewCellRowHeight;
    [self addSubview:leftTableView];
    
    
    //设置背景图片
    UIImageView *leftTableViewBgImageView = [[UIImageView alloc] initWithFrame:leftTableView.bounds];
    leftTableViewBgImageView.image = [UIImage imageNamed:@"Left-bg"];

    
    leftTableView.backgroundView = leftTableViewBgImageView;
    
    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftTableView.frame), 0, leftTableView.frame.size.width, leftTableView.frame.size.height)];
    rightTableView.rowHeight = tableViewCellRowHeight;
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    [self addSubview:rightTableView];
    
    //疾病bg
    //设置背景图片
    UIImageView *rightTableViewBgImageView = [[UIImageView alloc] initWithFrame:rightTableView.bounds];
    rightTableViewBgImageView.image = [UIImage imageNamed:@"疾病bg"];
    rightTableView.backgroundView = rightTableViewBgImageView;
    
    [leftTableView registerNib:[UINib nibWithNibName:@"DDLOfficeTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [rightTableView registerNib:[UINib nibWithNibName:@"DDLOfficeTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
}

//刷新数据
- (void)reloadTableViewDataSourceWithTradeArray:(NSArray *)tradeArray isLeft:(BOOL)isLeft
{
    if (isLeft)
    {
        leftArray = tradeArray;
        
        [leftTableView reloadData];
    }
    else
    {
        rightArray = tradeArray;
        
        [rightTableView reloadData];
    }
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == leftTableView)
    {
        return leftArray.count;
    }

    return rightArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    DDLOfficeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.backgroundColor = [UIColor clearColor];


    
    if (tableView == leftTableView)
    {
        
        NSString *name;
        NSString *detailText;
        
        if (_materialType == DDLMenuViewMaterialTypeForDisease) //对症食疗
        {
            DDLOffice *office = leftArray[indexPath.row];
            
            //赋值
            name = office.officeName;
            detailText = office.diseaseNames;

            //文字
            if (selectIndex == indexPath.row && self.menuType == DDLMenuTypeForRightOpen)
            {
                cell.officeNameLabel.textColor = [UIColor orangeColor];
            }
            else
            {
                cell.officeNameLabel.textColor = [UIColor blackColor];
            }
            
            //隐藏或者显示detailText
            if (self.menuType == DDLMenuTypeForRightOpen)
            {
                cell.officeDiseaseNameLabel.text = @"";
            }
            else
            {
                cell.officeDiseaseNameLabel.text =office.diseaseNames;
            }
            
            //图片
            [cell.officeImageView setImageWithURL:[NSURL URLWithString:office.imagePath] placeholderImage:[UIImage imageNamed:@"defaultImage-586h"]];

        }
        else  //食材大全
        {
            DDLClassify *classify = leftArray[indexPath.row];
            
            //赋值
            name = classify.classify_name;
            detailText = @"";
            
            //文字居中显示
            [cell setNameLabelToCenter];
        }
        
        //赋值
        cell.officeNameLabel.font = [UIFont systemFontOfSize:15];
        cell.officeNameLabel.text = name;
        
    }
    else
    {
        //图片
        NSString *imageUrlString;
        //名字
        NSString *name;
        
        if (_materialType == DDLMenuViewMaterialTypeForDisease) //疾病
        {
            if (rightArray.count > 0)
            {
                DDLDisease *disease = rightArray[indexPath.row];
                
                imageUrlString = disease.imageName;
                name = disease.diseaseName;
                
            }
        }
        else   //材料列表
        {
            DDLMaterial *material = rightArray[indexPath.row];
            
            imageUrlString = material.imagePath;
            name = material.materialName;
        }
        
        //赋值
        cell.officeNameLabel.text = name;
        [cell.officeImageView setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:nil];
        
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //记录点击的是哪一行
    selectIndex = indexPath.row;
    
    if (tableView == leftTableView)
    {
        //改变类型
        self.menuType = DDLMenuTypeForRightOpen;
        
        //刷新
        [tableView reloadData];
        
        //显示右边视图
        [self open];
        //重新设置箭头坐标
        [self resetArrowViewFrame];
        
        
        if (_materialType == DDLMenuViewMaterialTypeForDisease) //对症食疗-科
        {
            DDLOffice *office = leftArray[indexPath.row];
            
            //回调
            if ([_delegate respondsToSelector:@selector(didSelectedMenuView:menuObject:)])
            {
                [_delegate didSelectedMenuView:self menuObject:office];
            }
        }
        else //食材大全 - 分类
        {
            DDLClassify *classify = leftArray[indexPath.row];
            //回调
            if ([_delegate respondsToSelector:@selector(didSelectedMenuView:menuObject:)])
            {
                [_delegate didSelectedMenuView:self menuObject:classify];
            }
        }
        
    }
    else
    {
        if (_materialType == DDLMenuViewMaterialTypeForDisease) //对症食疗 - 疾病
        {
            if ([_delegate respondsToSelector:@selector(didSelectedMenuView:menuObject:)])
            {
                if (rightArray.count > 0)
                {
                    DDLDisease *disease = rightArray[indexPath.row];
                    [_delegate didSelectedMenuView:self menuObject:disease];
                    
                }
                
            }
        }
        else  //食材大全 - 材料
        {
            if ([_delegate respondsToSelector:@selector(didSelectedMenuView:menuObject:)])
            {
                if (rightArray.count > 0)
                {
                    DDLMaterial *material = rightArray[indexPath.row];
                    [_delegate didSelectedMenuView:self menuObject:material];
                    
                }
                
            }
        }
    }
    
}

- (void)resetArrowViewFrame
{

    
    CGRect frame = arrowView.frame;
    frame.origin.y = tableViewCellRowHeight/2-arrowView.frame.size.height/2 + tableViewCellRowHeight*selectIndex;
    
    [UIView animateWithDuration:0.3 animations:^{
        arrowView.frame = frame;
    }];
}

- (void)open
{
    CGRect rightFrame = rightTableView.frame;
    rightFrame.origin.x = rightXOffset;
    
    CGRect leftFrame = leftTableView.frame;
    leftFrame.origin.x = leftXOffset;
    leftFrame.size.width = rightXOffset + ABS(leftXOffset);
    
    [UIView animateWithDuration:0.3 animations:^{
        rightTableView.frame = rightFrame;
        
        leftTableView.frame = leftFrame;
    } completion:^(BOOL finished) {
        
        //显示三角
        arrowView.hidden = NO;
    }];
    
    //改变类型
    self.menuType = DDLMenuTypeForRightOpen;
}

//还原
- (void)colse
{
    arrowView.hidden = YES;
    
    
    CGRect leftFrame = leftTableView.frame;
    leftFrame.origin.x = 0;
    leftFrame.size.width = self.frame.size.width;
    
    CGRect rightFrame = rightTableView.frame;
    rightFrame.origin.x = CGRectGetMaxX(self.frame);
    
    [UIView animateWithDuration:0.3 animations:^{
        leftTableView.frame = leftFrame;
        rightTableView.frame = rightFrame;
    }];
    
    //改变类型
    self.menuType = DDLMenuTypeForRightColse;
    
    [leftTableView reloadData];
    
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"取消");
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
