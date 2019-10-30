//
//  NativeExpressInterstitialAdViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/7.
//  Copyright © 2019 Max. All rights reserved.
//

#import "NativeExpressInterstitialAdViewController.h"
#import <MobAD/MobAD.h>
#import "MobADNormalButton.h"
#import "Const.h"

@interface NativeExpressInterstitialAdViewController ()

@property (nonatomic, strong) MobADNormalButton *button;

@end

@implementation NativeExpressInterstitialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个性化插屏广告";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.button = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
    self.button.showRefreshIncon = YES;
    [self.button setTitle:@"展示插屏" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y*1.5);
}

- (void)buttonTapped:(UIButton *)sender {
    sender.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [[MBADConnector defaultConnector] showNativeExpressInterstitialAdWithSlotId:kBNativeExpressInterstitialSlotID
                                                                 viewController:self
                                                                        imgSize:[MBADSize sizeBy:MBADProposalSize_Interstitial600_900]
                                                                         adSize:CGSizeMake(ScreenWidth * 0.8, ScreenHeight * 0.7)
                                                                   stateChanged:^(MBADState state, MBADInteractionType interactionType, NSError *error) {
                                                                       [weakSelf _processBUDState:state error:error interactionType:interactionType];
                                                                   }];
}

- (void)_processBUDState:(MBADState)state error:(NSError *)error interactionType:(MBADInteractionType)interactionType
{
    switch (state) {
        case MBADStateDidLoad:
            DebugLog(@"MBADStateDidLoad");
            break;
        case MBADStateDidLoadFailed:
            DebugLog(@"MBADStateDidLoadFailed:%@",error);
            self.button.enabled = YES;
            [self _showErrorAlert:error];
            break;
        case MBADStateViewRenderSuccess:
            DebugLog(@"MBADStateViewRenderSuccess");
            break;
        case MBADStateViewRenderFail:
            DebugLog(@"MBADStateViewRenderFail");
            break;
        case MBADStateWillVisible:
            DebugLog(@"MBADStateWillVisible");
            break;
        case MBADStateDidClick:
            DebugLog(@"MBADStateDidClick");
            break;
        case MBADStateWillClose:
            DebugLog(@"MBADStateWillClose");
            break;
        case MBADStateDidClose:
            DebugLog(@"MBADStateDidClose");
            self.button.enabled = YES;
            break;
            
        default:
            break;
    }
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
    DebugLog(@"---- NativeExpressInterstitialAdViewController ---- %s", __func__);
}

@end
