//
//  MobADSettingViewController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/11.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADSettingViewController.h"
#import "MobADSetTableViewCell.h"
#import "MobADAboutViewController.h"
#import "MobADDeviceAlertView.h"
#import "HUDManager.h"

@interface MobADSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIImageView *mainCoinImgView;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *titleArray;

@property (strong, nonatomic) NSArray *iconArray;

//@property (strong, nonatomic) MobADDeviceAlertView *idfaView;

//@property (strong, nonatomic) UIView *backGrayView;

@end

@implementation MobADSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MOB_RGB(250, 250, 250);
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.titleArray = @[@"关于MobAD"];
    self.iconArray = @[@"icon_details"];
    [self.view addSubview:self.mainCoinImgView];
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.idfaView];
}

-(UIImageView *)mainCoinImgView
{
    if(!_mainCoinImgView)
    {
        _mainCoinImgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 40.f , 40+ NavigationBarHeight, 80, 80)];
        _mainCoinImgView.image = [UIImage imageNamed:@"avatar_default"];
    }
    return _mainCoinImgView;
}

//-(MobADDeviceAlertView *)idfaView
//{
//    if(!_idfaView)
//    {
//        _idfaView = [[MobADDeviceAlertView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, ScreenWidth, 160 + BottomMargin)];
//        __weak __typeof(&*self)weakSelf = self;
//        _idfaView.dismissBlock = ^{
//            [UIView animateWithDuration:0.3 animations:^{
//                weakSelf.idfaView.frame = CGRectMake(0, weakSelf.view.frame.size.height, ScreenWidth, 160 + BottomMargin);
//            } completion:^(BOOL finished) {
//                [weakSelf.idfaView removeFromSuperview];
//                [weakSelf.backGrayView removeFromSuperview];
//            }];
//        };
//        _idfaView.copyBlock = ^{
//            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//            NSLog(@"%@",pasteboard.string);
//            [HUDManager showTextHud:@"复制成功"];
//        };
//    }
//    return _idfaView;
//}

//-(UIView *)backGrayView
//{
//    if(!_backGrayView)
//    {
//        _backGrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//        _backGrayView.backgroundColor = [UIColor blackColor];
//        _backGrayView.alpha = 0.3f;
//    }
//    return _backGrayView;
//}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 165+NavigationBarHeight, ScreenWidth, self.view.frame.size.height - 165 - NavigationBarHeight)];
        _tableView.backgroundColor = MOB_RGB(250, 250, 250);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"MobADSetTableViewCell" bundle:nil] forCellReuseIdentifier:@"MobADSetTableViewCell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentify = @"MobADSetTableViewCell";
    MobADSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    cell.iconImgView.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        self.hidesBottomBarWhenPushed=YES;
        MobADAboutViewController *aboutVC = [[MobADAboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
//    if(indexPath.row == 1)
//    {
//        [self.tabBarController.view addSubview:self.backGrayView];
//        [self.tabBarController.view addSubview:self.idfaView];
//        [UIView animateWithDuration:0.3f animations:^{
//            self.idfaView.frame = CGRectMake(0, self.view.frame.size.height - 160 - BottomMargin, ScreenWidth, 160 + BottomMargin);
//        }];
//    }
}



@end
