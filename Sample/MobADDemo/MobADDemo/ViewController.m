//
//  ViewController.m
//  MobADDemo
//
//  Created by Max on 2019/7/30.
//  Copyright © 2019 Max. All rights reserved.
//

#import "ViewController.h"
#import <MobAD/MobAD.h>
#import "NativeAdViewController.h"
#import "UnifiedNativeAdViewController.h"
#import "FeedAdViewController.h"
#import "HybridAdViewController.h"
#import "NativeBannerViewController.h"
#import "NativeInterstitialViewController.h"
#import "MobADFullscreenAdViewController.h"
#import "MobADRewardVideoAdViewController.h"
#import "MobADDrawVideoAdViewController.h"
#import "NativeExpressBannerViewController.h"
#import "NativeExpressInterstitialAdViewController.h"
#import "NativeExpressFeedViewController.h"
#import "UnifiedNativeAdFeedImageViewController.h"
#import "Const.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSDictionary *infos;

@property (nonatomic, strong) UITextField *budAppidTextField;
@property (nonatomic, strong) UITextField *gdtAppidTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infos = @{@"channels":@[
                           @"MBD",
                           @"MGD"
                           ],
                   @"ads":@[@[
                                @"开屏广告:SplashAd",
                                @"插屏广告:InterstitialAd",
                                @"横幅广告:Banner",
                                @"信息流:NativeAd",
                                @"原生Banner广告",
                                @"原生插屏广告",
                                @"Draw视频信息流",
                                @"全屏视频广告",
                                @"激励视频广告",
                                @"个性化Banner广告",
                                @"个性化插屏广告",
                                @"个性化Feed广告",
                                ],
                            @[
                                @"开屏广告:SplashAd",
                                @"横幅广告:BannerView",
                                @"横幅广告2.0:UnifiedBanner",
                                @"插屏广告:InterstitialAd",
                                @"插屏广告2.0:UnifiedInterstitialAd",
                                @"信息流:NativeAd",
                                @"自渲染 2.0",
                                @"激励视频广告",
                                @"H5 激励视频 P1",
                                ]]};
    
    [self _configUI];
}

- (void)_configUI {
    
    self.title = @"MOBAD DEMO";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *budAppidField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, self.view.bounds.size.width/2.0-70, 30)];
    self.budAppidTextField = budAppidField;
    budAppidField.placeholder = @"BUD AppId...";
    budAppidField.text = kMBAppId;
    budAppidField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:budAppidField];
    
    UIButton *budButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2.0-50, 80, 40, 30)];
    [budButton setTitle:@"SET" forState:UIControlStateNormal];
    [budButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    budButton.backgroundColor = [UIColor yellowColor];
    [budButton addTarget:self action:@selector(budButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:budButton];
    
    UITextField *gdtAppidField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2.0+10, 80, self.view.bounds.size.width/2.0-70, 30)];
    self.gdtAppidTextField = gdtAppidField;
    gdtAppidField.placeholder = @"GDT AppId...";
    gdtAppidField.text = kMGAppId;
    gdtAppidField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:gdtAppidField];
    
    UIButton *gdtButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-50, 80, 40, 30)];
    [gdtButton setTitle:@"SET" forState:UIControlStateNormal];
    [gdtButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    gdtButton.backgroundColor = [UIColor cyanColor];
    [gdtButton addTarget:self action:@selector(gdtButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gdtButton];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height - 120) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
}


- (void)budButtonClicked:(UIButton *)sender {
    [self.budAppidTextField endEditing:YES];
    [self.gdtAppidTextField endEditing:YES];
    [MobAD setMBAppId:self.budAppidTextField.text];
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"BUD Appid 设置成功: %@", self.budAppidTextField.text] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:alertOKAction];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)gdtButtonClicked:(UIButton *)sender {
    [self.budAppidTextField endEditing:YES];
    [self.gdtAppidTextField endEditing:YES];
    [MobAD setMGAppId:self.gdtAppidTextField.text];
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"GDT Appid 设置成功: %@", self.gdtAppidTextField.text] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:alertOKAction];
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.infos.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.infos[@"ads"][section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MobADCellReuseIdentifier"];
    cell.textLabel.text = self.infos[@"ads"][indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.infos[@"channels"][section];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            [self _selectedB:indexPath.row];
            break;
            
        case 1:
            [self _selectedG:indexPath.row];
            break;
            
            
        default:
            break;
    }
}


