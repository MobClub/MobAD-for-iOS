//
//  MobADRewardVideoAdViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/5.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MobADRewardVideoAdViewController.h"
#import <MobAD/MobAD.h>
#import "MobADNormalButton.h"
#import "Const.h"

@interface MobADRewardVideoAdViewController ()

@property (nonatomic, strong) MBADRewardVideoAd *rewardedVideoAd;

@property (nonatomic, strong) MobADNormalButton *refreshbutton;

@end

@implementation MobADRewardVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"激励视频广告";
    self.view.backgroundColor = [UIColor whiteColor];
    
    MBADRewardedVideoModel *rewardedVideoModel = [[MBADRewardedVideoModel alloc] init];
    rewardedVideoModel.userId = @"123";
    self.rewardedVideoAd = [[MBADRewardVideoAd alloc] initWithSlotID:kBRewardVideoSlotID rewardedVideoModel:rewardedVideoModel];
    __weak typeof(self) weakSelf = self;
    self.rewardedVideoAd.stateChanged = ^(MBADState state, MBADInteractionType interactionType, NSError *error) {
        [weakSelf _processBUDState:state error:error interactionType:interactionType];
    };
    [self.rewardedVideoAd loadAdData];
    
    [self.view addSubview:self.refreshbutton];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.refreshbutton.center = CGPointMake(self.view.center.x, self.view.center.y*1.5);
}


- (void)_processBUDState:(MBADState)state error:(NSError *)error interactionType:(MBADInteractionType)interactionType
{
    switch (state) {
        case MBADStateDidLoad:
            DebugLog(@"MBADStateDidLoad");
            _refreshbutton.enabled = YES;
            break;
        case MBADStateDidLoadFailed:
            DebugLog(@"MBADStateDidLoadFailed:%@",error);
            [self _showErrorAlert:error];
            break;
        case MBADStateVideoDataDidLoad:
            DebugLog(@"MBADStateVideoDataDidLoad");
            break;
        case MBADStateWillVisible:
            DebugLog(@"MBADStateWillVisible");
            break;
        case MBADStateDidVisible:
            DebugLog(@"MBADStateDidVisible");
            break;
        case MBADStateDidClick:
            DebugLog(@"MBADStateDidClick");
            break;
        case MBADStateWillClose:
            DebugLog(@"MBADStateWillClose");
            break;
        case MBADStateDidClose:
            DebugLog(@"MBADStateDidClose");
            break;
        case MBADStateVideoDidPlayFinish:
            DebugLog(@"MBADStateVideoDidPlayFinish");
            break;
        case MBADStateServerRewardDidSucceed:
            DebugLog(@"MBADStateServerRewardDidSucceed");
            break;
        case MBADStateServerRewardDidFail:
            DebugLog(@"MBADStateServerRewardDidFail");
            break;
        case MBADStateDidClickSkip:
            DebugLog(@"MBADStateDidClickSkip");
            break;
            
        default:
            break;
    }
}

- (void)buttonTapped:(id)sender {
    /**Return YES when material is effective,data is not empty and has not been displayed.
     Repeated display is not charged.
     */
    [self.rewardedVideoAd showAdFromRootViewController:self.navigationController ritScene:MBADRitSceneType_home_get_bonus ritSceneDescribe:nil];
}


- (MobADNormalButton *)refreshbutton
{
    if (!_refreshbutton) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _refreshbutton = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
        _refreshbutton.enabled = NO;
        [_refreshbutton setTitle:@"展示激励视频广告" forState:UIControlStateNormal];
        [_refreshbutton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshbutton;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
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
    DebugLog(@"%s", __func__);
}

@end
