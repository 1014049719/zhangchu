//
//  DDLFoodMaterialViewController.m
//  CookerProject
//
//  Created by vera on 15-1-27.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLFoodMaterialViewController.h"
#import "DDLMenuView.h"
#import "AFNetworking.h"
#import "DDLUrl.h"
#import "DDLClassify.h"
#import "DDLMaterial.h"

@interface DDLFoodMaterialViewController ()<DDLMenuViewDelegate>
{
    DDLMenuView *menuView;
    
    //分类
    NSMutableArray *classifyArray;
    //保存分类下的材料列表
    NSMutableArray *materialArray;
}

@end

@implementation DDLFoodMaterialViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    classifyArray = [NSMutableArray array];
    materialArray = [NSMutableArray array];
    
    /*
     初始化二级菜单视图
     */
    [self initMenuView];
    
    /**
     初始化UIBarButtonItem
     */
    [self initLeftButtonItem];
    
    /**
     请求分类数据
     */
    [self requestDataWithUrlString:FoodMaterial_left_url];
}

/**
 初始化UIBarButtonItem
 */
- (void)initLeftButtonItem
{
    //空隙
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButtonItem.width = -20;
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 60, 44);
    [backButton setBackgroundImage:[UIImage imageNamed:@"首页-返回-选"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItems = @[spaceButtonItem,leftButtonItem];
}

- (void)backViewController
{
    [menuView colse];
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 初始化二级菜单视图
 */
- (void)initMenuView
{
    menuView = [[DDLMenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    menuView.materialType = DDLMenuViewMaterialTypeForMaterial;
    menuView.delegate = self;
    [menuView open];
    [self.view addSubview:menuView];
}

#pragma mark DDLMenuViewDelegate
- (void)didSelectedMenuView:(DDLMenuView *)menuView menuObject:(NSObject *)object
{
    //分类
    if ([object isKindOfClass:[DDLClassify class]])
    {
        //请求分类下材料
        [self requestDataWithUrlString:[NSString stringWithFormat:FoodMaterial_right_url,((DDLClassify *)object).classify_ID]];
    }
    else //材料
    {
        NSLog(@"右。。。。。。。");
        
        //进入下个界面
    }
}

/**
 请求数据
 */
- (void)requestDataWithUrlString:(NSString *)urlString
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSArray *jsonArray = responseObject[@"data"];
        
        if ([urlString isEqualToString:FoodMaterial_left_url])
        {
            for (NSDictionary *dic in jsonArray)
            {
                DDLClassify *classify = [[DDLClassify alloc] init];
                classify.classify_ID = dic[@"materialTypeId"];
                classify.classify_name = dic[@"name"];
                
                [classifyArray addObject:classify];
            }
            
            //刷新
            [menuView reloadTableViewDataSourceWithTradeArray:classifyArray isLeft:YES];
            
            DDLClassify *classify = classifyArray[0];
            //请求分类下材料
            [self requestDataWithUrlString:[NSString stringWithFormat:FoodMaterial_right_url,classify.classify_ID]];
        }
        else  //分类下的材料列表
        {
            
            //先移除
            if (materialArray.count > 0)
            {
                [materialArray removeAllObjects];
            }
            
            for (NSDictionary *dic in jsonArray)
            {
                DDLMaterial *material = [[DDLMaterial alloc] init];
                material.materialId = dic[@"materialId"];
                material.materialName = dic[@"name"];
                material.imagePath = dic[@"imageFilename"];
                
                //添加的数组
                [materialArray addObject:material];
            }
            
            //刷新
            [menuView reloadTableViewDataSourceWithTradeArray:materialArray isLeft:NO];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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
