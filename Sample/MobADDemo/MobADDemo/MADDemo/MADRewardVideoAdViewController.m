//
//  MADRewardVideoAdViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/11/25.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MADRewardVideoAdViewController.h"
#import <MobAD/MobAD.h>
#import "MobADNormalButton.h"
#import "Const.h"
#import "HUDManager.h"

@interface MADRewardVideoAdViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) MobADNormalButton *refreshbutton;

@property (nonatomic, strong) MobADNormalButton *loadDataButton;

@property (nonatomic, strong) UITextField *pidField;

@property (nonatomic, strong) MBProgressHUD *hudView;

@property (nonatomic, strong) id rewardAD;


@end

@implementation MADRewardVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"激励视频广告";
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.view.backgroundColor = [UIColor darkGrayColor];
        }
    }
    
    UILabel *pidLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height * 0.4 - 30, 0, 0)];
    pidLabel.text = @"广告位ID:";
    pidLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            pidLabel.textColor = [UIColor whiteColor];
        }
    }
    pidLabel.textAlignment = NSTextAlignmentLeft;
    [pidLabel sizeToFit];
    [self.view addSubview:pidLabel];
    
    UITextField *pidField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pidLabel.frame) + 5, [UIScreen mainScreen].bounds.size.height * 0.4 - 34 , self.view.bounds.size.width - CGRectGetMaxX(pidLabel.frame) - 30, 30)];
    self.pidField = pidField;
    pidField.returnKeyType = UIReturnKeyDone;
    pidField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    pidField.borderStyle = UITextBorderStyleRoundedRect;
    pidField.placeholder = @"请输入广告位ID...";
    pidField.text = kSRewardVideoPID;
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            pidField.backgroundColor = [UIColor whiteColor];
        }
    }
    pidField.textColor = [UIColor blackColor];
    pidField.delegate = self;
    [self.view addSubview:pidField];
    
    //refresh Button
    CGSize size = [UIScreen mainScreen].bounds.size;
//    _loadDataButton = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, size.height * 0.5, 0, 0)];
//    _loadDataButton.showRefreshIncon = YES;
//    [_loadDataButton setTitle:@"缓存激励视频数据" forState:UIControlStateNormal];
//    [_loadDataButton addTarget:self action:@selector(loadRewardData) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_loadDataButton];
    
    
    _refreshbutton = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, size.height * 0.5 + 60, 0, 0)];
    _refreshbutton.showRefreshIncon = YES;
    [_refreshbutton setTitle:@"展示激励视频广告" forState:UIControlStateNormal];
    [_refreshbutton addTarget:self action:@selector(showRewardVideoAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshbutton];
    
}

//-(void)loadRewardData
//{
//    [HUDManager showLoading];
//
//    _refreshbutton.enabled = NO;
//    __weak typeof(self) weakSelf = self;
//
//    [MobAD showRewardVideoAdWithPlacementId:self.pidField.text.length > 0 ? self.pidField.text : kSRewardVideoPID viewController:self eCPMCallback:^(NSInteger eCPM) {
//
//    } stateCallback:^(id adObject, MADState state, NSError *error) {
//
//    }];
//
//    [MobAD loadRewardVideoDataWithPlacementId:self.pidField.text.length > 0 ? self.pidField.text : kSRewardVideoPID stateCallback:^(id adObject, MADState state, NSError *error) {
//        NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
//        weakSelf.refreshbutton.enabled = YES;
//        if (error) {
//            [HUDManager showStateHud:error.localizedDescription state:HUDStateTypeFail afterDelay:1.5f];
////            [weakSelf _showErrorAlert:error];
//        }
//        //激励视频缓存成功
//        if(state == MADStateVideoDidLoad)
//        {
//            [HUDManager showStateHud:@"缓存成功！" state:HUDStateTypeSuccess afterDelay:1.5f];
//            self.rewardAD = adObject;
//        }
//        if(state == MADStateFailLoad)
//        {
//           [HUDManager showStateHud:@"缓存失败!" state:HUDStateTypeFail afterDelay:1.5f];
//        }
//    }];
//}


- (void)showRewardVideoAd
{
    [HUDManager showLoading];
    _refreshbutton.enabled = NO;
    __weak typeof(self) weakSelf = self;
    
    [MobAD showRewardVideoAdWithPlacementId:self.pidField.text.length > 0 ? self.pidField.text : kSRewardVideoPID viewController:self eCPMCallback:^(NSInteger eCPM) {
        NSLog(@"---> eCPM: %ldd", (long)eCPM);

    } stateCallback:^(id adObject, MADState state, NSError *error) {
        [HUDManager hidenHud];
               NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
               weakSelf.refreshbutton.enabled = YES;
               if (error) {
                   [weakSelf _showErrorAlert:error];
               }
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - private

- (void)_showErrorAlert:(NSError *)error
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"错误信息" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:alertOKAction];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)dealloc
{
    DebugLog(@"---- MADRewardVideoAdViewController ---- %s", __func__);
}


@end
