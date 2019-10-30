//
//  NativeExpressFeedViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/7.
//  Copyright © 2019 Max. All rights reserved.
//

#import "NativeExpressFeedViewController.h"
#import <MobAD/MobAD.h>
#import "MobADNormalButton.h"
#import "Const.h"

@interface NativeExpressFeedViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray<__kindof MBADNativeExpressAdView *> *expressAdViews;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation NativeExpressFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个性化Feed广告";
    self.view.backgroundColor = [UIColor whiteColor];
    self.expressAdViews = [NSMutableArray new];
    [self setupViews];
    
    [self loadData];
}


- (void)setupViews {
    CGFloat y = 20 + NavigationBarHeight;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - y) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MOBNativeExpressCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}


- (void)loadData {
    
    if (!self.expressAdViews) {
        self.expressAdViews = [NSMutableArray arrayWithCapacity:20];
    }
    MBADSlot *slot1 = [[MBADSlot alloc] init];
    slot1.ID = kBNativeExpressFeedSlotID;
    slot1.AdType = MBADSlotAdType_Feed;
    MBADSize *imgSize = [MBADSize sizeBy:MBADProposalSize_Feed228_150];
    slot1.imgSize = imgSize;
    slot1.position = MBADSlotPosition_Feed;
    slot1.isSupportDeepLink = YES;
    
    
    CGSize adSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
    NSInteger adCount = 3;
    
     __weak typeof(self) weakSelf = self;
    [[MBADConnector defaultConnector] nativeExpressAdWithSlot:slot1
                                                       adSize:adSize
                                                      adCount:adCount
                                              adViewsCallback:^(NSArray *nativeExpressAdViews, NSError *error) {
                                                  if (error) {
                                                      [weakSelf _showErrorAlert:error];
                                                      return;
                                                  }
                                                  [weakSelf.expressAdViews removeAllObjects];//【重要】不能保存太多view，需要在合适的时机手动释放不用的，否则内存会过大
                                                  if (nativeExpressAdViews.count) {
                                                      [weakSelf.expressAdViews addObjectsFromArray:nativeExpressAdViews];
                                                      [nativeExpressAdViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                                          MBADNativeExpressAdView *expressView = (MBADNativeExpressAdView *)obj;
                                                          expressView.rootViewController = weakSelf;
                                                          [expressView render];
                                                      }];
                                                  }
                                                  [weakSelf.tableView reloadData];
                                                  NSLog(@"个性化模板拉取广告成功回调");
                                              }
                                                stateCallback:^(MBADState state, MBADInteractionType interactionType, NSError *error) {
                                                    [weakSelf _processBUDState:state error:error interactionType:interactionType];
                                                }
                                              dislikeCallback:^(id adObject, NSArray *reasons) {
                                                  NSMutableArray *mArr = [NSMutableArray array];
                                                  for (id reason in reasons) {
                                                      if ([reason isKindOfClass:[MBADDislikeReason class]])
                                                      {
                                                          MBADDislikeReason *dislikeR = (MBADDislikeReason *)reason;
                                                          [mArr addObject:dislikeR.name];
                                                      }
                                                  }
                                                  DebugLog(@"%@",[mArr componentsJoinedByString:@","]);
                                                  
                                                  for (int i = 0; i < weakSelf.expressAdViews.count; i++) {
                                                      MBADNativeExpressAdView *mbV = weakSelf.expressAdViews[i];
                                                      if (mbV.adView == adObject) {
                                                          [weakSelf.expressAdViews removeObject:mbV];
                                                          NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                                                          [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                          break;
                                                      }
                                                  }
                                              }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBADNativeExpressAdView *view = [self.expressAdViews objectAtIndex:indexPath.row];
    return view.adView.bounds.size.height + 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.expressAdViews.count;
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
    
    MBADNativeExpressAdView *view = [self.expressAdViews objectAtIndex:indexPath.row];
    view.adView.tag = 1000;
    [cell.contentView addSubview:view.adView];
    return cell;
}


- (void)_processBUDState:(MBADState)state error:(NSError *)error interactionType:(MBADInteractionType)interactionType
{
    switch (state) {
        case MBADStateViewRenderSuccess:
            DebugLog(@"MBADStateViewRenderSuccess");
            [self.tableView reloadData];
            break;
        case MBADStateViewRenderFail:
            DebugLog(@"MBADStateViewRenderFail");
            break;
        case MBADStateWillVisible:
            DebugLog(@"MBADStateWillVisible");
            break;
        case MBADStateDidClick:
            DebugLog(@"MBADStateDidClick");
            break;
        case MBADStateWillPresentScreen:
            DebugLog(@"MBADStateWillPresentScreen");
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

- (void)dealloc
{
    DebugLog(@"---- NativeExpressFeedViewController ---- %s", __func__);
}

@end
