//
//  MainViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/12.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MainViewController.h"
#import <MobAD/MobAD.h>
#import "Const.h"
#import "MADSplashViewController.h"
#import "MADBannerViewController.h"
#import "MADInterstitialViewController.h"
#import "MADNativeExpressFeedViewController.h"
#import "MADNativeFeedViewController.h"
#import "MobADDrawVideoAdViewController.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *adTypes;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MOBAD DEMO";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.adTypes = @[
                     @"开屏广告:SplashAd",
                     @"横幅广告:Banner",
                     @"插屏广告:InterstitialAd",
                     @"原生模版广告:NativeExpressAd",
                     @"原生自渲染广告:NativeAd",
                     @"全屏视频广告:FullScreenVideoAd",
                     @"激励视频广告:RewardVideoAd",
                     @"Draw视频流:DrawVideoFeed",
                     ];
    
    [self setupViews];
    
//    [MobAD showSplashAdWithPlacementId:kSSplashPID
//                                onView:[UIApplication sharedApplication].keyWindow
//                        viewController:self
//                        hideSkipButton:NO
//                          stateChanged:^(id adObject, MADState state, NSError *error) {
//                              NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
//                          }];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    [MobAD showSplashAdWithPlacementId:kSSplashPID
//                                onView:[UIApplication sharedApplication].keyWindow
//                        viewController:self
//                        hideSkipButton:NO
//                          stateChanged:^(id adObject, MADState state, NSError *error) {
//                              NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
//                          }];
//}

- (void)setupViews {
    
    CGFloat y = NavigationBarHeight;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - y - 50) style:UITableViewStylePlain];
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
    versionLabel.textColor = [UIColor darkGrayColor];
    versionLabel.font = [UIFont systemFontOfSize:14];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
    
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
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 网络检测
    MOBFNetworkType netStatus = [MOBFDevice currentNetworkType];
    if (netStatus == MOBFNetworkTypeNone)
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
            
        case 5:
            [self _showFullScreenVideoAd];
            break;
        
        case 6:
            [self _showRewardVideoAd];
            break;
        case 7:
            [self _showDrawVideoFeedAd];
            break;
            
        default:
            break;
    }
}


- (void)_showSplashAd
{
    MADSplashViewController *vc = [[MADSplashViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    __weak typeof(self) weakSelf = self;
//    [MobAD showSplashAdWithPlacementId:kSSplashPID
//                                onView:[UIApplication sharedApplication].keyWindow
//                        viewController:self
//                        hideSkipButton:NO
//                          stateChanged:^(id adObject, MADState state, NSError *error) {
//                              NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
//                              if (error) {
//                                  [weakSelf _showErrorAlert:error];
//                              }
//                          }];
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
    __weak typeof(self) weakSelf = self;
    [MobAD showFullScreenVideoAdWithPlacementId:kSFullScreenVideoPID
                                 viewController:self
                               ritSceneDescribe:@"xxxxx"
                                   stateChanged:^(id adObject, MADState state, NSError *error) {
                                       NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
                                       if (error) {
                                           [weakSelf _showErrorAlert:error];
                                       }
                                   }];
}

- (void)_showRewardVideoAd
{
    __weak typeof(self) weakSelf = self;
    [MobAD showRewardVideoAdWithPlacementId:kSRewardVideoPID
                             viewController:self
                                       eCPM:^(NSInteger eCPM) {
                                           NSLog(@"---> eCPM: %ldd", (long)eCPM);
                                       }
                              stateCallback:^(id adObject, MADState state, NSError *error) {
                                  NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
                                  if (error) {
                                      [weakSelf _showErrorAlert:error];
                                  }
                              }];
}

- (void)_showDrawVideoFeedAd
{
    __weak typeof(self) weakSelf = self;
    [MobAD drawVideoFeedAdWithPlacementId:kSDrawVideoFeedPID
                                  adCount:5
                               adCallback:^(NSArray<MADNativeAdData *> *nativeAdDatas, NSError *error) {
                                   if (!error)
                                   {
                                       MobADDrawVideoAdViewController *vc = [[MobADDrawVideoAdViewController alloc] init];
                                       vc.ads = nativeAdDatas.mutableCopy;
                                       [weakSelf presentViewController:vc animated:YES completion:nil];
                                   }
                                   else
                                   {
                                       [weakSelf _showErrorAlert:error];
                                   }
                                   
                               }
                            stateCallback:^(id adObject, MADState state, NSError *error) {
                                NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
                                if (error) {
                                    [weakSelf _showErrorAlert:error];
                                }
                            }
                          dislikeCallback:^(id adObject, NSArray<MADDislikeReason *> *reasons) {
                              NSMutableArray *mArr = [NSMutableArray array];
                              for (MADDislikeReason *reason in reasons) {
                                  [mArr addObject:reason.name];
                              }
                              DebugLog(@"%@",[mArr componentsJoinedByString:@","]);
                          }];
    
}


#pragma mark - private

- (void)_showErrorAlert:(NSError *)error
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"错误信息" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:alertOKAction];
    [self presentViewController:alertC animated:YES completion:nil];
}

@end
