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
@property (nonatomic, strong) UITextField *pidField;

@end

@implementation MADInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Interstitial广告";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *pidLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height * 0.4 - 30, 0, 0)];
    pidLabel.text = @"广告位ID:";
    pidLabel.textColor = [UIColor blackColor];
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

- (void)_processState:(MADState)state error:(NSError *)error
{
    DebugLog(@"=====> %lu", (unsigned long)state);
    switch (state) {
        case MADStateDidReceived:
            DebugLog(@"MADStateDidReceived");
            break;
        case MADStateFailReceived:
            DebugLog(@"MADStateFailReceived:%@",error);
            _refreshbutton.enabled = YES;
            [self _showErrorAlert:error];
            break;
        case MADStateAdViewRenderSuccess:
            DebugLog(@"MADStateAdViewRenderSuccess");
            break;
        case MADStateWillPresent:
        case MADStateDidPresent:
        case MADStateWillExposured:
            DebugLog(@"MADStateWillPresent / MADStateDidPresent / MADStateWillExposured");
            _refreshbutton.enabled = YES;
            break;
        case MADStateDidClosed:
        case MADStateDidDismiss:
            DebugLog(@"MADStateDidClosed / MADStateDidDismiss");
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
