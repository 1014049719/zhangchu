//
//  DDLFoodTreatViewController.m
//  CookerProject
//
//  Created by vera on 15-1-22.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLFoodTreatViewController.h"
#import "DDLUrl.h"
#import "AFNetworking.h"
#import "DDLUIKit.h"
#import "DDLOffice.h"
#import "DDLMenuView.h"
#import "DDLDisease.h"
#import "DDLDiseaseDetailViewController.h"

@interface DDLFoodTreatViewController ()<DDLMenuViewDelegate>
{
    //科 -- 数据源
    NSMutableArray *officeArray;
    
    //疾病 -- 数据源
    NSMutableArray *diseaseArray;
    
    DDLMenuView *menuView;
    
    //选中的officeID
    NSString *selectedOffice;
}

@end

@implementation DDLFoodTreatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    officeArray = [NSMutableArray array];
    diseaseArray = [NSMutableArray array];
    
    /**
     初始化导航条
     */
    [self initNavigationBar];
    
    /**
     初始化二级菜单视图
     */
    [self initSecondMenuView];
    
    /**
     请求请求
     */
    [self requestDataWithUrlString:FoodTrateOffice_url];
}

//请求数据
- (void)requestDataWithUrlString:(NSString *)urlString
{
    //显示
    [DDLUIKit showMBProgessHUDSuperView:self.view animate:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        //隐藏
        [DDLUIKit hideAllProgessHUDSuperView:self.view animate:YES];
        
        NSArray *jsonArray = responseObject[@"data"];

        //科
        if ([urlString isEqualToString:FoodTrateOffice_url])
        {
            
            for (NSDictionary *dic in jsonArray)
            {
                DDLOffice *office = [[DDLOffice alloc] init];
                office.officeId = dic[@"officeId"];
                office.officeName = dic[@"officeName"];
                office.diseaseNames = dic[@"diseaseNames"];
                office.imagePath = dic[@"imagePath"];
                //添加到数组里面
                [officeArray addObject:office];
            }
            
            //刷新
            [menuView reloadTableViewDataSourceWithTradeArray:officeArray isLeft:YES];
        }
        else  //疾病
        {
            for (NSDictionary *dic in jsonArray)
            {
                DDLDisease *disease = [[DDLDisease alloc] init];
                disease.diseaseId = dic[@"diseaseId"];
                disease.diseaseDescribe = dic[@"diseaseDescribe"];
                disease.diseaseName = dic[@"diseaseName"];
                disease.fitEat = dic[@"fitEat"];
                disease.imageName = dic[@"imageName"];
                disease.lifeSuit = dic[@"lifeSuit"];
                //添加到数组
                [diseaseArray addObject:disease];
            }
            
            //刷新tableView
            [menuView reloadTableViewDataSourceWithTradeArray:diseaseArray isLeft:NO];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //隐藏
        [DDLUIKit hideAllProgessHUDSuperView:self.view animate:YES];
        
    }];
}

/**
 初始化二级菜单视图
 */
- (void)initSecondMenuView
{
    menuView = [[DDLMenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    menuView.delegate = self;
    [self.view addSubview:menuView];
}

/**
 初始化导航条
 */
- (void)initNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"首页-返回-选"] style:UIBarButtonItemStylePlain target:self action:@selector(backMainViewController)];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 60, 40);
    [backButton setBackgroundImage:[UIImage imageNamed:@"首页-返回-选"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMainViewController) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    //titleView.backgroundColor = [UIColor redColor];
    
    UIImageView *barImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"对症－导航logo"]];
    barImageView.frame = CGRectMake(50, titleView.frame.size.height/2 - 10, 20, 20);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(barImageView.frame), 0, 100, 40)];
    titleLabel.text = @"对症食疗";
    titleLabel.textColor = [UIColor whiteColor];
    
    [titleView addSubview:barImageView];
    [titleView addSubview:titleLabel];
    //设置导航titleView
    self.navigationItem.titleView = titleView;
    
    
    
   
}

//返回主界面
- (void)backMainViewController
{
    if (menuView.menuType == DDLMenuTypeForRightOpen)
    {
        //TODO
        [menuView colse];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)didSelectedOfficeId:(NSString *)officeId
{
    //NSLog(@"officeid:%@",officeId);
    
    //1.保存officeID
    selectedOffice = officeId;
    
    //2.清空旧数据
    if (diseaseArray.count > 0)
    {
        [diseaseArray removeAllObjects];
    }
    
    NSString *urlString = [NSString stringWithFormat:FoodTrateDisease_url,selectedOffice];
    //3.从新请求数据
    [self requestDataWithUrlString:urlString];
}

- (void)didSelectedDisease:(DDLDisease *)disease
{
    //进入疾病详情
    DDLDiseaseDetailViewController *diseaseDetailVC = [[DDLDiseaseDetailViewController alloc] init];
    diseaseDetailVC.disease = disease;
    [self.navigationController pushViewController:diseaseDetailVC animated:YES];
}

#pragma mark DDLMenuViewDelegate
- (void)didSelectedMenuView:(DDLMenuView *)menuView menuObject:(NSObject *)object
{
    //科
    if ([object isKindOfClass:[DDLOffice class]])
    {
        [self didSelectedOfficeId:((DDLOffice *)object).officeId];
    }
    else  //疾病
    {
        [self didSelectedDisease:(DDLDisease *)object];
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