- (void)_selectedB:(NSInteger)index
{
    if ([MobAD getMBAppId].length < 5) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"BUD AppID 不合法!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:alertOKAction];
        [self presentViewController:alertC animated:YES completion:nil];
    }
    switch (index) {
        case 0:
            [self _mbShowSplash];
            break;
        case 1:
            [self _mbShowInterstitialAd];
            break;
            
        case 2:
            [self _mbShowBannerAd];
            break;
            
        case 3:
            [self _mbShowNativeAd];
            break;
        case 4:
            [self _mbShowNativeBannerAd];
            break;
        case 5:
            [self _mbShowNativeInterstitialAd];
            break;
        case 6:
            [self _mbShowDrawVideoFeedAd];
            break;
        case 7:
            [self _mbShowFullScreenVideoAd];
            break;
        case 8:
            [self _mbShowRewardedVideoAd];
            break;
        case 9:
            [self _mbShowNativeExpressBannerAd];
            break;
        case 10:
            [self _mbShowNativeExpressInterstitialAd];
            break;
        case 11:
            [self _mbShowNativeExpressFeedAd];
            break;
            
        default:
            break;
    }
}

- (void)_selectedG:(NSInteger)index
{
    if ([MobAD getMGAppId].length < 5) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"GDT AppID 不合法!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:alertOKAction];
        [self presentViewController:alertC animated:YES completion:nil];
    }
    switch (index) {
        case 0:
            [self _mgShowSplash];
            break;
        case 1:
            [self _mgShowBannerView];
            break;
        case 2:
            [self _mgShowUnifiedBanner];
            break;
        case 3:
            [self _mgShowInterstitialAd];
            break;
        case 4:
            [self _mgShowUnifiedInterstitialAd];
            break;
        case 5:
            [self _mgShowNative];
            break;
        case 6:
            [self _mgShowUnifiedNative];
            break;
        case 7:
            [self _mgShowRewardVideoAd];
            break;
        case 8:
            [self _mgShowHybridAd];
            break;
            
        default:
            break;
    }
}

#pragma mark - GDT show

- (void)_mgShowSplash
{
    __weak typeof(self) weakSelf = self;
    
    [[MGADConnector defaultConnector] showSplashAdWithPlacementId:kGSpashPlacementId
                                                         inWindow:UIApplication.sharedApplication.keyWindow
                                                  backgroundColor:UIColor.whiteColor
                                                  backgroundImage:nil
                                                       fetchDelay:10
                                                       bottomView:nil
                                                         skipView:nil
                                                   skipViewCenter:CGPointZero
                                                       adLifeTime:^(NSUInteger time) {
                                                           //        DebugLog(@"%lu",(unsigned long)time);
                                                       } stateChanged:^(MGADState state, NSError *error) {
                                                           [weakSelf _processGDTState:state error:error];
                                                       }];
}

- (void)_mgShowBannerView
{
    __weak typeof(self) weakSelf = self;
    CGRect frame = CGRectMake(0, 88, self.view.bounds.size.width, 100);
    [[MGADConnector defaultConnector] bannerViewWithPlacementId:kGBannerPlacementId
                                                      withFrame:frame
                                                 viewController:self
                                                       interval:3
                                                        isGpsOn:NO
                                                  isAnimationOn:YES
                                                   showCloseBtn:YES
                                                 configComplete:^(UIView *adView) {
                                                     [weakSelf.view addSubview:adView];
                                                     
                                                 } stateChanged:^(MGADState state, NSError *error) {
                                                     [weakSelf _processGDTState:state error:error];
                                                 } memoryWarning:^{
                                                     DebugLog(@"!!!!!");
                                                 }];
}

