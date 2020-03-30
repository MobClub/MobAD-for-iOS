//
//  MADNativeFeedViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/18.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MADNativeFeedViewController.h"
#import <MobAD/MobAD.h>
#import "Const.h"
#import "MobADNormalButton.h"
#import "MADNativeFeedTableViewCell.h"

static NSString *MADNativeFeedLeftTableViewCellIdentifier = @"MADNativeFeedLeftTableViewCell";
static NSString *MADNativeFeedLargeTableViewCellIdentifier = @"MADNativeFeedLargeTableViewCell";
static NSString *MADNativeFeedThreeTableViewCellIdentifier = @"MADNativeFeedThreeTableViewCell";
static NSString *MADNativeFeedVideoTableViewCellIdentifier = @"MADNativeFeedVideoTableViewCell";

@interface MADNativeFeedViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *pidField;

@property (strong, nonatomic) NSMutableArray<__kindof MOBADNativeAdData *> *nativeAdDatas;

@property (strong, nonatomic) UITableView *tableView;


@property (nonatomic, strong) MobADNormalButton *loadButton;

@end

@implementation MADNativeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"原生自渲染广告";
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.view.backgroundColor = [UIColor darkGrayColor];
        }
    }
    
    [self setupViews];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    if(self.nativeAdDatas.count > 0)
//    {
//        for(MOBADNativeAdData *data in self.nativeAdDatas)
//        {
//            [data unregisterView];
//        }
//    }
}

- (void)setupViews {
    UILabel *pidLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, NavigationBarHeight + 10, 0, 0)];
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
    
    UITextField *pidField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pidLabel.frame) + 5, NavigationBarHeight + 6 , self.view.bounds.size.width - CGRectGetMaxX(pidLabel.frame) - 15, 30)];
    self.pidField = pidField;
    pidField.returnKeyType = UIReturnKeyDone;
    pidField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    pidField.borderStyle = UITextBorderStyleRoundedRect;
    pidField.placeholder = @"请输入广告位ID...";
    pidField.text = kSNativePID;
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            pidField.backgroundColor = [UIColor whiteColor];
        }
    }
    pidField.textColor = [UIColor blackColor];
    pidField.delegate = self;
    [self.view addSubview:pidField];
    
    MobADNormalButton *loadBtn = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pidField.frame) + 10, 0, 0)];
    self.loadButton = loadBtn;
    loadBtn.center = CGPointMake(self.view.center.x, loadBtn.center.y);
    loadBtn.showRefreshIncon = YES;
    [loadBtn setTitle:@"拉取广告" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(loadBtn.frame) + 10, ScreenWidth, ScreenHeight - (CGRectGetMaxY(loadBtn.frame) + 10)) style:UITableViewStylePlain];
    [self.tableView registerClass:[MADNativeFeedLeftTableViewCell class] forCellReuseIdentifier:MADNativeFeedLeftTableViewCellIdentifier];
    [self.tableView registerClass:[MADNativeFeedLargeTableViewCell class] forCellReuseIdentifier:MADNativeFeedLargeTableViewCellIdentifier];
    [self.tableView registerClass:[MADNativeFeedThreeTableViewCell class] forCellReuseIdentifier:MADNativeFeedThreeTableViewCellIdentifier];
    [self.tableView registerClass:[MADNativeFeedVideoTableViewCell class] forCellReuseIdentifier:MADNativeFeedVideoTableViewCellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.tableView.backgroundColor = [UIColor grayColor];
        }
    }
    [self.view addSubview:self.tableView];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)loadData
{
        if(self.nativeAdDatas.count > 0)
        {
           [self.nativeAdDatas removeAllObjects];
            [self.tableView reloadData];
        }
    
    _loadButton.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [MobAD nativeAdWithPlacementId:self.pidField.text
                    viewController:self
                       adsCallback:^(NSArray<MOBADNativeAdData *> *nativeAdDatas, NSError *error) {
                           weakSelf.loadButton.enabled = YES;
                           if (error) {
                              // [weakSelf _showErrorAlert:error];
                            
                               return;
                           }
                           [weakSelf.nativeAdDatas removeAllObjects];
                           [weakSelf.nativeAdDatas addObjectsFromArray:nativeAdDatas];
                           [weakSelf.tableView reloadData];
                       }
                      eCPMCallback:^(NSInteger eCPM) {
                          NSLog(@"---> eCPM: %ld", (long)eCPM);
                      }
                     stateCallback:^(id adObject, MADState state, NSError *error) {
                         //[weakSelf _processState:state error:error];
                        if(error)
                        {
                            [weakSelf _showErrorAlert:error];
                            
                        }
        
                    weakSelf.loadButton.enabled = YES;
                        
                     }
                   dislikeCallback:^(id adObject, NSArray<NSString *> *reasons) {
                       DebugLog(@"%@",[reasons componentsJoinedByString:@","]);
                   }];
}



#pragma mark - UITableViewDelegate && UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MOBADNativeAdData *model = self.nativeAdDatas[indexPath.row];
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
    MOBADNativeAdData *model = self.nativeAdDatas[indexPath.row];
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
}


- (void)_processState:(MADState)state error:(NSError *)error
{
    switch (state) {
        case MADStateDidLoad:
            DebugLog(@"MADStateDidLoad");
            break;
        case MADStateFailLoad:
            DebugLog(@"MADStateFailLoad");
            break;
        case MADStateViewRenderSuccess:
            DebugLog(@"MADStateViewRenderSuccess");
            [self.tableView reloadData];
            break;
        case MADStateViewRenderFail:
            DebugLog(@"MADStateViewRenderFail");
            break;
        case MADStateWillPresentScreen:
            DebugLog(@"MADStateWillPresentScreen");
            break;
        case MADStateDidClick:
            DebugLog(@"MADStateDidClick");
            break;
            
        default:
            break;
    }
}

- (NSMutableArray<MOBADNativeAdData *> *)nativeAdDatas
{
    if (!_nativeAdDatas) {
        _nativeAdDatas = [NSMutableArray array];
    }
    return _nativeAdDatas;
}


- (void)_showErrorAlert:(NSError *)error
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"错误信息" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:alertOKAction];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"---- MADNativeFeedViewController ---- %s", __func__);
}

@end
