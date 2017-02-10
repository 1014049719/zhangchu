//
//  DDLSearchViewController.m
//  CookerProject
//
//  Created by vera on 15-1-30.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLSearchViewController.h"
#import "DDLSearchTableViewCell.h"
#import "DDLFood.h"
#import "DDLDeleteButton.h"

@interface DDLSearchViewController ()<UITableViewDataSource,UITableViewDelegate,DDLSearchTableViewCellDelegate,DDLDeleteButtonDelegate>
{
    UIImageView *searchHeadView;
    
    //title
    NSArray * sectionTitles;
    //图片名字
    NSArray *classifyImageNames;
    //文字
    NSArray *classityTitles;
    
    //选中哪个cell(默认0)
    NSInteger selectRow;
    
    //记录选中的分类
    NSMutableArray *selectClassifyArray;
    
    UITableView *classifyTableView;
    
    
}

@end

@implementation DDLSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    selectClassifyArray = [NSMutableArray array];
    
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景图"]];
    
    //tabviewCell每行文字
    sectionTitles = @[@"中华菜系",@"口味分类",@"人群分类",@"烹饪分类",@"功效分类"];
    
    classifyImageNames = @[
                           @[@"菜系-川菜",@"菜系-湘菜",@"菜系-粤菜",@"菜系-鲁菜",@"菜系-徽菜",@"菜系-闽菜",@"菜系-浙菜",@"菜系-苏菜",@"菜系-其它菜系"],
                           @[@"口味-苦",@"口味-辣",@"口味-酸",@"口味-甜",@"口味-咸",@"口味-鲜",@"口味-淡"],
                           @[@"人群-婴幼儿",@"人群-儿童",@"人群-女性",@"人群-孕妇",@"人群-产妇",@"人群-男性",@"人群-老年人",@"人群-糖尿病者",@"人群-高血压病者",@"人群-高血脂病者",@"人群-肠胃病者",@"人群-一般人群"],
                           @[@"烹饪-拌",@"烹饪-腌",@"烹饪-卤",@"烹饪-炒",@"烹饪-焖",@"烹饪-蒸",@"烹饪-煎",@"烹饪-炸",@"烹饪-炖",@"烹饪-煮",@"烹饪-烤",@"烹饪-冻",@"烹饪-泡",@"烹饪-榨汁"],
                           @[@"功效-增强免疫",@"功效-提神健脑",@"功效-瘦身排毒",@"功效-美容养颜",@"功效-养心润肺",@"功效-保肝护肾",@"功效-开胃消食",@"功效-益气补血",@"功效-安神助眠",@"功效-降低血压",@"功效-降低血糖",@"功效-降低血脂",@"功效-清热解毒",@"功效-补铁",@"功效-补锌",@"功效-补钙",@"功效-增高助长",@"功效-增长记忆力",@"功效-益智健脑",@"功效-保护视力",@"功效-健脾止泻",@"功效-防癌抗癌"]
                           ];
    
    classityTitles = @[
                       @[@"川菜",@"湘菜",@"粤菜",@"鲁菜",@"徽菜",@"闽菜",@"浙菜",@"苏菜",@"其它菜系"],
                       @[@"苦",@"辣",@"酸",@"甜",@"咸",@"鲜",@"淡"],
                       @[@"婴幼儿",@"儿童",@"女性",@"孕妇",@"产妇",@"男性",@"老年人",@"糖尿病者",@"高血压病者",@"高血脂病者",@"肠胃病者",@"一般人群"],
                       @[@"拌",@"腌",@"卤",@"炒",@"焖",@"蒸",@"煎",@"炸",@"炖",@"煮",@"烤",@"冻",@"泡",@"榨汁"],
                       @[@"增强免疫",@"提神健脑",@"瘦身排毒",@"美容养颜",@"养心润肺",@"保肝护肾",@"开胃消食",@"益气补血",@"安神助眠",@"降低血压",@"降低血糖",@"降低血脂",@"清热解毒",@"补铁",@"补锌",@"补钙",@"增高助长",@"增长记忆力",@"益智健脑",@"保护视力",@"健脾止泻",@"防癌抗癌"]
                       ];
    
    //添加默认值
    for (int i = 0; i < sectionTitles.count; i++)
    {
        [selectClassifyArray addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    
    
    [self initHeaderSearchView];
    
    [self initTableView];
}

- (void)initTableView
{
    classifyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchHeadView.frame)+20, self.view.frame.size.width, self.view.frame.size.height - 64 - CGRectGetMaxY(searchHeadView.frame) - 20)];
    classifyTableView.delegate = self;
    classifyTableView.dataSource = self;
    classifyTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:classifyTableView];
    
    [classifyTableView registerNib:[UINib nibWithNibName:@"DDLSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

- (void)initHeaderSearchView
{
    searchHeadView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"智能选菜-背景上"]];
    searchHeadView.frame = CGRectMake(0, 20, self.view.frame.size.width, 90);
    searchHeadView.userInteractionEnabled = YES;
    [self.view addSubview:searchHeadView];
}