- (void)_mgShowUnifiedBanner
{
    __weak typeof(self) weakSelf = self;
    CGRect frame = CGRectMake(0, 88, self.view.bounds.size.width, 100);
    [[MGADConnector defaultConnector] unifiedBannerViewWithPlacementId:kGUnifiedBannerPlacementId
                                                             withFrame:frame
                                                        viewController:self
                                                              interval:3
                                                         isAnimationOn:YES
                                                        configComplete:^(UIView *adView) {
                                                            [weakSelf.view addSubview:adView];
                                                        } stateChanged:^(MGADState state, NSError *error) {
                                                            [weakSelf _processGDTState:state error:error];
                                                        }];
}


- (void)_mgShowUnifiedInterstitialAd
{
    __weak typeof(self) weakSelf = self;
    [[MGADConnector defaultConnector] showUnifiedInterstitialAdWithPlacementId:kGUnifiedInterstitialPlacementId
                                                                viewController:self
                                                                          eCPM:^(NSInteger eCPM) {
                                                                              DebugLog(@"eCPM：%ld",(long)eCPM);
                                                                          } stateChanged:^(MGADState state, NSError *error) {
                                                                              [weakSelf _processGDTState:state error:error];
                                                                          }];
}

- (void)_mgShowInterstitialAd
{
    __weak typeof(self) weakSelf = self;
    [[MGADConnector defaultConnector] showInterstitialAdWithPlacementId:kGInterstitialPlacementId
                                                         viewController:self
                                                                isGpsOn:NO
                                                           stateChanged:^(MGADState state, NSError *error) {
                                                               [weakSelf _processGDTState:state error:error];
                                                           }];
}

- (void)_mgShowNative
{
    __weak typeof(self) weakSelf = self;
    [[MGADConnector defaultConnector] nativeExpressAdWithPlacementId:kGNativePlacementId
                                                                size:CGSizeMake(375, 50)
                                                             adCount:5
                                                      autoPlayOnWWAN:YES
                                                          videoMuted:YES
                                                    maxVideoDuration:60
                                               adViewsConfigComplete:^(NSArray *nativeAds, NSError *error) {
                                                   
                                                   if (!error) {
                                                       NativeAdViewController *vc = [[NativeAdViewController alloc] init];
                                                       vc.ads = nativeAds.mutableCopy;
                                                       [weakSelf.navigationController pushViewController:vc animated:YES];
                                                   }
                                                   else
                                                   {
                                                       DebugLog(@"%@",error);
                                                   }
                                               }];
}


- (void)_mgShowUnifiedNative
{
//    UnifiedNativeAdViewController *vc = [[UnifiedNativeAdViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    __weak typeof(self) weakSelf = self;
    [[MGADConnector defaultConnector] unifiedNativeAdWithPlacementId:kGUnifiedNativeFeedImagePlacementId
                                                             adCount:10
                                                    maxVideoDuration:30
                                               adViewsConfigComplete:^(NSArray *unifiedNativeAds, NSError *error) {
                                                   if (!error) {
                                                       UnifiedNativeAdFeedImageViewController *vc = [[UnifiedNativeAdFeedImageViewController alloc] init];
                                                       vc.ads = unifiedNativeAds.mutableCopy;
                                                       [weakSelf.navigationController pushViewController:vc animated:YES];
                                                   }
                                                   else
                                                   {
                                                       [self _showErrorAlert:error];
                                                   }
                                               }];
}


- (void)_mgShowRewardVideoAd
{
    [[MGADConnector defaultConnector] showRewardVideoAdWithPlacementId:kGRewardVideoPlacementId
                                                        viewController:self
                                                                  eCPM:^(NSInteger eCPM) {
                                                                      DebugLog(@"eCPM：%ld",(long)eCPM);
                                                                  }
                                                         stateCallback:^(MGADRewardVideoAdState state, NSError *error) {
                                                             DebugLog(@"---> state: %lu error: %@",(unsigned long)state, error.localizedDescription);
                                                         }];
}

- (void)_mgShowHybridAd
{
    __weak typeof(self) weakSelf = self;
    HybridAdViewController *vc = [[HybridAdViewController alloc] init];
    [weakSelf.navigationController pushViewController:vc animated:YES];
}



