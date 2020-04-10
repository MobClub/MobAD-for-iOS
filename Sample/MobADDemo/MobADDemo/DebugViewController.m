//
//  DebugViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/11/25.
//  Copyright © 2019 Max. All rights reserved.
//

#import "DebugViewController.h"

#import <MobAD/MobAD+Private.h>
#import "Const.h"
#import "MADSplashViewController.h"
#import "MADBannerViewController.h"
#import "MADInterstitialViewController.h"
#import "MADNativeExpressFeedViewController.h"
#import "MADNativeFeedViewController.h"
#import "MobADDrawVideoAdViewController.h"
#import "MADFullScreenVideoAdViewController.h"
#import "MADRewardVideoAdViewController.h"
#import "MADDrawVideoFeedViewController.h"
#import "MBProgressHUD.h"
//#import <MOBFoundation/MOBFoundation.h>
#import <FCommon/FCommon.h>
#import "UIImage+Color.h"
#import <AdSupport/AdSupport.h>

@interface DebugViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) NSArray *adTypes;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MBProgressHUD *hudView;

@property (nonatomic, strong) UITextField *appkeyTextField;
@property (nonatomic, strong) UITextField *bundleIdTextField;

@property (nonatomic, strong) UIButton *appkeyButton;
@property (nonatomic, strong) UIButton *bundleIdButton;

@property (nonatomic, strong) UISwitch *apiSwitch;

@property (nonatomic, strong) UIWindow *alertConfigWindow;

@property (nonatomic, strong) UITextView *configDictTextView;

@property (copy, nonatomic) NSString *idfa;

@end

@implementation DebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MOBAD DEBUG DEMO";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.view.backgroundColor = [UIColor darkGrayColor];
        }
    }
    else
    {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    self.adTypes = @[
                     @"开屏广告:SplashAd",
                     @"横幅广告:Banner",
                     @"插屏广告:InterstitialAd",
                     @"原生模版广告:NativeExpressAd",
                     @"原生自渲染广告:NativeAd",
//                     @"全屏视频广告:FullScreenVideoAd",
                     @"激励视频广告:RewardVideoAd",
//                     @"Draw视频流:DrawVideoFeed",
                     ];
    
    [self setupViews];
    
    // HUD
    MBProgressHUD *hudV = [[MBProgressHUD alloc] initWithView:self.view];
    self.hudView = hudV;
    hudV.label.text = @"加载中...";
    hudV.detailsLabel.text = @"请耐心等待";
    [self.view addSubview:hudV];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%ld",(long)[MobAD privacyStatus]);
//    [self showPrivacy];
    if([MobAD privacyStatus] != 1)
    {
        [self showPrivacy];
    }
    
}

- (void)showPrivacy
{
    [MobAD getPrivacyCompletion:^(NSDictionary * _Nonnull data) {
        NSLog(@"%@",data);
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Mob隐私协议"
                                                                       message:data[@"privacy"]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* agreeAction = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
            [MobAD uploadPrivacyStatus:YES onResult:^(BOOL success) {
                NSLog(@"%d",success);
            }];
        }];
        UIAlertAction* denyAction = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
            [MobAD uploadPrivacyStatus:NO onResult:^(BOOL success) {
                NSLog(@"%d",success);
            }];
        }];
        
        //        [alert setValue:conditionsAttributeStr forKey:@"attributedMessage"];
        
        [alert addAction:agreeAction];
        [alert addAction:denyAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
    
}


