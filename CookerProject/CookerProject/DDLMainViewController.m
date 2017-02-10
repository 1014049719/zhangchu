//
//  DDLMainViewController.m
//  CookerProject
//
//  Created by vera on 15-1-20.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLMainViewController.h"
#import "DDLBottomTabbarView.h"
#import "DDLUrl.h"
#import "AFNetworking.h"
#import "DDLUtility.h"
#import "DDLFood.h"
#import "UIImageView+AFNetworking.h"
#import "DDLPageControl.h"
#import "DDLFoodTreatViewController.h"
#import "DDLUIKit.h"
#import "DDLFoodMaterialViewController.h"
#import "DDLRandomSelectFoodViewController.h"
#import "DDLSharkViewController.h"
#import "DDLIntelligentSelectFoodViewController.h"
#import "DDLSearchViewController.h"
#import "ZBarSDK.h"
#import "DDLCreateZbarImageViewController.h"

@interface DDLMainViewController ()<UIScrollViewDelegate,DDLBottomTabbarViewDelegate,ZBarReaderDelegate,ZBarReaderViewDelegate>
{
    //宜
    UILabel *helpLabel;
    
    //忌
    UILabel *harmLabel;
    
    //是否显示宜
    BOOL isShowHelp;
    
    //数据源
    NSMutableArray *foodDataSourceArray;
    
    UIScrollView *foodScrollView;
    
    DDLPageControl *foodPageControl;
    
    //tabbar
    DDLBottomTabbarView *tabbarView;
}

@end

@implementation DDLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     input source ,timer source
     
     NSRunLoop
     */
    
    
    isShowHelp = YES;
    
    foodDataSourceArray = [NSMutableArray array];
    
    /*
     创建滚动视图
     */
    [self initScrollView];
    
    /**
     初始化导航条
     */
    [self initNavigationBar];
    
    /**
     初始化tabbarView
     */
    [self initBottomTabbarView];
    
    /**
     初始化宜,忌label
     */
    [self initHelpAndHarmLabel];
    
    /**
     初始化pageControl
     */
    [self initPageControl];
    
    /**
     请求日期数据
     */
    [self requestDataFromNetWorkWithUrlString:Main_Date_Url];
    //请求数据
    [self requestDataFromNetWorkWithUrlString:Main_FoodData_url];
}

/**
 初始化pageControl
 */
- (void)initPageControl
{
    foodPageControl = [[DDLPageControl alloc] initWithFrame:CGRectMake(10, tabbarView.frame.origin.y - 30, tabbarView.frame.size.width, 20) numberOfPage:16];
    [self.view addSubview:foodPageControl];
}

/*
 创建滚动视图
 */
- (void)initScrollView
{
    foodScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)];
    //分页显示
    foodScrollView.pagingEnabled = YES;
    foodScrollView.delegate = self;
    [self.view addSubview:foodScrollView];
}

/**
 初始化宜,忌label
 */
- (void)initHelpAndHarmLabel
{
    helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.recommentView.frame.size.height)];
    [self.recommentView addSubview:helpLabel];
    
    harmLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.recommentView.frame.size.width, 0, 0, helpLabel.frame.size.height)];
    
    //字体
    helpLabel.font = [UIFont systemFontOfSize:15];
    harmLabel.font = [UIFont systemFontOfSize:15];
    
    //颜色
    helpLabel.textColor = [UIColor whiteColor];
    harmLabel.textColor = [UIColor whiteColor];
    
    [self.recommentView addSubview:helpLabel];
    [self.recommentView addSubview:harmLabel];
    
    //超过范围不显示
    self.recommentView.clipsToBounds = YES;
}

/**
 请求数据
 */
- (void)requestDataFromNetWorkWithUrlString:(NSString *)urlString
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        //日期
        if ([urlString isEqualToString:Main_Date_Url])
        {
            //赋值
            [self showMainDate:responseObject];
        }
        //数据
        else
        {
            //解析首页数据
            [self parseMainFoodData:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        //提示
        [DDLUIKit showAlertViewWithMessage:@"请求失败"];
    }];
}

//解析首页数据
- (void)parseMainFoodData:(id)responseObjcet
{
    //解析
    NSArray *jsonArray = responseObjcet[@"data"];
    
    for (NSDictionary *dic in jsonArray)
    {
        DDLFood *food = [[DDLFood alloc] init];
        food.pictureUrlString = dic[@"imagePathLandscape"];
        food.chName = dic[@"name"];
        food.enName = dic[@"englishName"];
        //添加到数据源
        
        [foodDataSourceArray addObject:food];
    }
    
    //在滚动视图上添加图片
    [self addImageViewToFoodScrollView];
    
    //名字赋值
    if (foodDataSourceArray.count > 0)
    {
        DDLFood *food = foodDataSourceArray[0];
        [self setFoodNameWithChName:food.chName enName:food.enName];
    }
}

//中文，英文名字赋值
- (void)setFoodNameWithChName:(NSString *)chName enName:(NSString *)enName
{
    self.chNameLabel.text = chName;
    self.enNameLabel.text = enName;
}