#pragma mark - BUD show

- (void)_mbShowSplash
{
    [[MBADConnector defaultConnector] showSplashAdWithSlotId:kBSplashSlotID
                                                      onView:[UIApplication sharedApplication].keyWindow
                                              viewController:self
                                                       frame:[UIScreen mainScreen].bounds
                                              hideSkipButton:NO
                                             tolerateTimeout:10
                                                stateChanged:^(MBADState state, MBADInteractionType interactionType, NSError *error) {
                                                    [self _processBUDState:state error:error interactionType:interactionType];
                                                }];
}

- (void)_mbShowInterstitialAd
{
    [[MBADConnector defaultConnector] showInterstitialAdWithSlotId:kBInterstitialSlotID
                                                    viewController:self
                                                              size:[MBADSize sizeBy:MBADProposalSize_Feed690_388]
                                                      stateChanged:^(MBADState state, MBADInteractionType interactionType, NSError *error) {
                                                          [self _processBUDState:state error:error interactionType:interactionType];
                                                      }];
}

- (void)_mbShowNativeAd
{
    MBADSlot *slot = [[MBADSlot alloc] init];
    slot.ID = kBNativeSlotID;
    slot.AdType = MBADSlotAdType_Feed;
    slot.position = MBADSlotPosition_Top;
    slot.imgSize = [MBADSize sizeBy:MBADProposalSize_Feed690_388];
    slot.isSupportDeepLink = YES;
    [[MBADConnector defaultConnector] nativeAdWithSlot:slot adCount:10 callback:^(NSArray *nativeAds, NSError *error) {
        
        FeedAdViewController *advc = [[FeedAdViewController alloc] init];
        advc.ads = nativeAds.mutableCopy;
        [self.navigationController pushViewController:advc animated:YES];
    }];
}

- (void)_mbShowNativeBannerAd
{
    MBADSlot *slot = [[MBADSlot alloc] init];
    slot.ID = kBNativeBannerSlotID;
    slot.AdType = MBADSlotAdType_Banner;
    slot.position = MBADSlotPosition_Top;
    slot.imgSize = [MBADSize sizeForWidth:1080 height:1920];
    slot.isSupportDeepLink = YES;
    slot.isOriginAd = YES;
    
    __weak typeof(self) weakSelf = self;
    [[MBADConnector defaultConnector] nativeAdWithSlot:slot adCount:3 callback:^(NSArray *nativeAds, NSError *error) {
        if (!error)
        {
            NativeBannerViewController *vc = [[NativeBannerViewController alloc] init];
            vc.ads = [nativeAds mutableCopy];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            [weakSelf _showErrorAlert:error];
        }
    }];
}

- (void)_mbShowBannerAd
{
    CGFloat screenWidth =  UIScreen.mainScreen.bounds.size.width;
    CGRect frame = CGRectMake(0, screenWidth, screenWidth, screenWidth/600.0 * 260);
    
    [[MBADConnector defaultConnector] showBannerWithSlotId:kBBannerSlotID
                                                    onView:self.view
                                            viewController:self
                                                      size:[MBADSize sizeBy:MBADProposalSize_Banner600_260]
                                                     frame:frame
                                                  interval:5
                                              stateChanged:^(MBADState state, MBADInteractionType interactionType, NSError *error) {
                                                  [self _processBUDState:state error:error interactionType:interactionType];
                                              } dislikeCallback:^(id adObject, NSArray *reasons) {
                                                  DebugLog(@"%@",reasons);
                                              }];
}

