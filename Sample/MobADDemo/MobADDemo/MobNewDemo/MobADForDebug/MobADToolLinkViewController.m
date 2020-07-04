//
//  MobADToolLinkViewController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/13.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADToolLinkViewController.h"
#import "HUDManager.h"
#import <AdSupport/AdSupport.h>
#import "MobADWkWebViewController.h"

@interface MobADToolLinkViewController ()<UITextViewDelegate>

@property (strong, nonatomic) UIView *originView;

@property (strong, nonatomic) UIView *changeView;

@property (strong, nonatomic) UITextView *originTextView;

@property (strong, nonatomic) UILabel *changeLabel;

@property (strong, nonatomic) UIButton *changeBtn;

@property (strong, nonatomic) UIView *bottomView;

@property (strong, nonatomic) UIButton *openAppBtn;

@end

@implementation MobADToolLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MOB_RGB(250, 250, 250);
}

-(void)isDeepLink:(BOOL)deepLink
{
    [self.view addSubview:self.originView];
    [self.view addSubview:self.changeBtn];
    [self.view addSubview:self.changeView];
    
    if(deepLink)
    {
        self.title = @"DeepLink跳转";
        self.originTextView.text = @"请输入DeepLink";
        [self.view addSubview:self.openAppBtn];
    }else
    {
        self.title = @"Link跳转";
        self.originTextView.text = @"请输入url(需要携带http://或者https://)";
        [self.view addSubview:self.bottomView];
    }
}

-(UIView *)originView
{
    if(!_originView)
    {
        _originView = [[UIView alloc] initWithFrame:CGRectMake(15, 10 + NavigationBarHeight, self.view.frame.size.width - 30.f, 200)];
        _originView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _originView.layer.cornerRadius = 3.3;
        _originView.layer.shadowColor = [UIColor colorWithRed:235/255.0 green:239/255.0 blue:241/255.0 alpha:1.0].CGColor;
        _originView.layer.shadowOffset = CGSizeMake(0,2.7);
        _originView.layer.shadowOpacity = 1;
        _originView.layer.shadowRadius = 6.7;
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 18)];
        label.text = @"链接地址";
        label.font = PingFangRegularFont(15);
        label.textColor = MOB_RGB(38, 50, 56);
        [_originView addSubview:label];
        
        self.originTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label.frame) + 15, _originView.frame.size.width - 30, 120)];
        self.originTextView.delegate = self;
        self.originTextView.font = PingFangRegularFont(15);
        self.originTextView.textColor = MOB_RGB(30, 50, 56);
        self.originTextView.layer.borderColor = MOB_RGB(235, 239, 241).CGColor;
        self.originTextView.layer.borderWidth = 1.f;
        self.originTextView.layer.cornerRadius = 6.7;
        [_originView addSubview:self.originTextView];
    }
    return _originView;
}

-(UIView *)changeView
{
    if(!_changeView)
    {
        _changeView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.changeBtn.frame) + 20, ScreenWidth - 30, 150)];
        _changeView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _changeView.layer.shadowColor = [UIColor colorWithRed:235/255.0 green:239/255.0 blue:241/255.0 alpha:1.0].CGColor;
        _changeView.layer.shadowOffset = CGSizeMake(0,2.7);
        _changeView.layer.shadowOpacity = 1;
        _changeView.layer.shadowRadius = 6.7;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 18)];
        label.text = @"已替换地址";
        label.font = PingFangRegularFont(15);
        label.textColor = MOB_RGB(38, 50, 56);
        [_changeView addSubview:label];
        
        self.changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label.frame) , _changeView.frame.size.width - 30, 112)];
        self.changeLabel.numberOfLines = 0;
        self.changeLabel.textColor = MOB_RGB(84, 110, 122);
        self.changeLabel.font = PingFangRegularFont(15);
        [_changeView addSubview:self.changeLabel];
    }
    return _changeView;
}

