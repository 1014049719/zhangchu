//
//  DDLSharkViewController.m
//  CookerProject
//
//  Created by vera on 15-1-29.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLSharkViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "DDLUrl.h"
#import <AVFoundation/AVFoundation.h>

@interface DDLSharkViewController ()
{
    //音频播放
    AVAudioPlayer *player;
}

@end

@implementation DDLSharkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"yao.mp3" ofType:nil];
    
    //初始化播放器
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    player.numberOfLoops = 10;
    
    //启动摇动功能
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"摇一摇开始");
    
    [player prepareToPlay];
    [player play];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"摇一摇结束");
    
    //请求数据
    [self requestDataFromNetWork];
}

- (void)requestDataFromNetWork
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:FoodShakeRandom_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *array = responseObject[@"data"];
        NSDictionary *dic = array[0];
        
        //赋值
        self.chNameLabel.text = dic[@"name"];
        self.enNameLabel.text = dic[@"englishName"];
        [self.foodImageView setImageWithURL:[NSURL URLWithString:dic[@"imagePathLandscape"]]];
        
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
