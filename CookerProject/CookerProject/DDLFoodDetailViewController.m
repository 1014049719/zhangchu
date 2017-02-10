//
//  DDLFoodDetailViewController.m
//  CookerProject
//
//  Created by vera on 15-1-25.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLFoodDetailViewController.h"
#import "DDLBottomTabbarView.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "DDLUrl.h"
#import "DDLFood.h"
#import <MediaPlayer/MediaPlayer.h>
#import "DDLMaterialCollectionViewController.h"

@interface DDLFoodDetailViewController ()<DDLBottomTabbarViewDelegate>
{
    
    DDLBottomTabbarView *tabbarView;
    
    DDLFood *food;
    
    //食物图片
    UIImageView *foodImageView;
}

@end

@implementation DDLFoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    /**
     初始化图片
     */
    [self initFoodImageView];
    
    /**
     初始化tabbarView
     */
    [self initTabbarView];
    
    /**
     初始化视频视图
     */
    [self initVideoView];
    
    //请求数据
    [self requestDataFromNetWork];
    
}

- (void)requestDataFromNetWork
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:FoodDetail_url,_vegetable_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"data"] count] > 0)
        {
            NSDictionary *dic = responseObject[@"data"][0];
            
            //解析
            food = [[DDLFood alloc] init];
            food.vegetableId = dic[@"vegetable_id"];
            food.chName = dic[@"name"];
            food.enName = dic[@"englishName"];
            food.pictureUrlString = dic[@"imagePathLandscape"];
            food.timeLength = dic[@"timeLength"];
            food.taste = dic[@"taste"];
            food.cookingMethod = dic[@"cookingMethod"];
            food.effect = dic[@"effect"];
            food.fittingCrowd = dic[@"fittingCrowd"];
            food.materialVideoPath = dic[@"materialVideoPath"];
            food.productionProcessPath = dic[@"productionProcessPath"];
            food.material = dic[@"fittingRestriction"];
            food.flavour = dic[@"method"];
            
            
        }
        
        //赋值
        [self setFoodModel];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

//赋值
- (void)setFoodModel
{
    [foodImageView setImageWithURL:[NSURL URLWithString:food.pictureUrlString] placeholderImage:nil];
    _chNameLabel.text = food.chName;
    _enNameLabel.text = food.enName;
    _cookTimeLabel.text = food.timeLength;
    _tasteLabel.text = food.taste;
    _cookMethodLabel.text = food.cookingMethod;
    _effectLabel.text = food.effect;
    _fitPersonLabel.text = food.fittingCrowd;
}

/**
 初始化视频视图
 */
- (void)initVideoView
{
    int videoHeight = 44;
    
    UIView *videoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(tabbarView.frame) - videoHeight, self.view.frame.size.width, videoHeight)];
    videoView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"详情-视频底"]];
    [self.view addSubview:videoView];
    
    int count = 3;
    
    //按钮宽和高
    int buttonWidth = 44;
    int buttonHeight = buttonWidth;
    
    //空隙
    int space = (self.view.frame.size.width - 3*buttonWidth)/(count+1);
    
    //添加按钮
    for (int i = 0; i < count; i++)
    {
        CGRect frame = CGRectMake(space*(i+1) + buttonWidth*i, 0, buttonWidth, buttonHeight);
        
        //按钮
        if (i == 0 || i == 2)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = frame;
            //图片偏移
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 20, 10);
            //文字偏移
            button.titleEdgeInsets = UIEdgeInsetsMake(20, -60, 0, 0);
            button.titleLabel.font = [UIFont systemFontOfSize:10];
            [button setImage:[UIImage imageNamed:@"详情-视频标志"] forState:UIControlStateNormal];
            [button setTitle:((i==0)?@"材料准备":@"制作过程") forState:UIControlStateNormal];
            button.tag = i+1;
            [button addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
            [videoView addSubview:button];
        }
        else //图片
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            imageView.image = [UIImage imageNamed:@"详情-同步视频"];
            [videoView addSubview:imageView];
        }
    }
}
//视频播放
- (void)playVideo:(UIButton *)button
{
    NSString *urlString;
    
    if (button.tag == 1)
    {
        urlString = food.materialVideoPath;
    }
    else
    {
        urlString = food.productionProcessPath;
    }
    
    //初始化播放器
    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:urlString]];
    [self presentMoviePlayerViewControllerAnimated:moviePlayer];
}

/**
 初始化tabbarView
 */
- (void)initTabbarView
{
    tabbarView = [[DDLBottomTabbarView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 64 - 49, self.view.frame.size.width, 49)];
    tabbarView.delegate = self;
    //[tabbarView setBottomTabbarViewImageWithImageNames:@[@"详情-材料",@"详情-做法",@"详情-相关常识",@"详情-相宜相克"] titles:];
    [tabbarView setBottomTabbarViewImageWithImageNames:@[@"详情-材料",@"详情-做法",@"详情-相关常识",@"详情-相宜相克"] selectedImageNames:nil titles:@[@"材料",@"做法",@"相关常识",@"相宜相克"] isScroll:NO];
    [self.view addSubview:tabbarView];
    
}

/**
 初始化图片
 */
- (void)initFoodImageView
{
    foodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)];
    [self.view addSubview:foodImageView];
    [self.view sendSubviewToBack:foodImageView];
}
#pragma mark DDLBottomTabbarViewDelegate
- (void)didSelectBottomTabbarViewAtIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:   //材料
        {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.itemSize = CGSizeMake(280, 200);
            
            DDLMaterialCollectionViewController *materialVC = [[DDLMaterialCollectionViewController alloc] initWithCollectionViewLayout:layout];
            //传值
            materialVC.food = food;
            [self.navigationController pushViewController:materialVC animated:YES];
        }
            
            break;
        case 1:   //做法
            
            break;
        case 2:   //相关常识
            
            break;
        case 3:   //相宜相克
            
            break;
            
        default:
            break;
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
