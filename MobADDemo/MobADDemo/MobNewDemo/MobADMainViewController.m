//
//  MobADMainViewController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/11.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADMainViewController.h"
#import "MobADMainCollectionViewCell.h"
#import "MobADSplashViewController.h"
#import "MobADInterstitalViewController.h"
#import "MobADBannerViewController.h"
#import "MobADRewardViewController.h"
#import "MobADNativeViewController.h"
#import "MobADNativeExpressViewController.h"
#import "MobADPrivacyView.h"
#import <MobAD/MobAD.h>

@interface MobADMainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *adCollectionView;

@property (copy, nonatomic) NSArray *adTitleArray;

@property (copy, nonatomic) NSArray *adIconArray;

@property (assign, nonatomic) NSInteger selectCellIndex;

@property (strong, nonatomic) MobADPrivacyView *privacyView;

@property (strong, nonatomic) UIView *backGrayView;

@end

@implementation MobADMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

    self.adTitleArray = @[@"开屏",@"插屏",@"横幅",@"原生",@"激励视频",@"自渲染"];
    self.adIconArray = @[@"ad_icon_splash_nor",@"ad_icon_chaping_nor",@"ad_icon_banner_nor",@"ad_icon_native_nor",@"ad_icon_video_nor",@"ad_icon_rendering_nor"];
    self.selectCellIndex = 0;
    [self.view addSubview:self.adCollectionView];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(![MobAD privacyStatus])
      {
          [self showPrivacy];
      }
}

-(void)showPrivacy
{
    [MobAD getPrivacyCompletion:^(NSDictionary * _Nonnull data) {
        NSString *privacyURL = data[@"url2"];
        [self.privacyView loadWebViewWithURL:[NSURL URLWithString:privacyURL]];
        [UIView animateWithDuration:0.3f animations:^{
            [self.tabBarController.view addSubview:self.backGrayView];
            [self.tabBarController.view addSubview:self.privacyView];
            self.privacyView.frame = CGRectMake(20, 55, ScreenWidth - 40, ScreenHeight - 110);
        }];
    }];
}

-(UICollectionView *)adCollectionView
{
    if(!_adCollectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _adCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
        _adCollectionView.backgroundColor = MOB_RGB(250, 250, 250);
        _adCollectionView.delegate = self;
        _adCollectionView.dataSource = self;
        [_adCollectionView registerNib:[UINib nibWithNibName:@"MobADMainCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MobADMainCollectionViewCell"];
        
    }
    return _adCollectionView;
}

-(MobADPrivacyView *)privacyView
{
    if(!_privacyView)
    {
        _privacyView = [[MobADPrivacyView alloc] initWithFrame:CGRectMake(20, ScreenHeight, ScreenWidth - 40, ScreenHeight - 110)];
         __weak __typeof(&*self)weakSelf = self;
        _privacyView.clickBlock = ^(BOOL isAgree) {
            [MobAD uploadPrivacyStatus:isAgree onResult:^(BOOL success) {
                
            }];
            [UIView animateWithDuration:0.3f animations:^{
                weakSelf.privacyView.frame = CGRectMake(20, ScreenHeight, ScreenWidth - 40, ScreenHeight - 110);
            } completion:^(BOOL finished) {
                [weakSelf.privacyView removeFromSuperview];
                [weakSelf.backGrayView removeFromSuperview];
            }];
        };
    }
    return _privacyView;
}

-(UIView *)backGrayView
{
    if(!_backGrayView)
    {
        _backGrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _backGrayView.backgroundColor = [UIColor blackColor];
        _backGrayView.alpha = 0.3f;
    }
    return _backGrayView;
}
#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.adTitleArray.count;
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"MobADMainCollectionViewCell";
    MobADMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.adTitleLabel.text = self.adTitleArray[indexPath.row];
    cell.adIconImageView.image = [UIImage imageNamed:self.adIconArray[indexPath.row]];
    cell.backImgView.image = [UIImage imageNamed:@"ad_bg_nor"];
    cell.adTitleLabel.textColor = [UIColor blackColor];
    if(self.selectCellIndex == indexPath.row)
    {
        [cell setSelectBackImageViewWithIndex:indexPath.row];
    }
    return cell;
}



#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake((ScreenWidth - 60.f) /2,(ScreenWidth - 60.f) /2);
}

#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);//（上、左、下、右）
}


#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectCellIndex = indexPath.row;
    [self.adCollectionView reloadData];
    if(indexPath.row == 0)
    {
        MobADSplashViewController *vc = [[MobADSplashViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.row == 1)
    {
        self.hidesBottomBarWhenPushed = YES;
        MobADInterstitalViewController *vc = [[MobADInterstitalViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if(indexPath.row == 2)
    {
        self.hidesBottomBarWhenPushed = YES;
        MobADBannerViewController *vc = [[MobADBannerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if(indexPath.row == 3)
    {
        self.hidesBottomBarWhenPushed = YES;
        MobADNativeExpressViewController *vc = [[MobADNativeExpressViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if(indexPath.row == 4)
    {
        self.hidesBottomBarWhenPushed = YES;
        MobADRewardViewController *vc = [[MobADRewardViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if(indexPath.row == 5)
    {
        self.hidesBottomBarWhenPushed = YES;
        MobADNativeViewController *vc = [[MobADNativeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
