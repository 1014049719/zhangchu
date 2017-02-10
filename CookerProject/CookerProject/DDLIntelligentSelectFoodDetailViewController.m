//
//  DDLIntelligentSelectFoodDetailViewController.m
//  CookerProject
//
//  Created by vera on 15-1-30.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLIntelligentSelectFoodDetailViewController.h"
#import "DDLFoodListView.h"
#import "DDLFood.h"
#import "AFNetworking.h"
#import "DDLUrl.h"

@interface DDLIntelligentSelectFoodDetailViewController ()
{
    DDLFoodListView *listView;
    //数据源
    NSMutableArray *allVegetableArray;
}

@end

@implementation DDLIntelligentSelectFoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    allVegetableArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化label
    [self initTipLabel];
    //初始化collectionView
    [self initListView];
    
    NSString *urlString = [NSString stringWithFormat:FoodIntelligentSelectFoodDetail_url,[self getUrlString]];
    NSLog(@"%@",urlString);
    //请求数据
    [self requestDataFromNetWorkWithUrlString:urlString];
    
}

//获取地址
- (NSString *)getUrlString
{
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < _searchVegetableAarray.count; i++)
    {
        DDLFood *food = _searchVegetableAarray[i];
        
        if (i == (_searchVegetableAarray.count-1))
        {
            [string appendString:food.vegetableId];
        }
        else
        {
            [string appendFormat:@"%@,",food.vegetableId];
        }
    }
    
    return string;
}

- (void)requestDataFromNetWorkWithUrlString:(NSString *)urlString
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
        NSArray *array = responseObject[@"data"];
        
        for (NSDictionary *dic in array)
        {
            DDLFood *food = [[DDLFood alloc] init];
            food.vegetableId = dic[@"vegetable_id"];
            food.chName = dic[@"name"];
            food.clickCount = [dic[@"clickCount"] integerValue];
            food.pictureUrlString = dic[@"imagePathLandscape"];
            
            [allVegetableArray addObject:food];
        }
        
        //刷新
        [listView updateCollectionViewWithDataSource:allVegetableArray];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
}

- (void)initListView
{
    listView = [[DDLFoodListView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 64 - 20)];
    [self.view addSubview:listView];
}

- (void)initTipLabel
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    l.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:l];
    
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < _searchVegetableAarray.count; i++)
    {
        DDLFood *food = _searchVegetableAarray[i];
        
        if (i == (_searchVegetableAarray.count-1))
        {
            [string appendString:food.chName];
        }
        else
        {
            [string appendFormat:@"%@+",food.chName];
        }
    }
    
    //赋值
    l.text = string;
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
