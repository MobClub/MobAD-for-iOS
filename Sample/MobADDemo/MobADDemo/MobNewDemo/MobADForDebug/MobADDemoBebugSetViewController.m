//
//  MobADDemoBebugSetViewController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/13.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADDemoBebugSetViewController.h"
#import "MobADSetDebugTableViewCell.h"
#import "MobADAboutViewController.h"
#import <MobAD/MobAD+Private.h>
#import "HUDManager.h"
#import "MobADDeviceAlertView.h"

static NSString *const DebugCell = @"MobADSetDebugTableViewCell";

@interface MobADDemoBebugSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray<NSArray *> *listArray;

@property (copy, nonatomic) NSArray *apiArray;

@property (copy,nonatomic) NSArray *debugApiArray;

@property (assign, nonatomic) BOOL isDebug;

@property (strong, nonatomic) NSString *bundleID;

@property (strong, nonatomic) NSString *appkey;

@property (strong, nonatomic) MobADDeviceAlertView *idfaView;

@property (strong, nonatomic) UIView *backGrayView;


@end

@implementation MobADDemoBebugSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MOB_RGB(250, 250, 250);
    UIBarButtonItem *updateBtn = [[UIBarButtonItem alloc] initWithTitle:@"更新配置" style:UIBarButtonItemStylePlain target:self action:@selector(updateConfig)];
    self.navigationItem.rightBarButtonItem = updateBtn;
    [self.navigationItem.rightBarButtonItem setTintColor:MOB_RGB(0, 154, 158)];
    self.isDebug = NO;
    self.bundleID = [FCMNApplication bundleId];
    self.appkey = [FcmnSDK appKey];
    
    self.listArray = @[@[@"使用测试地址"],@[@"请求地址",@"AppKey",@"包名"],@[@"关于MobAD",@"设备标识别"]];
    self.apiArray = @[@"http://m.adnet.mob.com/client/req_ad/v2",[FcmnSDK appKey],[FCMNApplication bundleId]];
    self.debugApiArray = @[@"http://m.adnet.test.mob.com/client/req_ad/v2",[FcmnSDK appKey],[FCMNApplication bundleId]];
    
    [self.view addSubview:self.tableView];
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

-(MobADDeviceAlertView *)idfaView
{
    if(!_idfaView)
    {
        _idfaView = [[MobADDeviceAlertView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, ScreenWidth, 160 + BottomMargin)];
        __weak __typeof(&*self)weakSelf = self;
        _idfaView.dismissBlock = ^{
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.idfaView.frame = CGRectMake(0, weakSelf.view.frame.size.height, ScreenWidth, 160 + BottomMargin);
            } completion:^(BOOL finished) {
                [weakSelf.idfaView removeFromSuperview];
                [weakSelf.backGrayView removeFromSuperview];
            }];
        };
        _idfaView.copyBlock = ^{
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            NSLog(@"%@",pasteboard.string);
            [HUDManager showTextHud:@"复制成功"];
        };
    }
    return _idfaView;
}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MOB_RGB(250, 250, 250);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:DebugCell bundle:nil] forCellReuseIdentifier:DebugCell];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10.f)];
    view.backgroundColor = MOB_RGB(250, 250, 250);

    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *cellArray = self.listArray[section];
    return cellArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MobADSetDebugTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DebugCell];
    NSArray *cellArray = self.listArray[indexPath.section];
    cell.titleLabel.text = cellArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.section == 0)
    {
        [cell setCellStyleSwitch];
        cell.switchBlock = ^(BOOL isOn) {
            NSLog(@"%d",isOn);
            self.isDebug = isOn;
            [self.tableView reloadData];
        };
    }
    if(indexPath.section == 1)
    {
        if(self.isDebug)
        {
            cell.apiTextField.text = self.debugApiArray[indexPath.row];
        }else
        {
            cell.apiTextField.text = self.apiArray[indexPath.row];
        }
        cell.getConfigBlock = ^(NSString * _Nonnull config) {
            if(indexPath.row == 1)
            {
                self.appkey = config;
            }
            if(indexPath.row == 2)
            {
                self.bundleID = config;
            }
        };
        [cell setCellStyleTextField];
    }
    if(indexPath.section == 2)
    {
        [cell setCellStyleNormal];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        if(indexPath.row == 0)
        {
            self.hidesBottomBarWhenPushed = YES;
            MobADAboutViewController *aboutVc = [[MobADAboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        if(indexPath.row == 1)
        {
            [self.tabBarController.view addSubview:self.backGrayView];
            [self.tabBarController.view addSubview:self.idfaView];
            [UIView animateWithDuration:0.3f animations:^{
                self.idfaView.frame = CGRectMake(0, self.view.frame.size.height - 160 - BottomMargin, ScreenWidth, 160 + BottomMargin);
            }];
        }
    }
}

-(void)updateConfig
{
    [HUDManager showLoading];
    [MobAD useDebugAPI:self.isDebug];
    [MobAD setBundleId:self.bundleID];
    [FcmnSDK registerAppKey:self.appkey appSecret:@"c7ce1d041b0ccf5e80dbac2f54e99d18"];
    NSLog(@"---> after register: %@", [FcmnSDK appKey]);
    [MobAD updateLocalConfigWithAppkey:[FcmnSDK appKey] onComplete:^(NSDictionary *configDict, NSError *error) {
        [HUDManager hidenHud];
        if(error)
        {
            [HUDManager showTextHud:error.localizedDescription];
        }else
        {
            [HUDManager showTextHud:@"更新配置成功!"];
        }
    }];
    
}



@end