//在滚动视图上添加图片
- (void)addImageViewToFoodScrollView
{
    //设置滚动视图滚动范围
    foodScrollView.contentSize = CGSizeMake(foodScrollView.frame.size.width * foodDataSourceArray.count, foodScrollView.frame.size.height);
    
    for (int i = 0; i < foodDataSourceArray.count; i++)
    {
        DDLFood *food = foodDataSourceArray[i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(foodScrollView.frame.size.width * i, 0, foodScrollView.frame.size.width, foodScrollView.frame.size.height)];
        [imageView setImageWithURL:[NSURL URLWithString:food.pictureUrlString] placeholderImage:[UIImage imageNamed:@"defaultImage-586h"]];
        [foodScrollView addSubview:imageView];
    }
    
    //把滚动视图放到后面
    [self.view sendSubviewToBack:foodScrollView];

}

/**
 显示日期
 */
- (void)showMainDate:(id)resonseObject
{
    //赋值
    NSArray *jsonArray = resonseObject[@"data"];
    
    if (jsonArray.count > 0)
    {
        NSDictionary *dic = jsonArray[0];
        //农历
        self.dateLabel.text = dic[@"LunarCalendar"];
        
        NSString *dateText = dic[@"GregorianCalendar"];
        NSArray *sepArr = [dateText componentsSeparatedByString:@"-"];
        
        self.dayLabel.text = sepArr[2];
        self.yearAndMonthLabel.text = [NSString stringWithFormat:@"%@-%@",sepArr[0],sepArr[1]];
        
        //1.获取忌和宜文字
        NSString *helpString = dic[@"alertInfoFitting"];
        NSString *harmString = dic[@"alertInfoAvoid"];
        
        //2.赋值
        helpLabel.text = helpString;
        harmLabel.text = harmString;
        
        //3.计算宽度
        CGFloat helpWidth = [DDLUtility getTextSizeWithText:helpString font:[UIFont systemFontOfSize:15] width:10000].width;
        CGFloat harmWidth = [DDLUtility getTextSizeWithText:harmString font:[UIFont systemFontOfSize:15] width:10000].width;
        
        
        //4.修改宽度
        CGRect frame = helpLabel.frame;
        frame.size.width = helpWidth;
        helpLabel.frame = frame;
        
        frame = harmLabel.frame;
        frame.size.width = harmWidth;
        harmLabel.frame =frame;
        
        
        //5.文字移动
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateLabelOriginX) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
    }
}

//刷新坐标
- (void)updateLabelOriginX
{
    if (isShowHelp)
    {
        CGRect frame = helpLabel.frame;
        frame.origin.x -= 2.0;
        helpLabel.frame = frame;
        
        if (ABS(helpLabel.frame.origin.x) > helpLabel.frame.size.width)
        {
            isShowHelp = NO;
            
            //改变harmLabel的x
            CGRect harmFrame = harmLabel.frame;
            harmFrame.origin.x = self.recommentView.frame.size.width;
            harmLabel.frame = harmFrame;
            
            //修改图片
            self.helpImageView.image = [UIImage imageNamed:@"首页-忌"];
        }
    }
    else
    {
        CGRect frame = harmLabel.frame;
        frame.origin.x -= 2.0;
        harmLabel.frame = frame;
        
        if (ABS(harmLabel.frame.origin.x) > harmLabel.frame.size.width)
        {
            isShowHelp = YES;
            
            //改变harmLabel的x
            CGRect harmFrame = helpLabel.frame;
            harmFrame.origin.x = self.recommentView.frame.size.width;
            helpLabel.frame = harmFrame;
            
            //修改图片
            self.helpImageView.image = [UIImage imageNamed:@"首页-宜"];
        }
    }
}

/**
 初始化tabbarView
 */