- (void)setupViews {
    CGFloat y = NavigationBarHeight;
    
    // 设置API 环境
    UILabel *apiLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, y + 10, 0, 0)];
    apiLabel.text = @"是否强制使用测试环境:";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            apiLabel.textColor = [UIColor whiteColor];
        }
    }
    [apiLabel sizeToFit];
    [self.view addSubview:apiLabel];
    
    UISwitch *apiSwitch = [[UISwitch alloc] init];
    self.apiSwitch = apiSwitch;
    [apiSwitch addTarget:self action:@selector(apiSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    apiSwitch.center = CGPointMake(ScreenWidth - 50, y+20);
    [self.view addSubview:apiSwitch];
    
    // 设置 mobappkey
    UILabel *appkeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, y + 52, 0, 0)];
    appkeyLabel.text = @"AppKey:";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            appkeyLabel.textColor = [UIColor whiteColor];
        }
    }
    [appkeyLabel sizeToFit];
    [self.view addSubview:appkeyLabel];
    
    UITextField *appkeyField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(appkeyLabel.frame) + 5, y + 45, ScreenWidth - 85 - CGRectGetMaxX(appkeyLabel.frame), 34)];
    self.appkeyTextField = appkeyField;
    appkeyField.tag = 1001;
    appkeyField.returnKeyType = UIReturnKeyDone;
    appkeyField.keyboardType = UIKeyboardTypeASCIICapable;
    appkeyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    appkeyField.borderStyle = UITextBorderStyleRoundedRect;
    appkeyField.placeholder = @"MobAppkey...";
    appkeyField.text = [FcmnSDK appKey];
    appkeyField.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                appkeyField.backgroundColor = [UIColor whiteColor];
        }
    }
    appkeyField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:appkeyField];
    [self.view addSubview:appkeyField];
    
    UIButton *appkeyButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 75, y + 45, 60, 34)];
    self.appkeyButton = appkeyButton;
    [appkeyButton setTitle:@"设置" forState:UIControlStateNormal];
    [appkeyButton addTarget:self action:@selector(appkeyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [appkeyButton setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
    [appkeyButton setBackgroundImage:[UIImage gradientImageWithColors:@[[UIColor blueColor], [UIColor purpleColor]]] forState:UIControlStateNormal];
    [appkeyButton setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
    [self.view addSubview:appkeyButton];
    
    // 设置 BundleId,仅用于测试
    UILabel *bundleIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(appkeyField.frame) + 16
                                                                       , 0, 0)];
    bundleIdLabel.text = @"BundleId:";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            bundleIdLabel.textColor = [UIColor whiteColor];
        }
    }
    [bundleIdLabel sizeToFit];
    [self.view addSubview:bundleIdLabel];
    
    UITextField *bundleIdField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bundleIdLabel.frame) + 5, CGRectGetMaxY(appkeyField.frame) + 10, ScreenWidth - 85 - CGRectGetMaxX(bundleIdLabel.frame), 34)];
    self.bundleIdTextField = bundleIdField;
    bundleIdField.tag = 1002;
    bundleIdField.returnKeyType = UIReturnKeyDone;
    bundleIdField.keyboardType = UIKeyboardTypeASCIICapable;
    bundleIdField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    bundleIdField.borderStyle = UITextBorderStyleRoundedRect;
    bundleIdField.placeholder = @"BundleId...";
    bundleIdField.text = [FCMNApplication bundleId];
    bundleIdField.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                bundleIdField.backgroundColor = [UIColor whiteColor];
        }
    }
    bundleIdField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:bundleIdField];
    [self.view addSubview:bundleIdField];
    
    UIButton *bundleIdButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 75, CGRectGetMaxY(appkeyField.frame) + 10, 60, 34)];
    self.bundleIdButton = bundleIdButton;
    [bundleIdButton setTitle:@"设置" forState:UIControlStateNormal];
    [bundleIdButton addTarget:self action:@selector(bundleIdButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [appkeyButton setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
    [bundleIdButton setBackgroundImage:[UIImage gradientImageWithColors:@[[UIColor cyanColor], [UIColor magentaColor]]] forState:UIControlStateNormal];
    [bundleIdButton setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
    [self.view addSubview:bundleIdButton];
    
    //IDFA
    UILabel *idfaLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(bundleIdLabel.frame) + 16
                                                                       , 0, 0)];
    idfaLabel.text = @"IDFA:";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            idfaLabel.textColor = [UIColor whiteColor];
        }
    }
    [idfaLabel sizeToFit];
   // [self.view addSubview:idfaLabel];
    
    self.idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

    UILabel *idfaContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(idfaLabel.frame) + 5, CGRectGetMaxY(bundleIdLabel.frame) + 10, ScreenWidth - 85 - CGRectGetMaxX(idfaLabel.frame), 40)];
    idfaContentLabel.numberOfLines = 0;
    idfaContentLabel.text = self.idfa;
    idfaContentLabel.font = [UIFont systemFontOfSize:15.f];
    
    //[self.view addSubview:idfaContentLabel];
    
    UIButton *idfaButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 75, CGRectGetMaxY(bundleIdField.frame) + 10, 60, 34)];
    //        self.bundleIdButton = bundleIdButton;
    [idfaButton setTitle:@"复制" forState:UIControlStateNormal];
    [idfaButton addTarget:self action:@selector(copyIDFAClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [idfaButton setBackgroundImage:[UIImage gradientImageWithColors:@[[UIColor redColor], [UIColor magentaColor]]] forState:UIControlStateNormal];
    [idfaButton setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
   // [self.view addSubview:idfaButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bundleIdField.frame) + 10, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - y - 200) style:UITableViewStylePlain];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.tableView.backgroundColor = [UIColor grayColor];
        }
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MOBADMainCellIdentifier"];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, ScreenHeight - 45, ScreenWidth - 40, 30)];
    versionLabel.text = [NSString stringWithFormat:@"当前SDK版本: v%@", [MobAD version]];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            versionLabel.textColor = [UIColor whiteColor];
        } else {
            versionLabel.textColor = [UIColor darkGrayColor];
        }
    } else {
        versionLabel.textColor = [UIColor darkGrayColor];
    }
    versionLabel.font = [UIFont systemFontOfSize:14];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
}


