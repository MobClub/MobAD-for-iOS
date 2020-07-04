//
//  MobADWkWebViewController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/18.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADWkWebViewController.h"
#import <WebKit/WebKit.h>
#import "HUDManager.h"

@interface MobADWkWebViewController ()<WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation MobADWkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)loadWebViewWithURL:(NSURL *)url
{
    [HUDManager showLoading];
    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    self.webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:webConfiguration];
    self.webView.navigationDelegate = self;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [HUDManager hidenHud];
}

-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [HUDManager hidenHud];
    [HUDManager showTextHud:error.localizedDescription];
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    [HUDManager hidenHud];
    [HUDManager showTextHud:error.localizedDescription];
}



@end
