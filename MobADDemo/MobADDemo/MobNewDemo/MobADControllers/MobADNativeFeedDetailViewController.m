//
//  MobADNativeFeedDetailViewController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/19.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADNativeFeedDetailViewController.h"
#import "MADNativeFeedTableViewCell.h"
#import "MobADNativeFeedTableViewCell.h"
#import <MobAD/MobAD.h>
#import "HUDManager.h"

static NSString *MADNativeFeedLeftTableViewCellIdentifier = @"MADNativeFeedLeftTableViewCell";
static NSString *MADNativeFeedLargeTableViewCellIdentifier = @"MADNativeFeedLargeTableViewCell";
static NSString *MADNativeFeedThreeTableViewCellIdentifier = @"MADNativeFeedThreeTableViewCell";
static NSString *MADNativeFeedVideoTableViewCellIdentifier = @"MADNativeFeedVideoTableViewCell";
static NSString *NormalCell = @"MobADNativeFeedTableViewCell";
                

@interface MobADNativeFeedDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray<__kindof MOBADNativeAdData *> *nativeAdDatas;


@end

@implementation MobADNativeFeedDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"自渲染广告展示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.nativeAdDatas = [NSMutableArray array];
    [self loadNativeAD];
}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, ScreenWidth, ScreenHeight - NavigationBarHeight - 10)];
        _tableView.backgroundColor = MOB_RGB(250, 250, 250);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MADNativeFeedLeftTableViewCell class] forCellReuseIdentifier:MADNativeFeedLeftTableViewCellIdentifier];
        [_tableView registerClass:[MADNativeFeedLargeTableViewCell class] forCellReuseIdentifier:MADNativeFeedLargeTableViewCellIdentifier];
        [_tableView registerClass:[MADNativeFeedThreeTableViewCell class] forCellReuseIdentifier:MADNativeFeedThreeTableViewCellIdentifier];
        [_tableView registerClass:[MADNativeFeedVideoTableViewCell class] forCellReuseIdentifier:MADNativeFeedVideoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:NormalCell bundle:nil] forCellReuseIdentifier:NormalCell];
    }
    return _tableView;
}


#pragma mark 加载广告
-(void)loadNativeAD
{
    [HUDManager showLoading];
    [MobAD nativeAdWithPlacementId:kSNativePID viewController:self adsCallback:^(NSArray<MOBADNativeAdData *> *nativeAdDatas, NSError *error) {
        [HUDManager hidenHud];
        if(!error)
        {
            [self.nativeAdDatas removeAllObjects];
            [self.nativeAdDatas addObjectsFromArray:nativeAdDatas];
            [self.tableView reloadData];
            [self.view addSubview:self.tableView];
        }
        
    } eCPMCallback:^(NSInteger eCPM) {
        
    } stateCallback:^(id adObject, MADState state, NSError *error) {
        if(error)
        {
            [HUDManager showTextHud:error.localizedDescription];
        }
    } dislikeCallback:^(id adObject, NSArray<NSString *> *reasons) {
        
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row % 10 == 0 && indexPath.row != 0)
    {
        MOBADNativeAdData *model = self.nativeAdDatas[0];
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
    }else
    {
        return 50.f;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row % 10 == 0 && indexPath.row != 0)
    {
        MOBADNativeAdData *model = self.nativeAdDatas[0];
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
        if (@available(iOS 12.0, *)) {
            if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                cell.contentView.backgroundColor = [UIColor grayColor];
            }
        }
        [cell refrashWithModel:model];
        return cell;
    }else
    {
        MobADNativeFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NormalCell];
        cell.nomalTitleLabel.text = [NSString stringWithFormat:@"No.%ld  Normal Data",(long)indexPath.row];
        
        return cell;
    }

}


@end