-(UIView *)bottomView
{
    if(!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 50 - BottomMargin, ScreenWidth, 50+BottomMargin)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIButton *webButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth / 2, 50)];
        [webButton setTitle:@"WebView跳转" forState:UIControlStateNormal];
        [webButton setTitleColor:MOB_RGB(0, 154, 158) forState:UIControlStateNormal];
        webButton.titleLabel.font = PingFangMediumFont(14);
        [webButton setBackgroundColor:[UIColor whiteColor]];
        [webButton addTarget:self action:@selector(webAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:webButton];
        
        UIButton *outButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2, 50)];
        [outButton setTitle:@"外部浏览器跳转" forState:UIControlStateNormal];
        [outButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        outButton.titleLabel.font = PingFangMediumFont(14);
        [outButton setBackgroundColor:MOB_RGB(0, 154, 158)];
        [outButton addTarget:self action:@selector(outWebAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:outButton];
        
    }
    return _bottomView;
}

-(UIButton *)changeBtn
{
    if(!_changeBtn)
    {
        _changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 97.5, CGRectGetMaxY(self.originView.frame) + 20, 195, 40)];
        [_changeBtn setTitle:@"替换" forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_changeBtn setBackgroundColor:MOB_RGB(0, 154, 158)];
        _changeBtn.layer.cornerRadius = 20.f;
        _changeBtn.layer.masksToBounds = YES;
        _changeBtn.titleLabel.font = PingFangMediumFont(14);
        [_changeBtn addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBtn;
}

-(UIButton *)openAppBtn
{
    if(!_openAppBtn)
    {
        _openAppBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHeight - 50 - BottomMargin, ScreenWidth, 50+BottomMargin)];
        [_openAppBtn setTitle:@"通过链接唤起APP" forState:UIControlStateNormal];
        [_openAppBtn setBackgroundColor:[UIColor whiteColor]];
        [_openAppBtn setTitleColor:MOB_RGB(0, 154, 158) forState:UIControlStateNormal];
        _openAppBtn.titleLabel.font = PingFangMediumFont(14);
        [_openAppBtn addTarget:self action:@selector(openAppAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openAppBtn;
}

-(void)changeAction
{
    [self.originTextView resignFirstResponder];
    NSString *idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *newString = self.originTextView.text;
    if([newString containsString:@"idfa"])
    {
        newString = [newString stringByReplacingOccurrencesOfString:@"idfa" withString:idfaStr];
    }
    if([newString containsString:@"IDFA"])
    {
        newString = [newString stringByReplacingOccurrencesOfString:@"IDFA" withString:idfaStr];
    }
    self.changeLabel.text = newString;
}

-(void)webAction
{
    NSURL *url = [NSURL URLWithString:self.changeLabel.text];
    if([[UIApplication sharedApplication] canOpenURL:url])
    {
        self.hidesBottomBarWhenPushed = YES;
        MobADWkWebViewController *vc = [[MobADWkWebViewController alloc] init];
        [vc loadWebViewWithURL:url];
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        [HUDManager showTextHud:@"url无效"];
    }
    
}

-(void)outWebAction
{
    NSURL *url = [NSURL URLWithString:self.changeLabel.text];
    if([[UIApplication sharedApplication] canOpenURL:url])
    {
        if (@available(iOS 10.0, *))
        {
            [[UIApplication sharedApplication] openURL:url options: @{} completionHandler:^(BOOL success) {
                
            }];
        }else
        {
            [[UIApplication sharedApplication] openURL:url];
        }
    }else
    {
        [HUDManager showTextHud:@"url不合法!"];
    }
}

-(void)openAppAction
{
    NSURL *url = [NSURL URLWithString:self.changeLabel.text];
    if (@available(iOS 10.0, *))
    {
        [[UIApplication sharedApplication] openURL:url options: @{} completionHandler:^(BOOL success) {
            if(!success)
            {
                [HUDManager showTextHud:@"暂不支持该链接!"];
            }
        }];
    }else
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([self.originTextView.text isEqualToString:@"请输入url(需要携带http://或者https://)"] || [self.originTextView.text isEqualToString:@"请输入DeepLink"])
    {
        self.originTextView.text = @"";
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.originTextView resignFirstResponder];
}

@end
