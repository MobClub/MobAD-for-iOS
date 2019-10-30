//
//  MobADDrawVideoAdViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/5.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MobADDrawVideoAdViewController.h"
#import "MobADDrawTableViewCell.h"
#import <MobAD/MobAD.h>



static NSString *kMobADDrawNormalTableViewCellIdentifier = @"MobADDrawNormalTableViewCell";
static NSString *kMobADDrawTableViewCellIdentifier = @"MobADDrawTableViewCell";
static NSString *kMobADDrawBaseTableViewCellIdentifier = @"MobADDrawBaseTableViewCell";


@interface MobADDrawVideoAdViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic ,strong) MobADDrawBaseTableViewCell *lastCell;

@end

@implementation MobADDrawVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"原生Draw视频流";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.dataSource = self.ads.copy;
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.pagingEnabled = YES;
#if defined(__IPHONE_11_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
#else
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[MobADDrawNormalTableViewCell class] forCellReuseIdentifier:kMobADDrawNormalTableViewCellIdentifier];
    [self.tableView registerClass:[MobADDrawTableViewCell class] forCellReuseIdentifier:kMobADDrawTableViewCellIdentifier];
    [self.tableView registerClass:[MobADDrawBaseTableViewCell class] forCellReuseIdentifier:kMobADDrawBaseTableViewCellIdentifier];
    
//    __weak typeof(self) weakSelf = self;
//    for (MBADNativeAd *ad in self.ads)
//    {
//        ad.relatedView.videoAdView.drawVideoStateCallback = ^(MBADState state, MBADInteractionType interactionType, NSError *error, MBADPlayerPlayState playerState) {
//            [weakSelf _processBUDState:state error:error interactionType:interactionType];
//        };
//    }
    
    NSMutableArray *datas = [NSMutableArray array];
    for (NSInteger i =0 ; i < 5; i++) {
        [datas addObject:@"App tableViewcell"];
    }
    
    for (MADNativeAdData *model in self.ads) {
        NSUInteger index = rand() % datas.count;
        [datas insertObject:model atIndex:index];
    }
//    weakSelf.dataSource = [dataSources copy];
    self.dataSource = [datas copy];
    
//    [self.tableView reloadData];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(13, 34, 30, 30);
    [btn setImage:[UIImage imageNamed:@"draw_back.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:btn];
    [self.view addSubview:btn];
    btn.accessibilityIdentifier = @"draw_back";
    
}


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
//    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
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
        MobADDrawNormalTableViewCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:kMobADDrawNormalTableViewCellIdentifier forIndexPath:indexPath];
        cell.videoId = index;
        [cell refreshUIAtIndex:index];
        return cell;
    }
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

@end
