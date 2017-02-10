//
//  DDLRandomSelectFoodViewController.m
//  CookerProject
//
//  Created by vera on 15-1-28.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLRandomSelectFoodViewController.h"
#import "DDLBottomTabbarView.h"
#import "AFNetworking.h"
#import "DDLFoodListView.h"
#import "DDLFood.h"
#import "DDLClassify.h"
#import "DDLUrl.h"
#import "UIButton+AFNetworking.h"

@interface DDLRandomSelectFoodViewController ()<DDLBottomTabbarViewDelegate>
{
    DDLBottomTabbarView *tabbarView;
    
    //保存分类
    NSMutableArray *classifyArray;
    
    //保存详情数据
    NSMutableArray *foodArray;
    
    UIView *vegeTableView;
    
    //collectionView
    DDLFoodListView *listView;
    
    //是否显示
    BOOL isOpen;
    
    //记录哪个tabbarButton
    NSInteger selectClassifyIndex;
}

@end

@implementation DDLRandomSelectFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    classifyArray = [NSMutableArray array];
    
    foodArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     初始化collectionView
     */
    [self initCollectionView];
    
    /**
     初始化tabbarView
     */
    [self initTabbarView];
    
    /**
     初始化VegetableView
     */
    [self initVegetableView];
    
    /**
     初始化label
     */
    [self initTipLabel];
    
    
    /**
     请求tabbar上的数据
     */
    [self requestDataFromNetWorkWithUrlString:FoodRandomTabbarView_url];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeVegetableView)];
    [self.view addGestureRecognizer:tap];
}

- (void)initCollectionView
{
    listView = [[DDLFoodListView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 64 - 49 - 20)];
    [self.view addSubview:listView];
}

- (void)initTipLabel
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 20)];
    l.text = @"全球最大网上厨房";
    l.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:l];
}

//单击手势
- (void)closeVegetableView
{
    [self colse];
}

- (void)initVegetableView
{
    vegeTableView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 64, self.view.frame.size.width, 86)];
    vegeTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"选菜-分类背景"]];
    [self.view addSubview:vegeTableView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"选菜-分类背景"]];
    imageView.frame = CGRectMake(0, 0, vegeTableView.frame.size.width, vegeTableView.frame.size.height);
    [vegeTableView addSubview:imageView];
    
    //按钮宽度
    NSInteger buttonWidth = vegeTableView.frame.size.width / 4;
    //按钮高度
    NSInteger buttonHeigth = vegeTableView.frame.size.height / 2;
    
    
    //添加按钮
    for (int i = 0; i < 8; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i+1;
        button.frame = CGRectMake((i%4)*buttonWidth, (i/4)*buttonHeigth, buttonWidth, buttonHeigth);
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(25, 0, 0, 0);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [vegeTableView addSubview:button];
    }
}

- (void)buttonClick:(UIButton *)button
{
    NSInteger buttonTag = button.tag;
    
    //取出分类
    DDLClassify *classify = classifyArray[selectClassifyIndex];
    DDLFood *food = classify.vegetableArray[buttonTag-1];
    
    //从新请求数据
    [self requestDataFromNetWorkWithUrlString:[NSString stringWithFormat:FoodRandomTabbarDetailView_url,food.vegetableId]];
    
    //隐藏
    [self closeVegetableView];
    
    
}

//设置按钮图片文字和图片
- (void)setVegeTableViewButtonTitleAndImage:(NSArray *)array isShowText:(BOOL)isShowText
{
    for (int i = 0; i < array.count; i++)
    {
        DDLFood *food = array[i];
        
        //修改文字和图片
        UIButton *button = (UIButton *)[vegeTableView viewWithTag:i+1];
        [button setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:food.pictureUrlString]];
        if (isShowText)
        {
            [button setTitle:food.chName forState:UIControlStateNormal];
        }
        else
        {
            [button setTitle:@"" forState:UIControlStateNormal];
        }
    }
}

