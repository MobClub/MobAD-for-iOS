# 广告SDK iOS使用文档（v2.0.2）

本集成文档适用于 **MobAD iOS v2.0.2** 版本。

[TOC]

## 一、注册Mob的应用

请先注册成为Mob开发者，并添加您的应用，详情请参考： [Mob开发者后台使用指南](http://bbs.mob.com/forum.php?mod=viewthread&tid=8212&extra=page%3D1)

## 二、集成SDK

### 1、使用CocoaPods自动集成

在项目中的 **Podfile** 文件中添加 `pod ‘mob_adsdk’` ，然后执行 `pod install` 或 `pod update` ，如下图：

![pod-search](http://download.sdk.mob.com/2019/10/11/14/1570777004479/1948_498_100.45.png)
![podspec](http://download.sdk.mob.com/2019/10/11/14/1570776910501/1642_598_103.7.png)

### 2、手动集成  

#### 2.1、将SDK文件夹导入到您的工程中

![image](http://download.sdk.mob.com/2019/09/09/12/1568002172467/969_202_30.11.png)


#### 2.2、添加依赖库

```
libresolv.tbd
libxml2.tbd
libc++.tbd
libz.tbd
```

### 3、项目配置

* Build Settings：

    Other Linker Flags 添加 "-ObjC"
    
* ATS： 

    在项目的info.plist中添加一个KeyApp Transport Security  Settings，类型为字典类型。然后给它添加一个Key：Allow Arbitrary Loads，类型为Boolean类型，值为YES；

    ![image](http://wiki.mob.com/wp-content/uploads/2015/09/A4FACB65-2EED-437F-8D8B-6378D093AAC6.png)

* 配置Mob的AppKey

    在项目工程的Info.plist 中如图增加 MOBAppKey 和 MOBAppSecret 两个字段

    ![image](http://download.sdk.mob.com/2019/09/09/12/1568002012428/1400_960_353.37.png)

## 三、接口调用示例

### 1、开屏广告

> 注意：不支持iPad设备

* 接口定义

```objc
/**
 展示开屏广告

 @param pid 广告位id
 @param view 开屏广告的载体视图，建议传Window
 @param frame 开屏广告frame,bottomView参数不为空时生效!需要在开屏广告底部展示App图标、名称等内容时可将广告的高度调小一些,让屏幕底部留出空间,但是建议保证广告视图frame的高度 + bottomView的高度 = 承载view的高度,以便撑满一屏.
 @param viewController 用于跳转的控制器
 @param skipView 自定义 `跳过` 按钮, 建议结合 `lifeTimeCallback` 设置内容.(传 nil 时使用默认的跳过按钮)
 @param bottomView 自定义底部视图,请注意⚠️：如果设置了该参数,MobAD将获取的广告以半屏形式展示在传入的Window上半部分,剩余的部分展示传入的bottomView.必须需设置好宽高,所占的空间不能过大,建议宽度与广告frame宽度一致,并保证高度不超过屏幕高度的25%.(传 nil 时默认广告视图充满)
 @param tolerateTimeout 广告加载超时时间设置, 默认3秒
 @param lifeTimeCallback 广告展示剩余时间回调, 单位秒
 @param stateChanged 广告状态回调
 */
+ (void)showSplashAdWithPlacementId:(NSString *)pid
                             onView:(UIView *)view
                            adFrame:(CGRect)frame
                     viewController:(UIViewController *)viewController
                     customSkipView:(UIView *_Nullable)skipView
                   customBottomView:(UIView *_Nullable)bottomView
                    tolerateTimeout:(NSTimeInterval)tolerateTimeout
                 adLifeTimeCallback:(MADSplashAdLifeTimeCallback)lifeTimeCallback
                       stateChanged:(MADStateCallback)stateChanged;
```

* 调用示例

```objc
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
```

### 2、横幅广告

* 接口定义

```objc
/**
 展示横幅广告
 
 @param pid 广告位id
 @param onView 广告视图的载体View
 @param viewController 用于跳转的控制器
 @param frame 广告视图frame
 @param interval 广告刷新间隔,范围 [30, 120] 秒, 不想要刷新则该字段传 0 即可
 @param stateChanged 广告状态回调
 @param dislikeCallback 用户选择关闭理由回调
 */
+ (void)showBannerAdWithPlacementId:(NSString *)pid
                             onView:(UIView *)onView
                     viewController:(UIViewController *)viewController
                              frame:(CGRect)frame
                           interval:(NSInteger)interval
                       stateChanged:(MADStateCallback)stateChanged
                    dislikeCallback:(MADDislikeCallback)dislikeCallback;
```

```objc
/**
 关闭横幅广告

 @param adObject 横幅广告对象
 */
+ (void)dismissBannerAd:(id)adObject;
```

* 调用示例

```objc
@interface MADBannerViewController ()

@property (nonatomic, strong) MobADNormalButton *refreshbutton;

@property (nonatomic, weak) id bannerAdView;

@end

@implementation MADBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Banner广告";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //refresh Button
    CGSize size = [UIScreen mainScreen].bounds.size;
    _refreshbutton = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, size.height *0.4, 0, 0)];
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
    _refreshbutton.enabled = NO;
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat bannerHeigh = screenWidth / 500 * 100;
    __weak typeof(self) weakSelf = self;
    [MobAD showBannerAdWithPlacementId:kSBannerPID
                                onView:weakSelf.view
                        viewController:weakSelf
                                 frame:CGRectMake(0, 100, screenWidth, bannerHeigh)
                              interval:35
                          stateChanged:^(id adObject, MADState state, NSError *error) {
                              weakSelf.bannerAdView = adObject;
                              [weakSelf _processState:state error:error];
                          }
                       dislikeCallback:^(id adObject, NSArray<MADDislikeReason *> *reasons) {
                           NSMutableArray *mArr = [NSMutableArray array];
                           for (MADDislikeReason *reason in reasons) {
                               [mArr addObject:reason.name];
                           }
                           DebugLog(@"%@",[mArr componentsJoinedByString:@","]);
                       }];
}

@end
```

### 3、插屏广告

* 接口定义

```objc
/**
 展示插屏广告
 
 @param pid 广告位id
 @param onView 广告视图的载体View
 @param viewController 用于跳转的控制器
 @param frame 广告视图frame
 @param eCPMCallback 用于获取广告eCPM, 部分广告不存在eCPM时回调值为 -1
 @param stateChanged 广告状态回调
 */
+ (void)showInterstitialAdWithPlacementId:(NSString *)pid
                                   onView:(UIView *)onView
                           viewController:(UIViewController *)viewController
                                    frame:(CGRect)frame
                             eCPMCallback:(MADeCPMCallback)eCPMCallback
                             stateChanged:(MADStateCallback)stateChanged;
```

* 调用示例

```objc
__weak typeof(self) weakSelf = self;
[MobAD showInterstitialAdWithPlacementId:kSInterstitialPID
                                  onView:self.view
                          viewController:self
                                   frame:CGRectMake(ScreenWidth * 0.1, ScreenWidth * 0.2, ScreenWidth * 0.8, ScreenHeight * 0.6)
                            eCPMCallback:^(NSInteger eCPM) {
                                NSLog(@"---> eCPM: %ld", (long)eCPM);
                            }
                            stateChanged:^(id adObject, MADState state, NSError *error) {
                                [weakSelf _processState:state error:error];
                            }];
```

### 4、原生模版信息流广告

* 接口定义

```objc
/**
 原生模版信息流广告
 
 @param pid 广告配置项
 @param size 广告大小
 @param edgeInsets 广告内容边距, 大图样式默认(0,0,0,0), 其他样式默认 (10,10,10,10), 仅 >= 0 时生效
 @param adViewsCallback 广告模版视图回调
 @param stateCallback 广告状态回调
 @param dislikeCallback 广告不喜欢原因回调
 */
+ (void)nativeExpressAdWithPlacementId:(NSString *)pid
                                adSize:(CGSize)size
                            edgeInsets:(UIEdgeInsets)edgeInsets
                       adViewsCallback:(MADNativeExpressAdViewCallback)adViewsCallback
                         stateCallback:(MADStateCallback)stateCallback
                       dislikeCallback:(MADDislikeCallback)dislikeCallback;
```

* 调用示例

```objc
- (void)loadData
{
    _loadButton.enabled = NO;
    [self.view endEditing:YES];
    
    CGFloat top = 10;
    CGFloat left = 10;
    CGFloat bottom = 10;
    CGFloat right = 10;
    if (self.topField.text.length > 0) {
        top = [self.topField.text floatValue];
    }
    if (self.leftField.text.length > 0) {
        left = [self.leftField.text floatValue];
    }
    if (self.bottomField.text.length > 0) {
        bottom = [self.bottomField.text floatValue];
    }
    if (self.rightField.text.length > 0) {
        right = [self.rightField.text floatValue];
    }
    
    __weak typeof(self) weakSelf = self;
    [MobAD nativeExpressAdWithPlacementId:self.pidField.text
                                   adSize:CGSizeMake(ScreenWidth, 0)
                               edgeInsets:UIEdgeInsetsMake(top, left, bottom, right)
                          adViewsCallback:^(NSArray<MADNativeExpressAdView *> *nativeExpressAdViews, NSError *error) {
                              weakSelf.loadButton.enabled = YES;
                              if (error) {
                                  [weakSelf _showErrorAlert:error];
                                  return;
                              }
                              [weakSelf.nativeExpressAdViews removeAllObjects];
                              if (nativeExpressAdViews.count) {
                                  [weakSelf.nativeExpressAdViews addObjectsFromArray:nativeExpressAdViews];
                                  for (MADNativeExpressAdView *expressView in weakSelf.nativeExpressAdViews) {
                                      expressView.controller = weakSelf;
                                      [expressView render];
                                  }
                              }
                              [weakSelf.tableView reloadData];
                          }
                            stateCallback:^(id adObject, MADState state, NSError *error) {
                                if (state == MADStateDidClosed) {
                                    for (int i = 0; i < weakSelf.nativeExpressAdViews.count; i++) {
                                        MADNativeExpressAdView *mbV = weakSelf.nativeExpressAdViews[i];
                                        if (mbV.adView == adObject) {
                                            [weakSelf.nativeExpressAdViews removeObject:mbV];
                                            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                                            [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                            break;
                                        }
                                    }
                                }
                                [weakSelf _processState:state error:error];
                            }
                          dislikeCallback:^(id adObject, NSArray<MADDislikeReason *> *reasons) {
                              NSMutableArray *mArr = [NSMutableArray array];
                              for (MADDislikeReason *reason in reasons) {
                                  [mArr addObject:reason.name];
                              }
                              DebugLog(@"%@",[mArr componentsJoinedByString:@","]);
                              
                              for (int i = 0; i < weakSelf.nativeExpressAdViews.count; i++) {
                                  MADNativeExpressAdView *mbV = weakSelf.nativeExpressAdViews[i];
                                  if (mbV.adView == adObject) {
                                      [weakSelf.nativeExpressAdViews removeObject:mbV];
                                      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                                      [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                      break;
                                  }
                              }
                          }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MADNativeExpressAdView *view = self.nativeExpressAdViews[indexPath.row];
    return view.adView.bounds.size.height + 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nativeExpressAdViews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MOBNativeExpressCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 重用MBADNativeExpressAdView，先把之前的广告视图取下来，再添加上当前视图
    UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
    if ([subView superview]) {
        [subView removeFromSuperview];
    }
    
    MADNativeExpressAdView *view = [self.nativeExpressAdViews objectAtIndex:indexPath.row];
    view.adView.tag = 1000;
    [cell.contentView addSubview:view.adView];
    return cell;
}
```

### 5、原生自渲染信息流广告

* 接口定义

```objc
/**
 原生自渲染信息流广告
 
 @param pid 广告配置项
 @param adsCallback 广告数据回调
 @param stateCallback 广告状态回调
 @param dislikeCallback 广告不喜欢原因回调
 */
+ (void)nativeAdWithPlacementId:(NSString *)pid
                    adsCallback:(MADNativeAdCallback)adsCallback
                  stateCallback:(MADStateCallback)stateCallback
                dislikeCallback:(MADDislikeCallback)dislikeCallback;
```

* 调用示例

```objc
- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [MobAD nativeAdWithPlacementId:kSNativePID
                       adsCallback:^(NSArray<MADNativeAdData *> *nativeAdDatas, NSError *error) {
                           [weakSelf.nativeAdDatas addObjectsFromArray:nativeAdDatas];
                           [weakSelf.tableView reloadData];
                       }
                     stateCallback:^(id adObject, MADState state, NSError *error) {
                         [weakSelf _processState:state error:error];
                     }
                   dislikeCallback:^(id adObject, NSArray<MADDislikeReason *> *reasons) {
                       NSMutableArray *mArr = [NSMutableArray array];
                       for (MADDislikeReason *reason in reasons) {
                           [mArr addObject:reason.name];
                       }
                       DebugLog(@"%@",[mArr componentsJoinedByString:@","]);
                   }];
}



#pragma mark - UITableViewDelegate && UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MADNativeAdData *model = self.nativeAdDatas[indexPath.row];
    CGFloat height = 0;
    if (model.isVideoAd)
    {
        height = [MADNativeFeedVideoTableViewCell cellHeightWithModel:model width:ScreenWidth];
    }
    else if (model.mediaUrls.count > 1)
    {
        height = [MADNativeFeedThreeTableViewCell cellHeightWithModel:model width:ScreenWidth];
    }
    else
    {
        if (indexPath.row % 2) {
            height = [MADNativeFeedLargeTableViewCell cellHeightWithModel:model width:ScreenWidth];
        }
        else
        {
            height = [MADNativeFeedLeftTableViewCell cellHeightWithModel:model width:ScreenWidth];
        }
    }
    
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nativeAdDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MADNativeAdData *model = self.nativeAdDatas[indexPath.row];
    model.rootViewController = self;
    MADNativeFeedBaseTableViewCell *cell = nil;
    if (model.isVideoAd)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:MADNativeFeedVideoTableViewCellIdentifier];
    }
    else if (model.mediaUrls.count > 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:MADNativeFeedThreeTableViewCellIdentifier];
    }
    else
    {
        if (indexPath.row % 2) {
            cell = [tableView dequeueReusableCellWithIdentifier:MADNativeFeedLargeTableViewCellIdentifier];
        }
        else
        {
            cell = [tableView dequeueReusableCellWithIdentifier:MADNativeFeedLeftTableViewCellIdentifier];
        }
    }
    
    [cell refrashWithModel:model];
    
    return cell;
}
```

### 6、全屏视频广告

* 接口定义

```objc
/**
 展示全屏视频广告
 
 @param pid 广告位id
 @param viewController 用于跳转的控制器
 @param sceneDescirbe 可选,场景描述信息
 @param stateChanged 广告状态回调
 */
+ (void)showFullScreenVideoAdWithPlacementId:(NSString *)pid
                              viewController:(UIViewController *)viewController
                            ritSceneDescribe:(NSString *_Nullable)sceneDescirbe
                                stateChanged:(MADStateCallback)stateChanged;
```

* 调用示例

```objc
[MobAD showFullScreenVideoAdWithPlacementId:@"xxxxxx"
                             viewController:self
                           ritSceneDescribe:@"xxxxx"
                               stateChanged:^(id adObject, MADState state, NSError *error) {
                                   NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
                               }];
```

### 7、激励视频广告

* 接口定义

```objc
/**
 展示激励视频广告
 
 @param pid 广告位id
 @param viewController 用于 present 激励视频的 VC
 @param eCPMCallback 用于获取广告eCPM, 部分广告不存在eCPM时回调值为 -1
 @param stateCallback 激励视频广告状态回调
 */
+ (void)showRewardVideoAdWithPlacementId:(NSString *)pid
                          viewController:(UIViewController *)viewController
                                    eCPM:(MADeCPMCallback)eCPMCallback
                           stateCallback:(MADStateCallback)stateCallback;
```

* 调用示例

```objc
[MobAD showRewardVideoAdWithPlacementId:@"xxxxxxx"
                         viewController:self
                                   eCPM:^(NSInteger eCPM) {
                                       NSLog(@"---> eCPM: %ldd", (long)eCPM);
                                   }
                          stateCallback:^(id adObject, MADState state, NSError *error) {
                              NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
                          }];
```

### 8、Draw视频信息流广告

* 接口定义

```objc
/**
 获取Draw视频流

 @param pid 广告位id
 @param count 广告个数
 @param callback Draw视频流广告回调
 @param stateCallback 广告状态回调
 @param dislikeCallback 广告不喜欢原因回调
 */
+ (void)drawVideoFeedAdWithPlacementId:(NSString *)pid
                               adCount:(NSInteger)count
                            adCallback:(MADNativeAdCallback)callback
                         stateCallback:(MADStateCallback)stateCallback
                       dislikeCallback:(MADDislikeCallback)dislikeCallback;
```

* 调用示例

```objc
- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [MobAD drawVideoFeedAdWithPlacementId:@"10" // mobSlotId = 10 对应Draw视频流
                                  adCount:5
                               adCallback:^(NSArray<MADNativeAdData *> *nativeAdDatas, NSError *error) {
                                   if (!error)
                                   {
                                       NSMutableArray *dataSources = [weakSelf.dataSource mutableCopy];
                                       for (MADNativeAdData *model in nativeAdDatas) {
                                           NSUInteger index = rand() % dataSources.count;
                                           [dataSources insertObject:model atIndex:index];
                                       }
                                       weakSelf.dataSource = [dataSources copy];
                                       
                                       [weakSelf.tableView reloadData];
                                   }
                                   else
                                   {
                                       [weakSelf _showErrorAlert:error];
                                   }
                                   
                               }
                            stateCallback:^(id adObject, MADState state, NSError *error) {
                                [weakSelf _processState:state error:error];
                            }
                          dislikeCallback:^(id adObject, NSArray<MADDislikeReason *> *reasons) {
                              NSMutableArray *mArr = [NSMutableArray array];
                              for (MADDislikeReason *reason in reasons) {
                                  [mArr addObject:reason.name];
                              }
                              DebugLog(@"%@",[mArr componentsJoinedByString:@","]);
                          }];
}

- (void)closeVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self autoPlayVisibleVideo];
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
}


- (void)_processState:(MADState)state error:(NSError *)error
{
    switch (state) {
        case MADStateDidReceived:
            DebugLog(@"MADStateDidReceived");
            break;
        case MADStateFailReceived:
            DebugLog(@"MADStateFailReceived:%@",error);
            [self _showErrorAlert:error];
            break;
        case MADStateDidClick:
            DebugLog(@"MADStateDidClick");
            break;
        case MADStateDidClosed:
            DebugLog(@"MADStateDidClosed");
            break;
            
        default:
            break;
    }
}



- (void)autoPlayVisibleVideo
{
    NSArray *cells = self.tableView.visibleCells;
    MobADDrawBaseTableViewCell *cell =[cells objectAtIndex:0];
    if ([cell isKindOfClass:[MobADDrawNormalTableViewCell class]])
    {
        NSInteger cellIndex = [(MobADDrawNormalTableViewCell *)cell videoId];
        NSInteger lastCellIndex = [_lastCell isKindOfClass:[MobADDrawNormalTableViewCell class]]?[(MobADDrawNormalTableViewCell *)_lastCell videoId]:200;
        if (cellIndex != lastCellIndex) {
            [(MobADDrawNormalTableViewCell *)cell autoPlay];
        }
    }
    else if ([_lastCell isKindOfClass:[MobADDrawNormalTableViewCell class]])
    {
        [(MobADDrawNormalTableViewCell *)_lastCell pause];
    }
    _lastCell = cell;
}



#pragma mark --- tableView dataSource&delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[MADNativeAdData class]]) {
        MADNativeAdData *nativeAd = (MADNativeAdData *)model;
        nativeAd.rootViewController = self;
        MobADDrawTableViewCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:kMobADDrawTableViewCellIdentifier forIndexPath:indexPath];
        [model registerContainer:cell withClickableViews:@[cell.creativeButton,cell.titleLabel,cell.descriptionLabel,cell.headImg]];
        [cell refreshUIWithModel:nativeAd];

        return cell;
    }
    else
    {
    }
    MobADDrawNormalTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:kMobADDrawNormalTableViewCellIdentifier forIndexPath:indexPath];
    cell.videoId = index;
    [cell refreshUIAtIndex:index];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MobADDrawBaseTableViewCell cellHeight];
}

#pragma mark scrollviewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self autoPlayVisibleVideo];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _tableView.delegate = nil;
}
```

-------

> 以上示例代码仅为部分关键代码，具体详细使用方式请参考Demo源代码。