- (void)apiSwitchChanged:(UISwitch *)apiSwitch
{
    NSLog(@"---> %d", apiSwitch.isOn);
    [MobAD useDebugAPI:self.apiSwitch.isOn];
}


- (void)appkeyButtonClicked:(UIButton *)appkeyButton
{
    appkeyButton.enabled = NO;
    [self.appkeyTextField endEditing:YES];
    if (self.appkeyTextField.text.length > 0) {
        [self.hudView showAnimated:YES];
        NSLog(@"---> before register: %@", [FcmnSDK appKey]);
        [FcmnSDK registerAppKey:self.appkeyTextField.text appSecret:@"c7ce1d041b0ccf5e80dbac2f54e99d18"];
        NSLog(@"---> after register: %@", [FcmnSDK appKey]);
        
        __weak typeof(self) weakSelf = self;
        [MobAD updateLocalConfigWithAppkey:[FcmnSDK appKey] onComplete:^(NSDictionary *configDict, NSError *error) {
            appkeyButton.enabled = YES;
            [weakSelf.hudView hideAnimated:YES];
            if (!error) {
                NSString *jsonString = [weakSelf _dictToJsonStr:configDict];
                weakSelf.configDictTextView.text = jsonString;
                weakSelf.alertConfigWindow.hidden = NO;
                MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
                hud.label.text = @"设置成功！";
                hud.mode = MBProgressHUDModeText;
                hud.removeFromSuperViewOnHide = YES;
                [hud showAnimated:YES];
                [hud hideAnimated:YES afterDelay:1];
                [weakSelf.alertConfigWindow addSubview:hud];
            } else {
                [weakSelf _showErrorAlert:error];
            }
        }];
    }
}


- (void)bundleIdButtonClicked:(UIButton *)bundleIdButton
{
    NSLog(@"---> %s", __func__);
    [MobAD setBundleId:self.bundleIdTextField.text];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.label.text = @"设置成功！";
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1];
    [self.view addSubview:hud];
}

-(void)copyIDFAClicked
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.idfa;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.label.text = @"复制成功！";
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1];
    [self.view addSubview:hud];
}