#pragma mark -DDLSearchTableViewCellDelegate
- (void)didSelectIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d == %d",indexPath.section,indexPath.row);
    
    //替换数据
    [selectClassifyArray replaceObjectAtIndex:indexPath.section - 1 withObject:indexPath];
    
    //[classifyTableView reloadData];
    //刷新
    [self refreshDeleteButtons];
}

//刷新
- (void)refreshDeleteButtons
{
    //移除所有按钮
    for (UIView *view in searchHeadView.subviews)
    {
        //只删除按钮
        if ([view isKindOfClass:[DDLDeleteButton class]])
        {
            [view removeFromSuperview];
        }
    }
    
    //列
    int column = 3;
    
    int space = 20;
    int buttonWidth = (searchHeadView.frame.size.width - (column+1)*space)/column;
    int buttonHeight = 25;
    
    
    int i = 0;
    int j = 0;
    
    for (NSIndexPath *indexPath in selectClassifyArray)
    {
        if (indexPath.section > 0 && indexPath.row > 0)
        {
            
            NSArray *titleArr = classityTitles[indexPath.section-1];
            
            //添加按钮
            DDLDeleteButton *button = [[DDLDeleteButton alloc] initWithFrame:CGRectMake(space*((j%3)+1)+buttonWidth*(j%3), 10+(j/3)*(buttonHeight+10), buttonWidth, buttonHeight)];
            [button setDeleteButtonTitle:titleArr[indexPath.row-1]];
            [button setDeleteButtonTitleFont:[UIFont systemFontOfSize:12]];
            button.delegate = self;
            button.tag = i+1;
            [searchHeadView addSubview:button];
            
            j++;
        }
        
        i++;
    }
    
    
}

#pragma mark -DDLDeleteButtonDelegate
- (void)didClickDeleteButton:(DDLDeleteButton *)button
{
    //删除数据源
    [selectClassifyArray replaceObjectAtIndex:button.tag - 1 withObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    //刷新按钮布局
    [self refreshDeleteButtons];
    
    selectRow = button.tag - 1;
    
    //刷新tableView
    [classifyTableView reloadData];
}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sectionTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDLSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.tag = indexPath.row+1;
    cell.delegate = self;
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.clipsToBounds = YES;
    
    cell.titleLabel.text = sectionTitles[indexPath.row];
    
    //选中文字为橙色
    if (selectRow == indexPath.row)
    {
        cell.titleLabel.textColor = [UIColor orangeColor];
    }
    else
    {
        cell.titleLabel.textColor = [UIColor blackColor];
    }
    
    NSArray *images;
    NSArray *titles;
    
    
    
    if (indexPath.row >= 2)
    {
        titles = classityTitles[indexPath.row];
    }
   
    
    images = classifyImageNames[indexPath.row];
    //添加按钮
    [cell addButtonToScrollView:images titles:titles];
    
    
    if (indexPath.row < selectClassifyArray.count)
    {
        NSIndexPath *idxPath= selectClassifyArray[indexPath.row];
        //标记哪个按钮选中
        [cell markButtonStatusToSelect:idxPath.row-1];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中高度为120
    if (selectRow == indexPath.row)
    {
        return 120;
    }
    
    //没有选中为40
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //记录选中哪行
    selectRow = indexPath.row;
    
    [tableView reloadData];
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
