//
//  DDLIntelligentSelectFoodViewController.m
//  CookerProject
//
//  Created by vera on 15-1-29.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLIntelligentSelectFoodViewController.h"
#import "AFNetworking.h"
#import "GDataXMLNode.h"
#import "DDLClassify.h"
#import "DDLFood.h"
#import "DDLIntelligentSelectFoodCollectionViewCell.h"
#import "DDLDeleteButton.h"
#import "DDLUIKit.h"
#import "DDLIntelligentSelectFoodDetailViewController.h"

@interface DDLIntelligentSelectFoodViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,DDLDeleteButtonDelegate>
{
    UIImageView *searchHeadView;
    
    //数据源
    NSMutableArray *classifyArray;
    
    UIScrollView *foodScrollView;
    
    //选择的蔬菜列表
    NSMutableArray *selectVegetableArray;
}

@end

@implementation DDLIntelligentSelectFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    classifyArray = [NSMutableArray array];
    selectVegetableArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图"]];
    
    //header
    [self initHeaderSearchView];
    
    //初始化搜索按钮
    [self initSearchButton];
    
    //初始化滚动视图
    [self initScrollView];
    
    //解析material.xml
    [self parseXMLString];
}

//解析material.xml
- (void)parseXMLString
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"material.xml" ofType:nil];
    //读取文件内容
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    //初始化xml解析器
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:content options:0 error:nil];
    NSArray *xmlArray = [document nodesForXPath:@"/response/entity/tblMmaterialType" error:nil];
    
    for (GDataXMLElement *element in xmlArray)
    {
        GDataXMLElement *classIDElement = [element elementsForName:@"materialTypeId"][0];
        GDataXMLElement *classNameElement = [element elementsForName:@"name"][0];
        
        //获取分类的名字和id
        NSString *classIDString = [classIDElement stringValue];
        NSString *classNameString = [classNameElement stringValue];
        
        DDLClassify *classify = [[DDLClassify alloc] init];
        classify.classify_ID = classIDString;
        classify.classify_name = classNameString;
        
        //获取每个分类的蔬菜
        NSArray *array = [element elementsForName:@"tblMaterial"];
        //遍历每个分类下的蔬菜
        for (GDataXMLElement *vegeElement in array)
        {
            GDataXMLElement *foodIDElement = [vegeElement elementsForName:@"materialId"][0];
            GDataXMLElement *foodNameElement = [vegeElement elementsForName:@"name"][0];
            GDataXMLElement *foodImageElement = [vegeElement elementsForName:@"imageFilename"][0];
            
            DDLFood *food = [[DDLFood alloc] init];
            food.vegetableId = [foodIDElement stringValue];
            food.chName = [foodNameElement stringValue];
            food.pictureUrlString = [foodImageElement stringValue];
            
            [classify.vegetableArray addObject:food];
        }
        
        [classifyArray addObject:classify];
    }
    
    //添加collectionView
    [self initCollectionView];
}

//添加collectionView
- (void)initCollectionView
{
    //collectionView宽度
    int collecionViewWidth = 130;
    
    //两个collectionView之间的距离
    int space = 10;
    
    //
    int totalWidth = 0;
    
    
    for (int i = 0; i < classifyArray.count; i++)
    {
        DDLClassify *classity = classifyArray[i];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((i+1)*space+i*collecionViewWidth, 0, collecionViewWidth, 20)];
        tipLabel.text = classity.classify_name;
        [foodScrollView addSubview:tipLabel];
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(60, 60);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(tipLabel.frame.origin.x, CGRectGetMaxY(tipLabel.frame)+5, collecionViewWidth, foodScrollView.frame.size.height - 25) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.tag = i+1;
        [foodScrollView addSubview:collectionView];
        
        [collectionView registerNib:[UINib nibWithNibName:@"DDLIntelligentSelectFoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
        
        totalWidth  = CGRectGetMaxX(collectionView.frame) + 10;
        
        NSLog(@"%d",totalWidth);
    }
    
    //计算滚动视图的contentSize
    foodScrollView.contentSize = CGSizeMake(totalWidth, foodScrollView.frame.size.height);
}

//初始化滚动视图
- (void)initScrollView
{
    foodScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, self.view.frame.size.height - 140 - 64 - 10)];
    [self.view addSubview:foodScrollView];
}

