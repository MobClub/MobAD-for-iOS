//
//  MADBannerViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/16.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MADBannerViewController.h"
#import <MobAD/MobAD.h>
#import "MobADNormalButton.h"
#import "Const.h"

@interface MADBannerViewController () <UITextFieldDelegate>

@property (nonatomic, strong) MobADNormalButton *refreshbutton;
@property (nonatomic, strong) UITextField *pidField;
@property (nonatomic, strong) UITextField *timeField;

@property (nonatomic, weak) id bannerAdView;

@end

@implementation MADBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Banner广告";
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
    pidField.text = kSBannerPID;
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            pidField.backgroundColor = [UIColor whiteColor];
        }
    }
    pidField.textColor = [UIColor blackColor];
    pidField.delegate = self;
    [self.view addSubview:pidField];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height * 0.4 + 20, 0, 0)];
    timeLabel.text = @"刷新时长（30～120）:";
    timeLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            timeLabel.textColor = [UIColor whiteColor];
        }
    }
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [timeLabel sizeToFit];
    [self.view addSubview:timeLabel];
    
    UITextField *timeField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame) + 5, [UIScreen mainScreen].bounds.size.height * 0.4 + 14 , self.view.bounds.size.width - CGRectGetMaxX(timeLabel.frame) - 30, 30)];
    self.timeField = timeField;
    timeField.returnKeyType = UIReturnKeyDone;
    timeField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    timeField.borderStyle = UITextBorderStyleRoundedRect;
    timeField.placeholder = @"请输入轮播刷新间隔时间...";
    timeField.text = @"30";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            timeField.backgroundColor = [UIColor whiteColor];
        }
    }
    timeField.textColor = [UIColor blackColor];
    timeField.delegate = self;
    [self.view addSubview:timeField];
    
    
    //refresh Button
    CGSize size = [UIScreen mainScreen].bounds.size;
    _refreshbutton = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, size.height * 0.4 + 60, 0, 0)];
    _refreshbutton.showRefreshIncon = YES;
    [_refreshbutton setTitle:@"展示Banner" forState:UIControlStateNormal];
    [_refreshbutton addTarget:self action:@selector(refreshBanner) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshbutton];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // banner广告父View即将消失时需要关闭banner广告,否则该控制器无法释放
    [MobAD dismissBannerAd:self.bannerAdView];
}

-  (void)refreshBanner {
    if(self.bannerAdView)
    {
        [MobAD dismissBannerAd:self.bannerAdView];
    }
    _refreshbutton.enabled = NO;
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat bannerHeigh = screenWidth / 500 * 100;
    __weak typeof(self) weakSelf = self;
    
    NSInteger time = 0;
    if([self isPureInteger:self.timeField.text])
    {
        time = [self.timeField.text integerValue];
    }
    [MobAD showBannerAdWithPlacementId:self.pidField.text
                                onView:weakSelf.view
                        viewController:weakSelf
                                 frame:CGRectMake(0, 100, screenWidth, bannerHeigh)
                              interval:time
                          stateChanged:^(id adObject, MADState state, NSError *error) {
                              weakSelf.bannerAdView = adObject;
                              [weakSelf _processState:state error:error];
                        if(state == MADStateDidLoad)
                        {
                            weakSelf.refreshbutton.enabled = YES;
                        }
                            if(state == MADStateWillClose)
                            {
                                [MobAD dismissBannerAd:weakSelf.bannerAdView];
                            }
                          }
                       dislikeCallback:^(id adObject, NSArray<NSString *> *reasons) {
                           DebugLog(@"%@",[reasons componentsJoinedByString:@","]);
                           weakSelf.refreshbutton.enabled = YES;
                       }];
}

//判断字符串是否为浮点数
- (BOOL)isPureInteger:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    NSInteger val;
    return[scan scanInteger:&val] && [scan isAtEnd];
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
            [self _showErrorAlert:error];
            break;
        case MADStateViewRenderSuccess:
            DebugLog(@"MADStateViewRenderSuccess");
            _refreshbutton.enabled = YES;
            break;
        case MADStateWillExposure:
        case MADStateWillPresentScreen:
            DebugLog(@"MADStateWillExposure / MADStateWillPresentScreen");
            _refreshbutton.enabled = YES;
            break;
        case MADStateWillClose:
            DebugLog(@"MADStateWillClosed");
            _refreshbutton.enabled = YES;
            break;
        case MADStateDidClick:
            DebugLog(@"MADStateDidClick");
            _refreshbutton.enabled = YES;
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
    DebugLog(@"---- MADBannerViewController ---- %s", __func__);
}

@end
