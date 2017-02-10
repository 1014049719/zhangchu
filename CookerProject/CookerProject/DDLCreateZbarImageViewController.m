//
//  DDLCreateZbarImageViewController.m
//  CookerProject
//
//  Created by vera on 15-2-2.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLCreateZbarImageViewController.h"
#import "QRCodeGenerator.h"

@interface DDLCreateZbarImageViewController ()

@end

@implementation DDLCreateZbarImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //二维码对象
    UIImage *image = [QRCodeGenerator qrImageForString:@"http://www.baidu.com" imageSize:300];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, 300, 300)];
    imageView.image = image;
    [self.view addSubview:imageView];
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
