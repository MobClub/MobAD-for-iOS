//
//  MADInterstitialViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/16.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MADInterstitialViewController.h"
#import <MobAD/MobAD.h>
#import "MobADNormalButton.h"
#import "Const.h"

@interface MADInterstitialViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) MobADNormalButton *refreshbutton;
@property (nonatomic, strong) MobADNormalButton *fullScreenButton;
@property (nonatomic, strong) UITextField *pidField;

@end

@implementation MADInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Interstitial广告";
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
    pidField.text = kSInterstitialPID;
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
    _refreshbutton = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, size.height * 0.4 + 15, 0, 0)];
    _refreshbutton.showRefreshIncon = YES;
    [_refreshbutton setTitle:@"展示Interstitial" forState:UIControlStateNormal];
    [_refreshbutton addTarget:self action:@selector(refreshInterstitial) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshbutton];
    
    
    _fullScreenButton = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, size.height * 0.4 + 85, 0, 0)];
    _fullScreenButton.showRefreshIncon = YES;
    [_fullScreenButton setTitle:@"插屏全屏视频广告" forState:UIControlStateNormal];
    [_fullScreenButton addTarget:self action:@selector(showFullScreenVideoAD) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fullScreenButton];
    
}

-  (void)refreshInterstitial {
    _refreshbutton.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [MobAD showInterstitialAdWithPlacementId:self.pidField.text
                                      onView:self.view
                              viewController:self
                                       frame:CGRectMake(ScreenWidth * 0.1, ScreenWidth * 0.2, ScreenWidth * 0.8, ScreenHeight * 0.6)
                                eCPMCallback:^(NSInteger eCPM) {
                                    NSLog(@"---> eCPM: %ld", (long)eCPM);
                                }
                                stateChanged:^(id adObject, MADState state, NSError *error) {
                                    [weakSelf _processState:state error:error];
                                }];
}

- (void)showFullScreenVideoAD
{
    _fullScreenButton.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [MobAD showInterstitialFullScreenVideoAdWithPlacementId:self.pidField.text viewController:self eCPMCallback:^(NSInteger eCPM) {
        NSLog(@"---> eCPM: %ld", (long)eCPM);
    } stateChanged:^(id adObject, MADState state, NSError *error) {
        [weakSelf _processState:state error:error];
    }];
}

- (void)_processState:(MADState)state error:(NSError *)error
{
    switch (state) {
        case MADStateDidLoad:
            DebugLog(@"MADStateDidReceived");
            break;
        case MADStateFailLoad:
            DebugLog(@"MADStateFailReceived:%@",error);
            _refreshbutton.enabled = YES;
            _fullScreenButton.enabled = YES;
            [self _showErrorAlert:error];
            break;
        case MADStateViewRenderSuccess:
            DebugLog(@"MADStateAdViewRenderSuccess");
            break;
        case MADStateWillPresentScreen:
        case MADStateDidPresentScreen:
        case MADStateWillExposure:
        case MADStateWillVisible:
            DebugLog(@"MADStateWillPresentScreen / MADStateDidPresentScreen / MADStateWillExposure / MADStateWillVisible");
            _refreshbutton.enabled = YES;
            _fullScreenButton.enabled = YES;
            break;
        case MADStateDidClose:
        case MADStateDidDismissScreen:
            DebugLog(@"MADStateDidClosed / MADStateDidDismiss");
            _refreshbutton.enabled = YES;
            _fullScreenButton.enabled = YES;
            break;
        case MADStateDidClick:
            DebugLog(@"MBADStateDidClick");
            break;
        case MADStateWillPresentFullScreenModal:
        case MADStateDidPresentFullScreenModal:
            DebugLog(@"MADStateWillPresentFullScreenModal / MADStateDidPresentFullScreenModal");
            break;
        case MADStateWillDismissFullScreenModal:
        case MADStateDidDismissFullScreenModal:
            DebugLog(@"MADStateWillDismissFullScreenModal / MADStateDidDismissFullScreenModal");
            break;
            
        default:
            break;
    }
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
    DebugLog(@"---- MADInterstitialViewController ---- %s", __func__);
}

@end
