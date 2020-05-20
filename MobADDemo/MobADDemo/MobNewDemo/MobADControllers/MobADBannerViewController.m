//
//  MobADBannerViewController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/15.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADBannerViewController.h"
#import "MobADContentTableView.h"
#import <MobAD/MobAD.h>
#import "HUDManager.h"

@interface MobADBannerViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIView *pidView;

@property (strong, nonatomic) NSArray *listArray;

@property (strong, nonatomic) UITextField *pidField;

@property (strong, nonatomic) UITextField *refreshTimeField;

@property (strong, nonatomic) MobADContentTableView *contentView;

@property (strong, nonatomic) UIView *bannerView;

@end

@implementation MobADBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"横幅广告";
    self.view.backgroundColor = MOB_RGB(250, 250, 250);
    self.listArray = @[@"广告位ID:"];
    [self.view addSubview:self.bannerView];
    [self.view addSubview:self.pidView];
    [self.view addSubview:self.contentView];
}

-(UIView *)bannerView
{
    if(!_bannerView)
    {
        _bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight+10, ScreenWidth, 100)];
        _bannerView.backgroundColor = [UIColor whiteColor];
    }
    return _bannerView;
}

-(UIView *)pidView
{
    if(!_pidView)
    {
        _pidView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.bannerView.frame) + 10, ScreenWidth - 30.f, 100)];
        _pidView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _pidView.layer.cornerRadius = 3.3;
        _pidView.layer.shadowColor = [UIColor colorWithRed:235/255.0 green:239/255.0 blue:241/255.0 alpha:1.0].CGColor;
        _pidView.layer.shadowOffset = CGSizeMake(0,2.7);
        _pidView.layer.shadowOpacity = 1;
        _pidView.layer.shadowRadius = 6.7;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15,20 , 70, 20)];
        label.text = @"广告位ID:";
        label.textColor = MOB_RGB(38, 50, 56);
        label.font = PingFangRegularFont(15);
        [_pidView addSubview:label];
        
        self.pidField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 10, 20, _pidView.frame.size.width - CGRectGetMaxX(label.frame) - 10 - 40, 20)];
        self.pidField.text = kSBannerPID;
        self.pidField.textColor = MOB_RGB(38, 50, 56);
        self.pidField.font = PingFangRegularFont(15);
        self.pidField.delegate = self;
        [_pidView addSubview:self.pidField];
        
        UIButton *cleanBtn = [[UIButton alloc] initWithFrame:CGRectMake(_pidView.frame.size.width - 30, 22, 15, 15)];
        [cleanBtn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        [cleanBtn addTarget:self action:@selector(cleanPid) forControlEvents:UIControlEventTouchUpInside];
        [_pidView addSubview:cleanBtn];
        
        
        UILabel *labelTime = [[UILabel alloc] initWithFrame:CGRectMake(15,CGRectGetMaxY(label.frame) + 20 , 100, 20)];
        labelTime.text = @"刷新时间(秒):";
        labelTime.textColor = MOB_RGB(38, 50, 56);
        labelTime.font = PingFangRegularFont(15);
        [_pidView addSubview:labelTime];
        
        self.refreshTimeField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labelTime.frame) + 10, CGRectGetMaxY(label.frame) + 20, _pidView.frame.size.width - CGRectGetMaxX(label.frame) - 10 - 40, 20)];
        self.refreshTimeField.text = @"30";
        self.refreshTimeField.textColor = MOB_RGB(38, 50, 56);
        self.refreshTimeField.font = PingFangRegularFont(15);
        self.refreshTimeField.delegate = self;
        [_pidView addSubview:self.refreshTimeField];
        
        UIButton *cleanTiemeBtn = [[UIButton alloc] initWithFrame:CGRectMake(_pidView.frame.size.width - 30, CGRectGetMaxY(label.frame) + 22, 15, 15)];
        [cleanTiemeBtn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        [cleanTiemeBtn addTarget:self action:@selector(cleanTime) forControlEvents:UIControlEventTouchUpInside];
        [_pidView addSubview:cleanTiemeBtn];
        
    }
    return _pidView;
}

-(MobADContentTableView *)contentView
{
    if(!_contentView)
    {
        _contentView = [[MobADContentTableView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.pidView.frame) + 10, ScreenWidth - 30.f, 60)];
        _contentView.dataArray = @[@"加载横幅广告"];
        _contentView.iconArray = @[@"icon_load"];
        [_contentView loadTableView];
        __weak __typeof(&*self)weakSelf = self;
        _contentView.selectCellBlock = ^(NSInteger index) {
            if(index == 0)
            {
                [weakSelf loadBannerAD];
            }
           
        };
        
    }
    return _contentView;
}


-(void)cleanPid
{
    self.pidField.text = @"";
}
-(void)cleanTime
{
    self.refreshTimeField.text = @"";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.pidField resignFirstResponder];
    [self.refreshTimeField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.pidField resignFirstResponder];
    [self.refreshTimeField resignFirstResponder];
}


#pragma mark 加载横幅广告
-(void)loadBannerAD
{
    [HUDManager showLoading];
    [MobAD showBannerAdWithPlacementId:self.pidField.text onView:self.bannerView viewController:self frame:CGRectMake(10, 10, ScreenWidth - 20, 80) interval:[self isPureFloat:self.refreshTimeField.text] ? [self.refreshTimeField.text floatValue] : 30 stateChanged:^(id adObject, MADState state, NSError *error) {
        [HUDManager hidenHud];
        if(error)
        {
            [HUDManager showTextHud:error.localizedDescription];
        }
    } dislikeCallback:^(id adObject, NSArray<NSString *> *reasons) {
        
    }];
}


//判断字符串是否为浮点数
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


@end
