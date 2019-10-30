//
//  MADSplashViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/10/16.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MADSplashViewController.h"
#import <MobAD/MobAD.h>
#import "MobADNormalButton.h"
#import "Const.h"

@interface MADSplashViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) MobADNormalButton *refreshbutton;

@property (nonatomic, strong) UITextField *pidField;
@property (nonatomic, strong) UISwitch *skipSwitch;
@property (nonatomic, strong) UISwitch *bottomSwitch;

@end

@implementation MADSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"开屏广告";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *pidLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, NavigationBarHeight + 20, 0, 0)];
    pidLabel.text = @"广告位ID:";
    pidLabel.textColor = [UIColor blackColor];
    pidLabel.textAlignment = NSTextAlignmentLeft;
    [pidLabel sizeToFit];
    [self.view addSubview:pidLabel];
    
    UITextField *pidField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pidLabel.frame) + 5, NavigationBarHeight + 15 , self.view.bounds.size.width - CGRectGetMaxX(pidLabel.frame) - 30, 30)];
    self.pidField = pidField;
    pidField.returnKeyType = UIReturnKeyDone;
    pidField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    pidField.borderStyle = UITextBorderStyleRoundedRect;
    pidField.placeholder = @"请输入广告位ID...";
    pidField.text = kSSplashPID;
    pidField.textColor = [UIColor blackColor];
    pidField.delegate = self;
    [self.view addSubview:pidField];
    
    // custom skip button
    UILabel *customSkipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(pidField.frame) + 30, 0, 0)];
    customSkipLabel.text = @"使用自定义跳过按钮:";
    customSkipLabel.textColor = [UIColor blackColor];
    [customSkipLabel sizeToFit];
    [self.view addSubview:customSkipLabel];
    
    UISwitch *skipSwitch = [[UISwitch alloc] init];
    self.skipSwitch = skipSwitch;
    skipSwitch.center = CGPointMake(CGRectGetMaxX(customSkipLabel.frame) + 50, customSkipLabel.center.y);
    [self.view addSubview:skipSwitch];
    
    
    // custom bottom view
    UILabel *customBottomView = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(skipSwitch.frame) + 30, 0, 0)];
    customBottomView.text = @"使用自定义底部视图:";
    customBottomView.textColor = [UIColor blackColor];
    [customBottomView sizeToFit];
    [self.view addSubview:customBottomView];
    
    UISwitch *bottomSwitch = [[UISwitch alloc] init];
    self.bottomSwitch = bottomSwitch;
    bottomSwitch.center = CGPointMake(CGRectGetMaxX(customBottomView.frame) + 50, customBottomView.center.y);
    [self.view addSubview:bottomSwitch];
    
    
    //refresh Button
    CGSize size = [UIScreen mainScreen].bounds.size;
    _refreshbutton = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, size.height *0.5, 0, 0)];
    _refreshbutton.showRefreshIncon = YES;
    [_refreshbutton setTitle:@"展示开屏广告" forState:UIControlStateNormal];
    [_refreshbutton addTarget:self action:@selector(refreshBanner) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshbutton];
    
}

-  (void)refreshBanner {
    _refreshbutton.enabled = NO;
    
    // customSkipView
    UIButton *skipButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 30, 60, 28)];
    [skipButton setBackgroundColor:[UIColor yellowColor]];
    skipButton.layer.cornerRadius = 3;
    skipButton.clipsToBounds = YES;
    [skipButton setTitle:[NSString stringWithFormat:@"跳过|5s"] forState:UIControlStateNormal];
    skipButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [skipButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    // customBottomView
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.2)];
    bottomView.backgroundColor = [UIColor cyanColor];
    
    UIImageView *appIconView = [[UIImageView alloc] initWithFrame:CGRectMake(60, bottomView.bounds.size.height * 0.2, bottomView.bounds.size.height * 0.6, bottomView.bounds.size.height * 0.6)];
    appIconView.image = [UIImage imageNamed:@"bottomIcon"];
    [bottomView addSubview:appIconView];
    
    UIButton *bottomViewButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(appIconView.frame) + 15, 10, 120, 40)];
    bottomViewButton.center = CGPointMake(bottomViewButton.center.x, appIconView.center.y);
    [bottomViewButton setTitle:@"MobADDemo" forState:UIControlStateNormal];
    [bottomViewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bottomViewButton setBackgroundColor:[UIColor yellowColor]];
    [bottomViewButton addTarget:self action:@selector(_bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomViewButton];
    
    __weak typeof(self) weakSelf = self;
    [MobAD showSplashAdWithPlacementId:self.pidField.text
                                onView:[UIApplication sharedApplication].windows.firstObject
                               adFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8)
                        viewController:self
                        customSkipView:self.skipSwitch.isOn ? skipButton : nil
                      customBottomView:self.bottomSwitch.isOn ? bottomView : nil
                       tolerateTimeout:30.0
                    adLifeTimeCallback:^(NSInteger lifeTime) {
                        NSLog(@"=====> splash ad life time: %zd <=====", lifeTime);
                        [skipButton setTitle:[NSString stringWithFormat:@"跳过|%zds", lifeTime] forState:UIControlStateNormal];
                    }
                          stateChanged:^(id adObject, MADState state, NSError *error) {
                              weakSelf.refreshbutton.enabled = YES;
                              NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
                              if (error) {
                                  [weakSelf _showErrorAlert:error];
                              }
                          }];
}


- (void)_bottomButtonClicked:(UIButton *)btn
{
    NSLog(@"---->>>>> %@", btn.currentTitle);
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





- (void)_showErrorAlert:(NSError *)error
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"错误信息" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:alertOKAction];
    [self presentViewController:alertC animated:YES completion:nil];
}


@end
