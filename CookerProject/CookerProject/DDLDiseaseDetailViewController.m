//
//  DDLDiseaseDetailViewController.m
//  CookerProject
//
//  Created by vera on 15-1-24.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLDiseaseDetailViewController.h"
#import "DDLDiseaseDetailAlertView.h"
#import "DDLFoodListView.h"
#import "DDLUrl.h"
#import "AFNetworking.h"
#import "DDLFood.h"
#import "DDLFoodDetailViewController.h"

@interface DDLDiseaseDetailViewController ()<DDLDiseaseDetailAlertViewDelegate,DDLFoodListViewDelegate>
{
    //瀑布流视图
    DDLFoodListView *foodListView;
    
    NSMutableArray *foodArray;
}

@end

@implementation DDLDiseaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    foodArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图"]];
    
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //描述按钮
    [self initDiseaseDetailButton];
    //初始化瀑布流界面
    [self initFoodListView];
    //请求数据
    [self requestDataFromNetWorkWithUrl:[NSString stringWithFormat:FoodTrateDiseaseDetail_url,_disease.diseaseId]];
}

- (void)requestDataFromNetWorkWithUrl:(NSString *)urlString
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //返回的数据是NSData
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
        //[NSJSONSerialization JSONObjectWithData:<#(NSData *)#> options:<#(NSJSONReadingOptions)#> error:<#(NSError *__autoreleasing *)#>];
        
        NSArray *jsonArray = responseObject[@"data"];
        
        for (NSDictionary *dic in jsonArray)
        {
            DDLFood *food = [[DDLFood alloc] init];
            food.pictureUrlString = dic[@"imagePathLandscape"];
            food.clickCount = [dic[@"clickCount"] integerValue];
            food.chName = dic[@"name"];
            food.vegetableId = dic[@"vegetableId"];
            
            //添加到数组
            [foodArray addObject:food];
        }
        
        //刷新collectionView
        [foodListView updateCollectionViewWithDataSource:foodArray];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)initFoodListView
{
    foodListView = [[DDLFoodListView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 80 - 64)];
    foodListView.delegate = self;
    [self.view addSubview:foodListView];
}

#pragma mark -DDLFoodListViewDelegate
- (void)didSelectedCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    
    DDLFood *food = foodArray[indexPath.item];
    
    DDLFoodDetailViewController *foodDetailVC = [[DDLFoodDetailViewController alloc] init];
    foodDetailVC.vegetable_id = food.vegetableId;
    [self.navigationController pushViewController:foodDetailVC animated:YES];
}

#pragma mark -
//详细按钮点击
- (void)diseaseDetailButtonClick:(UIButton *)button
{
    button.selected = YES;
    
    int xOffset = 20;
    
    DDLDiseaseDetailAlertView *alertView = [[DDLDiseaseDetailAlertView alloc] initWithFrame:CGRectMake(xOffset, 10, self.view.frame.size.width - 2*xOffset, self.view.frame.size.height - 30)];
    //赋值
    [alertView setAlertViewText:self.disease.diseaseName detailText:self.disease.diseaseDescribe fitText:self.disease.fitEat liftText:self.disease.lifeSuit];
    alertView.delegate = self;
    [self.view addSubview:alertView];
}

#pragma mark  DDLDiseaseDetailAlertViewDelegate
- (void)dismissAlertView:(DDLDiseaseDetailAlertView *)alertView
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:1000];
    btn.selected = NO;
}

#pragma mark -
//描述按钮
- (void)initDiseaseDetailButton
{
    UIButton *diseaseDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    diseaseDetailButton.frame = CGRectMake(0, 10, self.view.frame.size.width, 60);
    diseaseDetailButton.tag = 1000;
    [diseaseDetailButton setBackgroundImage:[UIImage imageNamed:@"详细疾病-详情"] forState:UIControlStateNormal];
    [diseaseDetailButton setBackgroundImage:[UIImage imageNamed:@"详细疾病-详情-选"] forState:UIControlStateSelected];
    [diseaseDetailButton addTarget:self action:@selector(diseaseDetailButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:diseaseDetailButton];
    
    UILabel *detailLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 20)];
    detailLabelTitle.text = @"疾病简介 ";
    detailLabelTitle.textColor = [UIColor lightGrayColor];
    detailLabelTitle.font = [UIFont systemFontOfSize:15];
    [diseaseDetailButton addSubview:detailLabelTitle];
    
    
    UILabel *diseaseDetail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(detailLabelTitle.frame) + 10, detailLabelTitle.frame.origin.y, diseaseDetailButton.frame.size.width - CGRectGetMaxX(detailLabelTitle.frame) - 50, diseaseDetailButton.frame.size.height - 10)];
    diseaseDetail.font = [UIFont systemFontOfSize:12];
    diseaseDetail.numberOfLines = 0;
    diseaseDetail.text = _disease.diseaseDescribe;
    [diseaseDetailButton addSubview:diseaseDetail];
    
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
