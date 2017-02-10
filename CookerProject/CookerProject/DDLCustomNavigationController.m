//
//  DDLCustomNavigationController.m
//  CookerProject
//
//  Created by vera on 15-1-20.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLCustomNavigationController.h"

@interface DDLCustomNavigationController ()

@end

@implementation DDLCustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationBar.translucent = NO;
    
    //设置导航条背景图片
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"首页-导航条"] forBarMetrics:UIBarMetricsDefault];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
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
