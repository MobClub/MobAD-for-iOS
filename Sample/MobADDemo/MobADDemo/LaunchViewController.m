//
//  LaunchViewController.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/11/12.
//  Copyright © 2019 Max. All rights reserved.
//

#import "LaunchViewController.h"
#import "MBProgressHUD.h"

@interface LaunchViewController ()

@property (nonatomic, strong) MBProgressHUD *hudView;

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.view.backgroundColor = [UIColor darkGrayColor];
        }
    }
    
    // HUD
    MBProgressHUD *hudV = [[MBProgressHUD alloc] initWithView:self.view];
    self.hudView = hudV;
    hudV.label.text = @"开屏广告加载中";
    hudV.detailsLabel.text = @"请耐心等待...";
   // [self.view addSubview:hudV];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.hudView showAnimated:YES];
}


- (void)dismissSplashHUD
{
    [self.hudView hideAnimated:YES];
    [self.hudView removeFromSuperview];
    self.hudView = nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