//初始化搜索按钮
- (void)initSearchButton
{
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(self.view.frame.size.width - 100, 100, 80, 30);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"智能选菜-搜索"] forState:UIControlStateNormal];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(enterDetailViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
}

//进入搜索详情
- (void)enterDetailViewController
{
    //判断搜索内容是否为空
    if (selectVegetableArray.count == 0)
    {
        [DDLUIKit showAlertViewWithMessage:@"搜索内容为空"];
        
        return;
    }
    
    
    DDLIntelligentSelectFoodDetailViewController *detailVC = [[DDLIntelligentSelectFoodDetailViewController alloc] init];
    detailVC.searchVegetableAarray = selectVegetableArray;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)initHeaderSearchView
{
    searchHeadView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"智能选菜-背景上"]];
    searchHeadView.frame = CGRectMake(0, 0, self.view.frame.size.width, 90);
    searchHeadView.userInteractionEnabled = YES;
    [self.view addSubview:searchHeadView];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    l.center = searchHeadView.center;
    l.font = [UIFont systemFontOfSize:13];
    l.textAlignment = NSTextAlignmentCenter;
    l.text = @"看看厨房有哪些食材，搜一搜就会友惊喜";
    l.tag = 10000;
    [searchHeadView addSubview:l];
}

#pragma mark DDLDeleteButtonDelegate
- (void)didClickDeleteButton:(DDLDeleteButton *)button
{
    //点击删除按钮
    
    //1.删除数据源
    [selectVegetableArray removeObjectAtIndex:button.tag - 1];
    //2.刷新
    [self refreshDeleteButtons];
    
    //
    if (selectVegetableArray.count == 0)
    {
        UILabel *l = (UILabel *)[searchHeadView viewWithTag:10000];
        l.hidden = NO;
    }
    
}

#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    DDLClassify *classify = classifyArray[collectionView.tag - 1];
    
    return classify.vegetableArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDLIntelligentSelectFoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    DDLClassify *classify = classifyArray[collectionView.tag - 1];
    DDLFood *food = classify.vegetableArray[indexPath.row];
    
    [cell.foodImageView setImage:[UIImage imageNamed:food.pictureUrlString]];
    cell.foodNameLabel.text = food.chName;

    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    //NSLog(@"%d",indexPath.item);
    DDLClassify *classify = classifyArray[collectionView.tag - 1];
    DDLFood *food = classify.vegetableArray[indexPath.item];
    //NSLog(@"%@",food.chName);

    //1.判断当前蔬菜是否在数组里
    if (![selectVegetableArray containsObject:food])
    {
        //最多6个
        if (selectVegetableArray.count >= 6)
        {
            [DDLUIKit showAlertViewWithMessage:@"不能超过6个"];
            
            return;
        }
        
        //2.如果不在，添加到数组
        [selectVegetableArray addObject:food];
    }
    
    //3.刷新
    [self refreshDeleteButtons];
    
    if (selectVegetableArray.count > 0)
    {
        UILabel *l = (UILabel *)[searchHeadView viewWithTag:10000];
        l.hidden = YES;
    }

}

//刷新
- (void)refreshDeleteButtons
{
    //移除所有按钮
    for (UIView *view in searchHeadView.subviews)
    {
        //只删除按钮
        if ([view isKindOfClass:[DDLDeleteButton class]])
        {
            [view removeFromSuperview];
        }
    }
    
    //列
    int column = 3;
    
    int space = 20;
    int buttonWidth = (searchHeadView.frame.size.width - (column+1)*space)/column;
    int buttonHeight = 25;
    
    //添加按钮
    for (int i = 0; i < selectVegetableArray.count; i++)
    {
        DDLFood *food = selectVegetableArray[i];
        
        DDLDeleteButton *button = [[DDLDeleteButton alloc] initWithFrame:CGRectMake(space*((i%3)+1)+buttonWidth*(i%3), 10+(i/3)*(buttonHeight+10), buttonWidth, buttonHeight)];
        [button setDeleteButtonTitle:food.chName];
        [button setDeleteButtonTitleFont:[UIFont systemFontOfSize:12]];
        button.delegate = self;
        button.tag = i+1;
        [searchHeadView addSubview:button];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