- (void)initBottomTabbarView
{
    //图片
    NSArray *imageNames = @[@"首页-对症治疗",@"首页-热门推荐",@"首页-每月美食",@"首页-对症治疗"];
    //title
    NSArray *titles = @[@"对症治疗",@"热门推荐",@"食材大全",@"摇一摇"];
    
    tabbarView = [[DDLBottomTabbarView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49 - 64, 230, 49)];
    tabbarView.delegate = self;
    //[tabbarView setBottomTabbarViewImageWithImageNames:imageNames titles:titles];
    [tabbarView setBottomTabbarViewImageWithImageNames:imageNames selectedImageNames:nil titles:titles isScroll:NO];
    [self.view addSubview:tabbarView];
        
    //
    int yOffset = 36;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMaxX(tabbarView.frame), tabbarView.frame.origin.y - yOffset, self.view.frame.size.width - tabbarView.frame.size.width, tabbarView.frame.size.height + yOffset);
    [button setBackgroundImage:[UIImage imageNamed:@"首页-选菜"] forState:UIControlStateNormal];
    //设置文字
    [button setTitle:@"万道美食\n任你选" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    button.titleEdgeInsets = UIEdgeInsetsMake(-35, 5, 0, 0);
    //多行显示
    button.titleLabel.numberOfLines = 2;
    //居中
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(enterRandomSelectFoodViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

//进入“万道美食任您选”界面
- (void)enterRandomSelectFoodViewController
{
    DDLRandomSelectFoodViewController *randomSelectFoodVC = [[DDLRandomSelectFoodViewController alloc] init];
    [self.navigationController pushViewController:randomSelectFoodVC animated:YES];
}

/**
 初始化导航条
 */
- (void)initNavigationBar
{
    self.title = @"掌厨-全球最大的视频厨房";
    
    //设置导航条字体颜色字体
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14]};
    
    UIView *rightBarButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    
    int buttonWidth = rightBarButtonView.frame.size.width/3;
    
    //图片名字
    NSArray *imageNames = @[@"首页-智能选菜",@"首页-搜索",@"首页-我的"];
    NSArray *titles = @[@"智能选菜",@"搜索",@"我的"];
    
    for (int i = 0; i < 3; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonWidth*i, 0, buttonWidth, rightBarButtonView.frame.size.height);
        [button setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:9];
        //文字偏移
        button.titleEdgeInsets = UIEdgeInsetsMake(20, 2, 0, 0);
        button.tag = i+1;
        [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [rightBarButtonView addSubview:button];
        
    }
    
    //右视图
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonView];
    
}

- (void)didClickButton:(UIButton *)button
{
    switch (button.tag)
    {
        case 1:  //智能选菜
        {
            DDLIntelligentSelectFoodViewController *intelligentSelectFoodVC = [[DDLIntelligentSelectFoodViewController alloc] init];
            [self.navigationController pushViewController:intelligentSelectFoodVC animated:YES];
        }
            
            break;
        case 2:  //搜索
        {
            DDLSearchViewController *searchVC = [[DDLSearchViewController alloc] init];
            [self.navigationController pushViewController:searchVC animated:YES];
        }
            break;
        case 3:  //我的
            
            break;
            
        default:
            break;
    }
}

#pragma mark -DDLBottomTabbarViewDelegate
- (void)didSelectBottomTabbarViewAtIndex:(NSInteger)index
{
    //NSLog(@"%d",index);
    switch (index)
    {
        case 0: // 对症食疗
        {
            DDLFoodTreatViewController *foodTreatVC = [[DDLFoodTreatViewController alloc] init];
            [self.navigationController pushViewController:foodTreatVC animated:YES];
        }
            
            break;
        case 1: // 热门推荐
            
            break;
        case 2: // 食材大全
        {
            DDLFoodMaterialViewController *foodMaterialVC = [[DDLFoodMaterialViewController alloc] init];
            [self.navigationController pushViewController:foodMaterialVC animated:YES];
        }
            break;
        case 3: // 摇一摇
        {
            DDLSharkViewController *sharkVC = [[DDLSharkViewController alloc] init];
            [self.navigationController pushViewController:sharkVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //1.计算index
    NSInteger index = (NSInteger)scrollView.contentOffset.x / scrollView.frame.size.width;
    
    //2.取值
    DDLFood *food = foodDataSourceArray[index];
    
    //3.修改名字
    [self setFoodNameWithChName:food.chName enName:food.enName];
    
    //4.修改pageControl
    [foodPageControl updatePageIndexWithCurrentIndex:index count:foodDataSourceArray.count];
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

//扫描
- (IBAction)zBarButtonClick:(id)sender
{
#if 0
    ZBarReaderView *readerView = [[ZBarReaderView alloc] init];
    readerView.frame = CGRectMake(0, 0, 300, 300);
    readerView.readerDelegate = self;
    [self.view addSubview:readerView];
    //打开手机摄像头，开始扫描
    [readerView start];
    //扫描完成
    //[readerView stop];
#endif
    
   
    
    
    ZBarReaderViewController *zbarReaderVC = [[ZBarReaderViewController alloc] init];
    //设置delegate
    zbarReaderVC.readerDelegate = self;
    [self presentViewController:zbarReaderVC animated:YES completion:nil];
    
}

//二维码扫描成功会自动调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //扫描二维码的结果
    id<NSFastEnumeration> results = info[ZBarReaderControllerResults];
    
    for (ZBarSymbol *symbol in results)
    {
        //获取结果
        NSString *result = symbol.data;
        
        //防止中文乱码
        result = [[NSString alloc] initWithCString:[result cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        
        NSLog(@"=====:%@",result);
        
        break;
    }
}

#pragma mark -ZBarReaderViewDelegate
- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image
{
    for (ZBarSymbol *symbol in symbols)
    {
        //获取结果
        NSString *result = symbol.data;
        
        //防止中文乱码
        result = [[NSString alloc] initWithCString:[result cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        
        NSLog(@"=====:%@",result);
        
        break;
    }
}


//二维码生成
- (IBAction)createZBarButtonClick:(id)sender
{
    DDLCreateZbarImageViewController *creatZbarImageVC = [[DDLCreateZbarImageViewController alloc] init];
    [self.navigationController pushViewController:creatZbarImageVC animated:YES];
}
@end