- (void)_mbShowNativeInterstitialAd
{
    NativeInterstitialViewController *vc = [[NativeInterstitialViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_mbShowDrawVideoFeedAd
{
    MBADSlot *slot = [[MBADSlot alloc] init];
    slot.ID = kBNativeDrawVideoSlotID; //@"900546588"
    slot.AdType = MBADSlotAdType_DrawVideo;
    slot.position = MBADSlotPosition_Top;
    slot.imgSize = [MBADSize sizeBy:MBADProposalSize_DrawFullScreen];
    slot.isSupportDeepLink = YES;
    slot.isOriginAd = YES;
    
    __weak typeof(self) weakSelf = self;
    [[MBADConnector defaultConnector] nativeAdWithSlot:slot adCount:2 callback:^(NSArray *nativeAds, NSError *error) {
        if (!error)
        {
            MobADDrawVideoAdViewController *vc = [[MobADDrawVideoAdViewController alloc] init];
            vc.ads = [nativeAds mutableCopy];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
            [weakSelf presentViewController:vc animated:YES completion:nil];
        }
        else
        {
            [weakSelf _showErrorAlert:error];
        }
    }];
}

- (void)_mbShowFullScreenVideoAd
{
    MobADFullscreenAdViewController *vc = [[MobADFullscreenAdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_mbShowRewardedVideoAd
{
    MobADRewardVideoAdViewController *vc = [[MobADRewardVideoAdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_mbShowNativeExpressBannerAd
{
    NativeExpressBannerViewController *vc = [[NativeExpressBannerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_mbShowNativeExpressInterstitialAd
{
    NativeExpressInterstitialAdViewController *vc = [[NativeExpressInterstitialAdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_mbShowNativeExpressFeedAd
{
    NativeExpressFeedViewController *vc = [[NativeExpressFeedViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - State Callback

- (void)_processBUDState:(MBADState)state error:(NSError *)error interactionType:(MBADInteractionType)interactionType
{
    switch (state) {
        case MBADStateDidLoad:
            DebugLog(@"MBADStateDidLoad");
            break;
        case MBADStateDidLoadFailed:
            DebugLog(@"MBADStateDidLoadFailed:%@",error);
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
            break;
        case MBADStateDidCloseOtherController:
            DebugLog(@"MBADStateDidCloseOtherController:%ld",interactionType);
            break;
            
        default:
            break;
    }
}

- (void)_processGDTState:(MGADState)state error:(NSError *)error
{
    switch (state) {
        case MGADStateDidReceived:
            DebugLog(@"MGADStateDidReceived");
            break;
        case MGADStateFailReceived:
            DebugLog(@"MGADStateFailReceived：%@",error);
            break;
        case MGADStateDidSuccessPresent:
            DebugLog(@"MGADStateDidSuccessPresent");
            break;
        case MGADStateDidFailPresent:
            DebugLog(@"MGADStateDidFailPresent：%@",error);
            break;
        case MGADStateAppWillEnterBackground:
            DebugLog(@"MGADStateAppWillEnterBackground");
            break;
        case MGADStateWillExposured:
            DebugLog(@"MGADStateWillExposured");
            break;
        case MGADStateDidClick:
            DebugLog(@"MGADStateDidClick");
            break;
        case MGADStateWillClosed:
            DebugLog(@"MGADStateWillClosed");
            break;
        case MGADStateDidClosed:
            DebugLog(@"MGADStateDidClosed");
            break;
        case MGADStateWillPresent:
            DebugLog(@"MGADStateWillPresent");
            break;
        case MGADStateDidPresent:
            DebugLog(@"MGADStateDidPresent");
            break;
        case MGADStateWillDismiss:
            DebugLog(@"MGADStateWillDismiss");
            break;
        case MGADStateDidDismiss:
            DebugLog(@"MGADStateDidDismiss");
            break;
        case MGADStateWillPresentFullScreenModal:
            DebugLog(@"MGADStateWillPresentFullScreenModal");
            break;
        case MGADStateDidPresentFullScreenModal:
            DebugLog(@"MGADStateDidPresentFullScreenModal");
            break;
        case MGADStateWillDismissFullScreenModal:
            DebugLog(@"MGADStateWillDismissFullScreenModal");
            break;
        case MGADStateDidDismissFullScreenModal:
            DebugLog(@"MGADStateDidDismissFullScreenModal");
            break;
        case MGADStateAdViewRenderSuccess:
            DebugLog(@"MGADStateAdViewRenderSuccess");
            break;
        case MGADStateAdViewRenderFail:
            DebugLog(@"MGADStateAdViewRenderFail");
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

@end
