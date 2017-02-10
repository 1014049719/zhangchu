//
//  DDLMaterialCollectionViewController.m
//  CookerProject
//
//  Created by vera on 15-1-27.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "DDLMaterialCollectionViewController.h"
#import "DDLMaterialCollectionReusableView.h"
#import "DDLUtility.h"
#import "AFNetworking.h"
#import "DDLUrl.h"
#import "DDLMaterial.h"
#import "UIImageView+AFNetworking.h"
#import "DDLMaterialCollectionViewCell.h"

@interface DDLMaterialCollectionViewController ()
{
    DDLMaterial *material;
}

@end

@implementation DDLMaterialCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DDLMaterialCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DDLMaterialCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadView"];
    
    // Do any additional setup after loading the view.
    
    //请求数据
    [self requestMaterialData];
    
}
     
- (void)requestMaterialData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:FoodDetail_Material_url,_food.vegetableId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSArray *array = responseObject[@"data"];
         
         material = [[DDLMaterial alloc] init];
         
         if (array.count > 0)
         {
             NSDictionary *dic = array[0];
             material.materialId = dic[@"materialId"];
             material.materialName = dic[@"materialName"];
             material.imagePath = dic[@"imagePath"];
             
             NSInteger count = array.count;
             
             for (NSDictionary *d in array[count - 1][@"TblSeasoning"])
             {
                 DDLMaterial *material2 = [[DDLMaterial alloc] init];
                 material2.imagePath = d[@"imagePath"];
                 material2.materialName = d[@"name"];
                 
                 [material.flavourArray addObject:material2];
             }
         }
         
         //刷新
         [self.collectionView reloadData];
         
        
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    
    return material.flavourArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDLMaterialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
 
    if (indexPath.section == 0)
    {
        cell.nameLabel.hidden = YES;
        
        [cell.pictureImageView setImageWithURL:[NSURL URLWithString:material.imagePath]];
        cell.nameLabel.text = @"";
        
    }
    else
    {
        cell.nameLabel.hidden = NO;
        
        DDLMaterial *mater = material.flavourArray[indexPath.item];
        
        
        [cell.pictureImageView setImageWithURL:[NSURL URLWithString:mater.imagePath]];
        cell.nameLabel.text = mater.materialName;
    }
    

    return cell;
}

//段头高度和宽度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    NSString *text = nil;
    
    if (section == 0)
    {
        text = _food.material;
    }
    else
    {
        text = _food.flavour;
    }
    
    //计算高度
    CGSize size = [DDLUtility getTextSizeWithText:text font:[UIFont systemFontOfSize:15] width:220];
    NSLog(@"%f",size.height);
    

    return CGSizeMake(280, size.height + 28);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    DDLMaterialCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadView" forIndexPath:indexPath];
    
    NSString *text = nil;
    NSString *title = nil;
    
    if (indexPath.section == 0)
    {
        text = _food.material;
        title = @"原料";
    }
    else
    {
        text = _food.flavour;
        title = @"调料";
    }
    
    //计算高度
    CGSize size = [DDLUtility getTextSizeWithText:text font:[UIFont systemFontOfSize:15] width:220];
    
    //修改materialLabel的高度
    CGRect frame = reusableView.materialLabel.frame;
    frame.size.height = size.height;
    reusableView.materialLabel.frame = frame;
    
    reusableView.materialLabel.text = text;
    reusableView.titleLabel.text = title;
    
    return reusableView;
}

#pragma mark <UICollectionViewDelegate>



/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
