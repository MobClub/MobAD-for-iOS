//
//  MADNativeExpressFeedViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/17.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MADNativeExpressFeedViewController.h"
#import <MobAD/MobAD.h>
#import "MobADNormalButton.h"
#import "Const.h"

@interface MADNativeExpressFeedViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *pidField;

@property (nonatomic, strong) UITextField *topField;
@property (nonatomic, strong) UITextField *leftField;
@property (nonatomic, strong) UITextField *bottomField;
@property (nonatomic, strong) UITextField *rightField;

@property (strong, nonatomic) NSMutableArray<__kindof MADNativeExpressAdView *> *nativeExpressAdViews;

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) MobADNormalButton *loadButton;

@end

@implementation MADNativeExpressFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"原生模版广告";
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.view.backgroundColor = [UIColor darkGrayColor];
        }
    }
    
    [self setupViews];
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
    pidField.text = kSNativeExpressPID;
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            pidField.backgroundColor = [UIColor whiteColor];
        }
    }
    pidField.textColor = [UIColor blackColor];
    pidField.delegate = self;
    [self.view addSubview:pidField];
    
    UILabel *insetsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(pidField.frame) + 15, 0, 0)];
    insetsLabel.text = @"图片边距:";
    insetsLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            insetsLabel.textColor = [UIColor whiteColor];
        }
    }
    insetsLabel.textAlignment = NSTextAlignmentLeft;
    [insetsLabel sizeToFit];
    [self.view addSubview:insetsLabel];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(insetsLabel.frame) + 15, CGRectGetMaxY(pidField.frame) + 15, 0, 0)];
    topLabel.text = @"上:";
    topLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            topLabel.textColor = [UIColor whiteColor];
        }
    }
    topLabel.textAlignment = NSTextAlignmentLeft;
    [topLabel sizeToFit];
    [self.view addSubview:topLabel];
    
    UITextField *topField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(topLabel.frame) + 5, topLabel.frame.origin.y - 4 , 60, 30)];
    self.topField = topField;
    topField.returnKeyType = UIReturnKeyDone;
    topField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    topField.borderStyle = UITextBorderStyleRoundedRect;
    topField.text = @"10";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            topField.backgroundColor = [UIColor whiteColor];
        }
    }
    topField.textColor = [UIColor blackColor];
    topField.delegate = self;
    [self.view addSubview:topField];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(topField.frame) + 15, topLabel.frame.origin.y, 0, 0)];
    bottomLabel.text = @"下:";
    bottomLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            bottomLabel.textColor = [UIColor whiteColor];
        }
    }
    bottomLabel.textAlignment = NSTextAlignmentLeft;
    [bottomLabel sizeToFit];
    [self.view addSubview:bottomLabel];
    
    UITextField *bottomField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bottomLabel.frame) + 5, bottomLabel.frame.origin.y - 4 , 60, 30)];
    self.bottomField = bottomField;
    bottomField.returnKeyType = UIReturnKeyDone;
    bottomField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    bottomField.borderStyle = UITextBorderStyleRoundedRect;
    bottomField.text = @"10";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            bottomField.backgroundColor = [UIColor whiteColor];
        }
    }
    bottomField.textColor = [UIColor blackColor];
    bottomField.delegate = self;
    [self.view addSubview:bottomField];
    
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(topLabel.frame.origin.x, CGRectGetMaxY(topLabel.frame) + 15, 0, 0)];
    leftLabel.text = @"左:";
    leftLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            leftLabel.textColor = [UIColor whiteColor];
        }
    }
    leftLabel.textAlignment = NSTextAlignmentLeft;
    [leftLabel sizeToFit];
    [self.view addSubview:leftLabel];
    
    UITextField *leftField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftLabel.frame) + 5, leftLabel.frame.origin.y - 4 , 60, 30)];
    self.leftField = leftField;
    leftField.returnKeyType = UIReturnKeyDone;
    leftField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    leftField.borderStyle = UITextBorderStyleRoundedRect;
    leftField.text = @"10";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            leftField.backgroundColor = [UIColor whiteColor];
        }
    }
    leftField.textColor = [UIColor blackColor];
    leftField.delegate = self;
    [self.view addSubview:leftField];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftField.frame) + 15, leftLabel.frame.origin.y, 0, 0)];
    rightLabel.text = @"右:";
    rightLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            rightLabel.textColor = [UIColor whiteColor];
        }
    }
    rightLabel.textAlignment = NSTextAlignmentLeft;
    [rightLabel sizeToFit];
    [self.view addSubview:rightLabel];
    
    UITextField *rightField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(rightLabel.frame) + 5, rightLabel.frame.origin.y - 4 , 60, 30)];
    self.rightField = rightField;
    rightField.returnKeyType = UIReturnKeyDone;
    rightField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    rightField.borderStyle = UITextBorderStyleRoundedRect;
    rightField.text = @"10";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            rightField.backgroundColor = [UIColor whiteColor];
        }
    }
    rightField.textColor = [UIColor blackColor];
    rightField.delegate = self;
    [self.view addSubview:rightField];
    
    MobADNormalButton *loadBtn = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rightField.frame) + 15, 0, 0)];
    self.loadButton = loadBtn;
    loadBtn.center = CGPointMake(self.view.center.x, loadBtn.center.y);
    loadBtn.showRefreshIncon = YES;
    [loadBtn setTitle:@"拉取广告" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(loadBtn.frame) + 5, ScreenWidth, ScreenHeight - (CGRectGetMaxY(loadBtn.frame) + 5)) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MOBNativeExpressCell"];
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


#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


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
                              if (nativeExpressAdViews.count > 0) {
                                  [weakSelf.nativeExpressAdViews addObjectsFromArray:nativeExpressAdViews];
                                  for (MADNativeExpressAdView *expressView in weakSelf.nativeExpressAdViews) {
                                      expressView.controller = weakSelf;
                                      // TODO: 临时隐藏关闭按钮方案
//                                      NSArray *adViewSubViews = expressView.adView.subviews;
//                                      for (UIView *sv in adViewSubViews) {
//                                          if ([sv isKindOfClass:[UIButton class]] && sv.bounds.size.width == 16) {
//                                              sv.hidden = YES;
//                                          }
//                                      }
                                      [expressView render];
                                  }
                              }
                              [weakSelf.tableView reloadData];
                          }
                             eCPMCallback:^(NSInteger eCPM) {
                                 NSLog(@"---> eCPM: %ld", (long)eCPM);
                             }
                            stateCallback:^(id adObject, MADState state, NSError *error) {
                                if (state == MADStateDidClose) {
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
                          dislikeCallback:^(id adObject, NSArray<NSString *> *reasons) {
                              DebugLog(@"%@",[reasons componentsJoinedByString:@","]);
                              
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
    cell.contentView.backgroundColor = [UIColor cyanColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            cell.contentView.backgroundColor = [UIColor grayColor];
        }
    }
    [cell.contentView addSubview:view.adView];
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
        case MADStateDidClose:
            DebugLog(@"MADStateDidClose");
            break;
            
        default:
            break;
    }
}



- (NSMutableArray<MADNativeExpressAdView *> *)nativeExpressAdViews
{
    if (!_nativeExpressAdViews) {
        _nativeExpressAdViews = [NSMutableArray array];
    }
    return _nativeExpressAdViews;
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
    DebugLog(@"---- MADNativeExpressFeedViewController ---- %s", __func__);
}

@end
