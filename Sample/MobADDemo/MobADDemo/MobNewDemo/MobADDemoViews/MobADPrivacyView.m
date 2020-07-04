//
//  MobADPrivacyView.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/19.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADPrivacyView.h"
#import <WebKit/WebKit.h>

@interface MobADPrivacyView ()<WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation MobADPrivacyView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        self.layer.cornerRadius = 17;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width /2 - 100, 20, 200, 16)];
        label.font = PingFangSemiboldFont(16);
        label.textColor = MOB_RGB(38, 50,56);
        label.text = @"MobAD隐私条款";
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        [self addSubview:self.webView];
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.frame.size.height - 60, (self.frame.size.width - 60) / 2, 40)];
        UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 + 10, self.frame.size.height - 60, (self.frame.size.width - 60) / 2, 40)];
        [cancelBtn setBackgroundColor:MOB_RGB(236, 239, 241)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:MOB_RGB(38, 50, 56) forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = PingFangMediumFont(14);
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        
        [okBtn setBackgroundColor:MOB_RGB(0, 154, 158)];
        [okBtn setTitle:@"同意" forState:UIControlStateNormal];
        [okBtn setTitleColor:MOB_RGB(38, 50, 56) forState:UIControlStateNormal];
        okBtn.titleLabel.font = PingFangMediumFont(14);
        [okBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        
        cancelBtn.layer.cornerRadius = 20.f;
        okBtn.layer.cornerRadius = 20.f;
        cancelBtn.layer.masksToBounds = YES;
        okBtn.layer.masksToBounds = YES;
        
        [self addSubview:cancelBtn];
        [self addSubview:okBtn];
    }
    return self;
}

-(void)loadWebViewWithURL:(NSURL *)url
{
    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(20, 55, self.frame.size.width - 40, self.frame.size.height - 55 - 80) configuration:webConfiguration];
    self.webView.navigationDelegate = self;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [self addSubview:self.webView];
}


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
}

-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
}

-(void)cancelAction
{
    if(self.clickBlock)
    {
        self.clickBlock(NO);
    }
}

-(void)confirmAction
{
    if(self.clickBlock)
    {
        self.clickBlock(YES);
    }
}




@end
