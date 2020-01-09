//
//  MADFullScreenVideoAdViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/11/25.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MADFullScreenVideoAdViewController.h"
#import <MobAD/MobAD.h>
#import "MobADNormalButton.h"
#import "Const.h"

@interface MADFullScreenVideoAdViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) MobADNormalButton *refreshbutton;
@property (nonatomic, strong) UITextField *pidField;

@end

@implementation MADFullScreenVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"全屏视频广告";
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
    pidField.text = kSFullScreenVideoPID;
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
    [_refreshbutton setTitle:@"展示全屏视频广告" forState:UIControlStateNormal];
    [_refreshbutton addTarget:self action:@selector(refreshFullScreenVideoAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshbutton];
    
}


- (void)refreshFullScreenVideoAd
{
    _refreshbutton.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [MobAD showFullScreenVideoAdWithPlacementId:self.pidField.text.length > 0 ? self.pidField.text : kSFullScreenVideoPID
                                 viewController:self
                               ritSceneDescribe:@"xxxxx"
                                   stateChanged:^(id adObject, MADState state, NSError *error) {
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
    DebugLog(@"---- MADFullScreenVideoAdViewController ---- %s", __func__);
}

@end
