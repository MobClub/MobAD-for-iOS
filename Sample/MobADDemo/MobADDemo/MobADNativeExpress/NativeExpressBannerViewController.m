//
//  NativeExpressBannerViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/6.
//  Copyright © 2019 Max. All rights reserved.
//

#import "NativeExpressBannerViewController.h"
#import <MobAD/MobAD.h>
#import "MobADNormalButton.h"
#import "Const.h"

@interface NativeExpressBannerViewController ()

@property (nonatomic, strong) MobADNormalButton *refreshbutton;

@end

@implementation NativeExpressBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个性化Banner广告";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //refresh Button
    CGSize size = [UIScreen mainScreen].bounds.size;
    _refreshbutton = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, size.height *0.4, 0, 0)];
    _refreshbutton.showRefreshIncon = YES;
    [_refreshbutton setTitle:@"展示Banner" forState:UIControlStateNormal];
    [_refreshbutton addTarget:self action:@selector(refreshBanner) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshbutton];
    
}

-  (void)refreshBanner {
    _refreshbutton.enabled = NO;
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat bannerHeigh = screenWidth / 600 * 90;
    MBADSize *imgSize = [MBADSize sizeBy:MBADProposalSize_Banner600_150];
    __weak typeof(self) weakSelf = self;
    [[MBADConnector defaultConnector] showNativeExpressBannerWithSlotId:kBNativeExpressBannerSlotID
                                                                 onView:self.view
                                                         viewController:self
                                                                imgSize:imgSize
                                                                  frame:CGRectMake(0, 100, screenWidth, bannerHeigh)
                                                      isSupportDeepLink:YES
                                                               interval:35
                                                           stateChanged:^(MBADState state, MBADInteractionType interactionType, NSError *error) {
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
                                                        }];
}

- (void)_processBUDState:(MBADState)state error:(NSError *)error interactionType:(MBADInteractionType)interactionType
{
    switch (state) {
        case MBADStateDidLoad:
            DebugLog(@"MBADStateDidLoad");
            break;
        case MBADStateDidLoadFailed:
            DebugLog(@"MBADStateDidLoadFailed:%@",error);
            _refreshbutton.enabled = YES;
            [self _showErrorAlert:error];
            break;
        case MBADStateViewRenderSuccess:
            DebugLog(@"MBADStateViewRenderSuccess");
            break;
        case MBADStateViewRenderFail:
            DebugLog(@"MBADStateViewRenderFail");
            break;
        case MBADStateWillVisible:
            _refreshbutton.enabled = YES;
            DebugLog(@"MBADStateWillVisible");
            break;
        case MBADStateDidClick:
            DebugLog(@"MBADStateDidClick");
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
    DebugLog(@"---- NativeExpressBannerViewController ----%s", __func__);
}

@end