- (void)textFieldTextDidChange:(NSNotification *)noti
{
    if ([noti.name isEqualToString:@"UITextFieldTextDidChangeNotification"] && [noti.object isKindOfClass:[UITextField class]]) {
        UITextField *tf = (UITextField *)noti.object;
        if (tf.tag == 1001) {
            self.appkeyButton.enabled = tf.text.length > 0;
        } else if (tf.tag == 1002) {
            self.bundleIdButton.enabled = tf.text.length > 0;
        }
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1001) {
        self.appkeyButton.enabled = textField.text.length > 0;
    } else if (textField.tag == 1002) {
        self.bundleIdButton.enabled = textField.text.length > 0;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1001) {
        self.appkeyButton.enabled = textField.text.length > 0;
    } else if (textField.tag == 1002) {
        self.bundleIdButton.enabled = textField.text.length > 0;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.adTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MOBADMainCellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MOBADMainCellIdentifier"];
    }
    cell.textLabel.text = self.adTypes[indexPath.row];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            cell.backgroundColor = [UIColor grayColor];
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 网络检测
    FCMNNetworkType netStatus = [FCMNDevice currentNetworkType];
    if (netStatus == FCMNNetworkTypeNone)
    {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"错误信息" message:@"网络链接断开, 请重新连接网络！！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:alertOKAction];
        [self presentViewController:alertC animated:YES completion:nil];
        return;
    }
    
    switch (indexPath.row) {
        case 0:
            [self _showSplashAd];
            break;
            
        case 1:
            [self _showBannerAd];
            break;
            
        case 2:
            [self _showInterstitialAd];
            break;
            
        case 3:
            [self _showNativeExpressAd];
            break;
            
        case 4:
            [self _showNativeAd];
            break;
            
//        case 5:
//            [self _showFullScreenVideoAd];
//            break;
            
        case 5:
            [self _showRewardVideoAd];
            break;
//        case 7:
//            [self _showDrawVideoFeedAd];
//            break;
            
        default:
            break;
    }
}