#pragma mark DDLBottomTabbarViewDelegate
- (void)didSelectBottomTabbarViewAtIndex:(NSInteger)index
{
    
    selectClassifyIndex = index;
    
    if (!isOpen)
    {
        //上移
        [self open];
    }
    
    DDLClassify *classify = classifyArray[index];

    //默认显示
    BOOL isShowText = YES;
    
    if ([classify.classify_name isEqualToString:@"八大菜系"])
    {
        isShowText = NO;
    }
    
    //修改vegetableView文字和图片
    [self setVegeTableViewButtonTitleAndImage:classify.vegetableArray isShowText:isShowText];
}

- (void)open
{
    
    isOpen = YES;

    [self resetVegeTableAndTabbarViewFrame:(-vegeTableView.frame.size.height)];
}

- (void)colse
{
    
    if (isOpen)
    {
        //tabbar坐标
        [self resetVegeTableAndTabbarViewFrame:vegeTableView.frame.size.height];
    }
    
    isOpen = NO;
    
    
}

- (void)resetVegeTableAndTabbarViewFrame:(CGFloat)yOffset
{
    //tabbar坐标
    CGRect tabbarFrame = tabbarView.frame;
    CGRect vegetableFrame = vegeTableView.frame;
    
    tabbarFrame.origin.y += yOffset;
    vegetableFrame.origin.y += yOffset;
    
    
    [UIView animateWithDuration:0.5 animations:^{
        tabbarView.frame = tabbarFrame;
        vegeTableView.frame = vegetableFrame;
    }];
}

#pragma mark -
//请求数据
- (void)requestDataFromNetWorkWithUrlString:(NSString *)urlString
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
      
         NSArray *jsonArray = responseObject[@"data"];
         //tabbar
         if ([urlString isEqualToString:FoodRandomTabbarView_url])
         {
             for (NSDictionary *jsonDic in jsonArray)
             {
                 DDLClassify *classify = [[DDLClassify alloc] init];
                 classify.classify_ID = jsonDic[@"vegetableCatalogId"];
                 classify.classify_name = jsonDic[@"caralogName"];
                 classify.classify_imagePath = jsonDic[@"imagePathName"];
                 //分类下蔬菜
                 for (NSDictionary *dic in jsonDic[@"TblVegetableChildCatalog"])
                 {
                     DDLFood *food = [[DDLFood alloc] init];
                     food.vegetableId = dic[@"vegetableChildCatalogId"];
                     food.chName = dic[@"childCatalogName"];
                     food.pictureUrlString = dic[@"imagePathName"];
                     
                     [classify.vegetableArray addObject:food];
                 }
                 
                 //添加到数组
                 [classifyArray addObject:classify];
             }
             
             DDLClassify *classify = classifyArray[0];
             DDLFood *food = classify.vegetableArray[0];
             
             //刷新tabbarView
             [self resetTabberViewImageAndTitle];
             
             
             //请求数据
             [self requestDataFromNetWorkWithUrlString:[NSString stringWithFormat:FoodRandomTabbarDetailView_url,food.vegetableId]];
         }
         else  //数据
         {
             
             if (foodArray.count > 0)
             {
                 [foodArray removeAllObjects];
             }
             
             
             for (NSDictionary *dic in jsonArray)
             {
                 DDLFood *food = [[DDLFood alloc] init];
                 food.vegetableId = dic[@"vegetable_id"];
                 food.chName = dic[@"name"];
                 food.clickCount = [dic[@"clickCount"] integerValue];
                 food.pictureUrlString = dic[@"imagePathLandscape"];
                 
                 [foodArray addObject:food];
             }
             
             //刷新collectionView
             [listView updateCollectionViewWithDataSource:foodArray];
         }
         
         
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)resetTabberViewImageAndTitle
{
    
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *normalImages = [NSMutableArray array];
    //NSMutableArray *selectImages = [NSMutableArray array];
    
    for (DDLClassify *classify in classifyArray)
    {
        [titles addObject:classify.classify_name];
        [normalImages addObject:classify.classify_imagePath];
    }
    
    //刷新
    [tabbarView setBottomTabbarViewImageWithImageNames:normalImages selectedImageNames:nil titles:titles isScroll:YES];
}

/**
 初始化tabbarView
 */
- (void)initTabbarView
{
    tabbarView = [[DDLBottomTabbarView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49 - 64, self.view.frame.size.width, 49)];
    tabbarView.delegate = self;
    tabbarView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:tabbarView];
    
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
