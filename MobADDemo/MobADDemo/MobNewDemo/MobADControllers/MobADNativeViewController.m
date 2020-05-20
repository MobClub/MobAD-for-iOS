//
//  MobADNativeViewController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/18.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADNativeViewController.h"
#import "MobADContentTableView.h"
#import "HUDManager.h"
#import "MobADNativeFeedDetailViewController.h"


@interface MobADNativeViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIView *pidView;

@property (strong, nonatomic) NSArray *listArray;

@property (strong, nonatomic) UITextField *pidField;

@property (strong, nonatomic) MobADContentTableView *contentView;

@end

@implementation MobADNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"自渲染";
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
        self.pidField.text = kSInterstitialPID;
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
        _contentView = [[MobADContentTableView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.pidView.frame) + 10, ScreenWidth - 30.f, 60)];
        _contentView.dataArray = @[@"加载原生自渲染广告"];
        _contentView.iconArray = @[@"icon_load"];
        [_contentView loadTableView];
        __weak __typeof(&*self)weakSelf = self;
        _contentView.selectCellBlock = ^(NSInteger index) {
            if(index == 0)
            {
                weakSelf.hidesBottomBarWhenPushed = YES;
                MobADNativeFeedDetailViewController *vc = [[MobADNativeFeedDetailViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
                weakSelf.hidesBottomBarWhenPushed = YES;
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






@end
