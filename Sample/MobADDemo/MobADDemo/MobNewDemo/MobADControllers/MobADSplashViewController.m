//
//  MobADSplashViewController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/15.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADSplashViewController.h"
#import "MobADContentTableView.h"
#import <MobAD/MobAD.h>
#import "HUDManager.h"
@interface MobADSplashViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIView *pidView;

@property (strong, nonatomic) NSArray *listArray;

@property (strong, nonatomic) UITextField *pidField;

@property (strong, nonatomic) MobADContentTableView *contentView;



@end

@implementation MobADSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"开屏广告";
    self.view.backgroundColor = MOB_RGB(250, 250, 250);
    self.listArray = @[@"广告位ID:"];
    [self.view addSubview:self.pidView];
    [self.view addSubview:self.contentView];
}

-(UIView *)pidView
{
    if(!_pidView)
    {
        _pidView = [[UIView alloc] initWithFrame:CGRectMake(15, NavigationBarHeight + 10, ScreenWidth - 30.f, 60.f)];
        _pidView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _pidView.layer.cornerRadius = 3.3;
        _pidView.layer.shadowColor = [UIColor colorWithRed:235/255.0 green:239/255.0 blue:241/255.0 alpha:1.0].CGColor;
        _pidView.layer.shadowOffset = CGSizeMake(0,2.7);
        _pidView.layer.shadowOpacity = 1;
        _pidView.layer.shadowRadius = 6.7;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15,_pidView.frame.size.height / 2 - 10 , 65, 20)];
        label.text = @"广告位ID:";
        label.textColor = MOB_RGB(38, 50, 56);
        label.font = PingFangRegularFont(15);
        [_pidView addSubview:label];
        
        self.pidField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 10, _pidView.frame.size.height / 2 - 10, _pidView.frame.size.width - CGRectGetMaxX(label.frame) - 10 - 40, 20)];
        self.pidField.text = kSSplashPID;
        self.pidField.textColor = MOB_RGB(38, 50, 56);
        self.pidField.font = PingFangRegularFont(15);
        self.pidField.delegate = self;
        [_pidView addSubview:self.pidField];
        
        UIButton *cleanBtn = [[UIButton alloc] initWithFrame:CGRectMake(_pidView.frame.size.width - 30, _pidView.frame.size.height / 2 - 7.5, 15, 15)];
        [cleanBtn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        [cleanBtn addTarget:self action:@selector(cleanPid) forControlEvents:UIControlEventTouchUpInside];
        [_pidView addSubview:cleanBtn];
        
        
    }
    return _pidView;
}

-(MobADContentTableView *)contentView
{
    if(!_contentView)
    {
        _contentView = [[MobADContentTableView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.pidView.frame) + 10, ScreenWidth - 30.f, 240)];
        _contentView.dataArray = @[@"预加载广告",@"默认全屏开屏广告",@"自定义跳过按钮开屏广告",@"自定义底部view的开屏广告"];
        _contentView.iconArray = @[@"icon_load",@"icon_splash_1",@"icon_splash_2",@"icon_splash_3"];
        [_contentView loadTableView];
        __weak __typeof(&*self)weakSelf = self;
        _contentView.selectCellBlock = ^(NSInteger index) {
            if(index == 0)
            {
                [weakSelf preLoadSplashAD];
            }
            if(index == 1)
            {
                [weakSelf loadDefaultSplashAD];
            }
            if(index == 2)
            {
                [weakSelf loadCustomSkipButtonSplashAD];
            }
            if(index == 3)
            {
                [weakSelf loadCustomBottomViewSplashAD];
            }
           
        };
        
    }
    return _contentView;
}


-(void)cleanPid
{
    self.pidField.text = @"";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.pidField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.pidField resignFirstResponder];
}

#pragma mark 加载广告
-(void)preLoadSplashAD
{
    [HUDManager showLoading];
    [MobAD loadSplashAdDataWithPlacementId:self.pidField.text.length > 0 ? self.pidField.text : kSSplashPID stateChanged:^(id adObject, MADState state, NSError *error) {
        [HUDManager hidenHud];
        if(error)
        {
            [HUDManager showTextHud:error.localizedDescription];
        }else
        {
            [HUDManager showTextHud:@"开屏广告预加载成功"];
        }
    }];
}

-(void)loadDefaultSplashAD
{
    [HUDManager showLoading];
   
    [MobAD showSplashAdWithPlacementId:self.pidField.text.length > 0 ? self.pidField.text : kSSplashPID onView:[UIApplication sharedApplication].keyWindow adFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) viewController:self customSkipView:nil customBottomView:nil tolerateTimeout:10.f adLifeTimeCallback:^(NSInteger lifeTime) {
        NSLog(@"==>liefTime:%ld",lifeTime);
    } stateChanged:^(id adObject, MADState state, NSError *error) {
        [HUDManager hidenHud];
        if(error)
        {
            [HUDManager showTextHud:error.localizedDescription];
        }
    }];
}

-(void)loadCustomSkipButtonSplashAD
{
    // customSkipView
    UIButton *skipButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 30, 60, 28)];
    [skipButton setBackgroundColor:[UIColor yellowColor]];
    skipButton.layer.cornerRadius = 3;
    skipButton.clipsToBounds = YES;
    [skipButton setTitle:[NSString stringWithFormat:@"跳过|5s"] forState:UIControlStateNormal];
    skipButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [skipButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [HUDManager showLoading];
    
    [MobAD showSplashAdWithPlacementId:self.pidField.text.length > 0 ? self.pidField.text : kSSplashPID onView:[UIApplication sharedApplication].keyWindow adFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) viewController:self customSkipView:skipButton customBottomView:nil tolerateTimeout:10.f adLifeTimeCallback:^(NSInteger lifeTime) {
        NSLog(@"==>liefTime:%ld",lifeTime);
        [skipButton setTitle:[NSString stringWithFormat:@"跳过|%zds", lifeTime] forState:UIControlStateNormal];
    } stateChanged:^(id adObject, MADState state, NSError *error) {
        [HUDManager hidenHud];
        if(error)
        {
            [HUDManager showTextHud:error.localizedDescription];
        }
    }];
}

-(void)loadCustomBottomViewSplashAD
{
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
    [bottomViewButton addTarget:self action:@selector(bottomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomViewButton];
    
    [HUDManager showLoading];
    
    [MobAD showSplashAdWithPlacementId:self.pidField.text.length > 0 ? self.pidField.text : kSSplashPID onView:[UIApplication sharedApplication].keyWindow adFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight * 0.8) viewController:self customSkipView:nil customBottomView:bottomView tolerateTimeout:10.f adLifeTimeCallback:^(NSInteger lifeTime) {
        NSLog(@"==>liefTime:%ld",lifeTime);
    } stateChanged:^(id adObject, MADState state, NSError *error) {
        [HUDManager hidenHud];
        if(error)
        {
            [HUDManager showTextHud:error.localizedDescription];
        }
    }];
    
}

-(void)bottomButtonClicked
{
    NSLog(@"bottom button click!");
}

@end