- (void)_showSplashAd
{
    MADSplashViewController *vc = [[MADSplashViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)_showBannerAd
{
    MADBannerViewController *vc = [[MADBannerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)_showInterstitialAd
{
    MADInterstitialViewController *vc = [[MADInterstitialViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_showNativeExpressAd
{
    MADNativeExpressFeedViewController *vc = [[MADNativeExpressFeedViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_showNativeAd
{
    MADNativeFeedViewController *vc = [[MADNativeFeedViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_showFullScreenVideoAd
{
    MADFullScreenVideoAdViewController *vc = [[MADFullScreenVideoAdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self.hudView showAnimated:YES];
//    __weak typeof(self) weakSelf = self;
//    [MobAD showFullScreenVideoAdWithPlacementId:kSFullScreenVideoPID
//                                 viewController:self
//                               ritSceneDescribe:@"xxxxx"
//                                   stateChanged:^(id adObject, MADState state, NSError *error) {
//                                       NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
//                                       if (state == MADStateVideoDidLoad) {
//                                           [weakSelf.hudView hideAnimated:YES];
//                                       }
//                                       if (error) {
//                                           [weakSelf.hudView hideAnimated:YES];
//                                           [weakSelf _showErrorAlert:error];
//                                       }
//                                   }];
}

- (void)_showRewardVideoAd
{
    MADRewardVideoAdViewController *vc = [[MADRewardVideoAdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self.hudView showAnimated:YES];
//    __weak typeof(self) weakSelf = self;
//    [MobAD showRewardVideoAdWithPlacementId:kSRewardVideoPID
//                             viewController:self
//                               eCPMCallback:^(NSInteger eCPM) {
//                                   NSLog(@"---> eCPM: %ldd", (long)eCPM);
//                               }
//                              stateCallback:^(id adObject, MADState state, NSError *error) {
//                                  NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
//                                  if (state == MADStateVideoDidLoad) {
//                                      [weakSelf.hudView hideAnimated:YES];
//                                  }
//                                  if (error) {
//                                      [weakSelf.hudView hideAnimated:YES];
//                                      [weakSelf _showErrorAlert:error];
//                                  }
//                              }];
}

- (void)_showDrawVideoFeedAd
{
    MADDrawVideoFeedViewController *vc = [[MADDrawVideoFeedViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self.hudView showAnimated:YES];
//    __weak typeof(self) weakSelf = self;
//    [MobAD drawVideoFeedAdWithPlacementId:kSDrawVideoFeedPID
//                                  adCount:5
//                               adCallback:^(NSArray<MADNativeAdData *> *nativeAdDatas, NSError *error) {
//                                   [weakSelf.hudView hideAnimated:YES];
//                                   if (!error)
//                                   {
//                                       MobADDrawVideoAdViewController *vc = [[MobADDrawVideoAdViewController alloc] init];
//                                       vc.ads = nativeAdDatas.mutableCopy;
//                                       [weakSelf presentViewController:vc animated:YES completion:nil];
//                                   }
//                                   else
//                                   {
//                                       [weakSelf _showErrorAlert:error];
//                                   }
//
//                               }
//                            stateCallback:^(id adObject, MADState state, NSError *error) {
//                                NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
//                                if (error) {
//                                    [weakSelf _showErrorAlert:error];
//                                }
//                            }
//                          dislikeCallback:^(id adObject, NSArray<NSString *> *reasons) {
//                              DebugLog(@"%@",[reasons componentsJoinedByString:@","]);
//                          }];
    
}


#pragma mark - private

- (void)_showErrorAlert:(NSError *)error
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"错误信息" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:alertOKAction];
    [self presentViewController:alertC animated:YES completion:nil];
}


- (NSString *)_dictToJsonStr:(NSDictionary *)dict
{
    NSString *jsonString = nil;
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        jsonString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"-->json string: %@",jsonString);
        if (error) {
            NSLog(@"Error:%@" , error);
        }
    }
    return jsonString;
}

#pragma mark - getter

- (UIWindow *)alertConfigWindow
{
    if (!_alertConfigWindow) {
        _alertConfigWindow = [[UIWindow alloc] initWithFrame:self.view.bounds];
        _alertConfigWindow.windowLevel = UIWindowLevelAlert + 1;
        _alertConfigWindow.backgroundColor = [UIColor lightGrayColor];
        _alertConfigWindow.hidden = YES;
        
        UIButton *closeAlertButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.1, [UIScreen mainScreen].bounds.size.height * 0.1, [UIScreen mainScreen].bounds.size.width * 0.8, 40)];
        [closeAlertButton setBackgroundColor:[UIColor yellowColor]];
        [closeAlertButton setTitle:@"关闭" forState:UIControlStateNormal];
        [closeAlertButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [closeAlertButton addTarget:self action:@selector(closeAlertButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_alertConfigWindow addSubview:closeAlertButton];
        
        [_alertConfigWindow addSubview:self.configDictTextView];
        
        UIButton *copyButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.1, [UIScreen mainScreen].bounds.size.height * 0.9, [UIScreen mainScreen].bounds.size.width * 0.8, 40)];
        [copyButton setBackgroundColor:[UIColor cyanColor]];
        [copyButton setTitle:@"复制配置信息" forState:UIControlStateNormal];
        [copyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [copyButton addTarget:self action:@selector(copyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_alertConfigWindow addSubview:copyButton];
        
    }
    return _alertConfigWindow;
}


- (void)closeAlertButtonClicked
{
    self.alertConfigWindow.hidden = YES;
}


- (UITextView *)configDictTextView
{
    if (!_configDictTextView) {
        _configDictTextView = [[UITextView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.1, [UIScreen mainScreen].bounds.size.height * 0.2, [UIScreen mainScreen].bounds.size.width * 0.8, [UIScreen mainScreen].bounds.size.height * 0.65)];
        _configDictTextView.textColor = [UIColor whiteColor];
        _configDictTextView.backgroundColor = [UIColor grayColor];
        _configDictTextView.editable = NO;
        _configDictTextView.font = [UIFont systemFontOfSize:14];
    }
    return _configDictTextView;
}

- (void)copyButtonClicked
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.configDictTextView.text;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.label.text = @"复制成功！";
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1];
    [self.alertConfigWindow addSubview:hud];
}

@end
