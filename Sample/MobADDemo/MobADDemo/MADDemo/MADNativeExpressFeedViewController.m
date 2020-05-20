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
#import "HUDManager.h"


@interface MADNativeExpressFeedViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *pidField;

@property (nonatomic, strong) UITextField *topField;
@property (nonatomic, strong) UITextField *leftField;
@property (nonatomic, strong) UITextField *bottomField;
@property (nonatomic, strong) UITextField *rightField;

@property (nonatomic, strong) UITextField *backTextField;
@property (nonatomic, strong) UITextField *titleColorField;
@property (nonatomic, strong) UITextField *titleFontField;
@property (nonatomic, strong) UITextField *contentColorField;
@property (nonatomic, strong) UITextField *contentFontField;
@property (nonatomic, strong) UITextField *logoColorField;
@property (nonatomic, strong) UITextField *logoFontField;
@property (nonatomic, strong) UITextField *logoImgWidthField;
@property (nonatomic, strong) UITextField *logoImgHeightField;

@property (nonatomic, strong) UISwitch *closeSiwtch;
@property (nonatomic, strong) UITextField *radiusField;


@property (strong, nonatomic) NSMutableArray<__kindof MOBADNativeExpressAdView *> *nativeExpressAdViews;

@property (strong, nonatomic) UIView *nativeExpressView;

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
    
    
    //backColor
    UILabel *backColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(rightField.frame) + 15, 0, 0)];
    backColorLabel.text = @"背景颜色:";
    backColorLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            backColorLabel.textColor = [UIColor whiteColor];
        }
    }
    backColorLabel.textAlignment = NSTextAlignmentLeft;
    [backColorLabel sizeToFit];
    [self.view addSubview:backColorLabel];
    
    self.backTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(backColorLabel.frame) + 5, backColorLabel.frame.origin.y - 4 , 90, 30)];
    self.backTextField.returnKeyType = UIReturnKeyDone;
    self.backTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.backTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.backTextField.text = @"#FFFFFF";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.backTextField.backgroundColor = [UIColor whiteColor];
        }
    }
    self.backTextField.textColor = [UIColor blackColor];
    self.backTextField.delegate = self;
    [self.view addSubview:self.backTextField];
    
    
    //colseButton
    UILabel *closeBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.backTextField.frame) + 15, CGRectGetMaxY(rightField.frame) + 15, 0, 0)];
    closeBtnLabel.text = @"隐藏关闭按钮:";
    closeBtnLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            closeBtnLabel.textColor = [UIColor whiteColor];
        }
    }
    closeBtnLabel.textAlignment = NSTextAlignmentLeft;
    [closeBtnLabel sizeToFit];
    [self.view addSubview:closeBtnLabel];
    
    self.closeSiwtch = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(closeBtnLabel.frame) + 5,closeBtnLabel.frame.origin.y - 4 ,60, 30)];
    self.closeSiwtch.on = NO;
    [self.view addSubview:self.closeSiwtch];
    
    
    //title
    UILabel *titleColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(backColorLabel.frame) + 15, 0, 0)];
    titleColorLabel.text = @"标题颜色:";
    titleColorLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            titleColorLabel.textColor = [UIColor whiteColor];
        }
    }
    titleColorLabel.textAlignment = NSTextAlignmentLeft;
    [titleColorLabel sizeToFit];
    [self.view addSubview:titleColorLabel];
    
    self.titleColorField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleColorLabel.frame) + 5, titleColorLabel.frame.origin.y - 4 , 90, 30)];
    self.titleColorField.returnKeyType = UIReturnKeyDone;
    self.titleColorField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.titleColorField.borderStyle = UITextBorderStyleRoundedRect;
    self.titleColorField.text = @"#000000";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.titleColorField.backgroundColor = [UIColor whiteColor];
        }
    }
    self.titleColorField.textColor = [UIColor blackColor];
    self.titleColorField.delegate = self;
    [self.view addSubview:self.titleColorField];
    
    UILabel *titleFontLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleColorField.frame) + 15, CGRectGetMaxY(backColorLabel.frame) + 15, 0, 0)];
    titleFontLabel.text = @"标题字体大小:";
    titleFontLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            titleFontLabel.textColor = [UIColor whiteColor];
        }
    }
    titleFontLabel.textAlignment = NSTextAlignmentLeft;
    [titleFontLabel sizeToFit];
    [self.view addSubview:titleFontLabel];
    
    self.titleFontField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleFontLabel.frame) + 5, titleFontLabel.frame.origin.y - 4 , 40, 30)];
    self.titleFontField.returnKeyType = UIReturnKeyDone;
    self.titleFontField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.titleFontField.borderStyle = UITextBorderStyleRoundedRect;
    self.titleFontField.text = @"14";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.titleFontField.backgroundColor = [UIColor whiteColor];
        }
    }
    self.titleFontField.textColor = [UIColor blackColor];
    self.titleFontField.delegate = self;
    [self.view addSubview:self.titleFontField];
    
    
    //content
    UILabel *contentColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleColorLabel.frame) + 15, 0, 0)];
    contentColorLabel.text = @"详情颜色:";
    contentColorLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            contentColorLabel.textColor = [UIColor whiteColor];
        }
    }
    contentColorLabel.textAlignment = NSTextAlignmentLeft;
    [contentColorLabel sizeToFit];
    [self.view addSubview:contentColorLabel];
    
    
    self.contentColorField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentColorLabel.frame) + 5, contentColorLabel.frame.origin.y - 4 , 90, 30)];
    self.contentColorField.returnKeyType = UIReturnKeyDone;
    self.contentColorField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.contentColorField.borderStyle = UITextBorderStyleRoundedRect;
    self.contentColorField.text = @"#000000";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.contentColorField.backgroundColor = [UIColor whiteColor];
        }
    }
    self.contentColorField.textColor = [UIColor blackColor];
    self.contentColorField.delegate = self;
    [self.view addSubview:self.contentColorField];
    
    UILabel *contentFontLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contentColorField.frame) + 15, CGRectGetMaxY(titleColorLabel.frame) + 15, 0, 0)];
    contentFontLabel.text = @"详情字体大小:";
    contentFontLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            contentFontLabel.textColor = [UIColor whiteColor];
        }
    }
    contentFontLabel.textAlignment = NSTextAlignmentLeft;
    [contentFontLabel sizeToFit];
    [self.view addSubview:contentFontLabel];
    
    self.contentFontField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contentFontLabel.frame) + 5, contentColorLabel.frame.origin.y - 4 , 40, 30)];
    self.contentFontField.returnKeyType = UIReturnKeyDone;
    self.contentFontField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.contentFontField.borderStyle = UITextBorderStyleRoundedRect;
    self.contentFontField.text = @"14";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.contentFontField.backgroundColor = [UIColor whiteColor];
        }
    }
    self.contentFontField.textColor = [UIColor blackColor];
    self.contentFontField.delegate = self;
    [self.view addSubview:self.contentFontField];
    
    
    //广告logo文字
    UILabel *logoColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(contentColorLabel.frame) + 15, 0, 0)];
    logoColorLabel.text = @"logo文字颜色:";
    logoColorLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            logoColorLabel.textColor = [UIColor whiteColor];
        }
    }
    logoColorLabel.textAlignment = NSTextAlignmentLeft;
    [logoColorLabel sizeToFit];
    [self.view addSubview:logoColorLabel];
    
    
    self.logoColorField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoColorLabel.frame) + 5, logoColorLabel.frame.origin.y - 4 , 90, 30)];
    self.logoColorField.returnKeyType = UIReturnKeyDone;
    self.logoColorField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.logoColorField.borderStyle = UITextBorderStyleRoundedRect;
    self.logoColorField.text = @"#000000";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.logoColorField.backgroundColor = [UIColor whiteColor];
        }
    }
    self.logoColorField.textColor = [UIColor blackColor];
    self.logoColorField.delegate = self;
    [self.view addSubview:self.logoColorField];
    
    UILabel *logoFontLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.logoColorField.frame) + 15, CGRectGetMaxY(contentColorLabel.frame) + 15, 0, 0)];
    logoFontLabel.text = @"logo文字大小:";
    logoFontLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            logoFontLabel.textColor = [UIColor whiteColor];
        }
    }
    logoFontLabel.textAlignment = NSTextAlignmentLeft;
    [logoFontLabel sizeToFit];
    [self.view addSubview:logoFontLabel];
    
    self.logoFontField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoFontLabel.frame) + 5, logoFontLabel.frame.origin.y - 4 , 40, 30)];
    self.logoFontField.returnKeyType = UIReturnKeyDone;
    self.logoFontField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.logoFontField.borderStyle = UITextBorderStyleRoundedRect;
    self.logoFontField.text = @"14";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.logoFontField.backgroundColor = [UIColor whiteColor];
        }
    }
    self.logoFontField.textColor = [UIColor blackColor];
    self.logoFontField.delegate = self;
    [self.view addSubview:self.logoFontField];
    
    //广告logo大小
    UILabel *logoWidthLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(logoColorLabel.frame) + 15, 0, 0)];
    logoWidthLabel.text = @"logo宽度:";
    logoWidthLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            logoWidthLabel.textColor = [UIColor whiteColor];
        }
    }
    logoWidthLabel.textAlignment = NSTextAlignmentLeft;
    [logoWidthLabel sizeToFit];
    [self.view addSubview:logoWidthLabel];
    
    
    self.logoImgWidthField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoWidthLabel.frame) + 5, logoWidthLabel.frame.origin.y - 4 , 90, 30)];
    self.logoImgWidthField.returnKeyType = UIReturnKeyDone;
    self.logoImgWidthField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.logoImgWidthField.borderStyle = UITextBorderStyleRoundedRect;
    self.logoImgWidthField.text = @"38";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.logoColorField.backgroundColor = [UIColor whiteColor];
        }
    }
    self.logoImgWidthField.textColor = [UIColor blackColor];
    self.logoImgWidthField.delegate = self;
    [self.view addSubview:self.logoImgWidthField];
    
    UILabel *logoHeightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.logoImgWidthField.frame) + 15, CGRectGetMaxY(logoColorLabel.frame) + 15, 0, 0)];
    logoHeightLabel.text = @"logo高度:";
    logoHeightLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            logoHeightLabel.textColor = [UIColor whiteColor];
        }
    }
    logoHeightLabel.textAlignment = NSTextAlignmentLeft;
    [logoHeightLabel sizeToFit];
    [self.view addSubview:logoHeightLabel];
    
    self.logoImgHeightField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoHeightLabel.frame) + 5, logoHeightLabel.frame.origin.y - 4 , 90, 30)];
    self.logoImgHeightField.returnKeyType = UIReturnKeyDone;
    self.logoImgHeightField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.logoImgHeightField.borderStyle = UITextBorderStyleRoundedRect;
    self.logoImgHeightField.text = @"14";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.logoImgHeightField.backgroundColor = [UIColor whiteColor];
        }
    }
    self.logoImgHeightField.textColor = [UIColor blackColor];
    self.logoImgHeightField.delegate = self;
    [self.view addSubview:self.logoImgHeightField];
    
    //图片圆角
    UILabel *radiusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(logoWidthLabel.frame) + 15, 0, 0)];
    radiusLabel.text = @"图片圆角:";
    radiusLabel.textColor = [UIColor blackColor];
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            radiusLabel.textColor = [UIColor whiteColor];
        }
    }
    radiusLabel.textAlignment = NSTextAlignmentLeft;
    [radiusLabel sizeToFit];
    [self.view addSubview:radiusLabel];
    
    self.radiusField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(radiusLabel.frame) + 5, radiusLabel.frame.origin.y - 4 , 90, 30)];
    self.radiusField.returnKeyType = UIReturnKeyDone;
    self.radiusField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.radiusField.borderStyle = UITextBorderStyleRoundedRect;
    self.radiusField.text = @"0.0";
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.radiusField.backgroundColor = [UIColor whiteColor];
        }
    }
    self.radiusField.textColor = [UIColor blackColor];
    self.radiusField.delegate = self;
    [self.view addSubview:self.radiusField];
    
    
    //loadBtn
    MobADNormalButton *loadBtn = [[MobADNormalButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.radiusField.frame) + 15, 0, 0)];
    self.loadButton = loadBtn;
    loadBtn.center = CGPointMake(self.view.center.x, loadBtn.center.y);
    loadBtn.showRefreshIncon = YES;
    [loadBtn setTitle:@"拉取广告" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    
    self.nativeExpressView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(loadBtn.frame) + 5, ScreenWidth, ScreenHeight - (CGRectGetMaxY(loadBtn.frame) + 5))];
    //[self.view addSubview:self.nativeExpressView];
    
    
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

- (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    hexString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    NSRegularExpression *RegEx = [NSRegularExpression regularExpressionWithPattern:@"^[a-fA-F|0-9]{6}$" options:0 error:nil];
    NSUInteger match = [RegEx numberOfMatchesInString:hexString options:NSMatchingReportCompletion range:NSMakeRange(0, hexString.length)];

    if (match == 0) {return [UIColor clearColor];}

    NSString *rString = [hexString substringWithRange:NSMakeRange(0, 2)];
    NSString *gString = [hexString substringWithRange:NSMakeRange(2, 2)];
    NSString *bString = [hexString substringWithRange:NSMakeRange(4, 2)];
    unsigned int r, g, b;
    BOOL rValue = [[NSScanner scannerWithString:rString] scanHexInt:&r];
    BOOL gValue = [[NSScanner scannerWithString:gString] scanHexInt:&g];
    BOOL bValue = [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    if (rValue && gValue && bValue) {
        return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:alpha];
    } else {
        return [UIColor clearColor];
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


//判断字符串是否为浮点数
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


- (void)loadData
{
    if(self.nativeExpressAdViews.count > 0)
    {
        MOBADNativeExpressAdView *expressView = self.nativeExpressAdViews[0];
        [expressView.adView removeFromSuperview];
    }
    
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
    
    UIColor *backColor = [self colorWithHexString:self.backTextField.text alpha:1];
    UIColor *titleColor = [self colorWithHexString:self.titleColorField.text alpha:1];
    UIColor *contentColor = [self colorWithHexString:self.contentColorField.text alpha:1];
    UIColor *logoColor = [self colorWithHexString:self.logoColorField.text alpha:1];
    UIFont *titleFont = [UIFont systemFontOfSize:14.f];
    if([self isPureFloat:self.titleFontField.text])
    {
        titleFont = [UIFont systemFontOfSize:[self.titleFontField.text floatValue]];
    }
    UIFont *contentFont = [UIFont systemFontOfSize:13.f];
    if([self isPureFloat:self.contentFontField.text])
    {
        contentFont = [UIFont systemFontOfSize:[self.contentFontField.text floatValue]];
    }
    UIFont *logoFont = [UIFont systemFontOfSize:13.f];
    if([self isPureFloat:self.logoFontField.text])
    {
        logoFont = [UIFont systemFontOfSize:[self.logoFontField.text floatValue]];
    }
    CGFloat logoWidth = 38;
    CGFloat logoHeight = 14;
    if([self isPureFloat:self.logoImgWidthField.text])
    {
        logoWidth = [self.logoImgWidthField.text floatValue];
    }
    if([self isPureFloat:self.logoImgHeightField.text])
    {
        logoHeight = [self.logoImgHeightField.text floatValue];
    }
    
    
    CGFloat radius = 0;
    if([self isPureFloat:self.radiusField.text])
    {
        radius = [self.radiusField.text floatValue];
    }
    
    [MobAD nativeExpressAdWithPlacementId:self.pidField.text adSize:CGSizeMake(ScreenWidth, 0) edgeInsets:UIEdgeInsetsMake(top, left, bottom, right) backgroundColor:backColor titleFont:titleFont titleColor:titleColor contentFont:contentFont contentColor:contentColor tipFont:logoFont tipColor:logoColor imageViewCornerRadius:radius hideCloseButton:self.closeSiwtch.isOn adIconSize:CGSizeMake(logoWidth, logoHeight) adViewsCallback:^(NSArray<MOBADNativeExpressAdView *> *nativeExpressAdViews, NSError *error) {
        if (error) {
            if(error.code == 233)
            {
                [HUDManager showTextHud:error.localizedDescription afterDelay:1.5f];
            }
            return;
        }
        [weakSelf.nativeExpressAdViews removeAllObjects];
        if (nativeExpressAdViews.count > 0) {
            [weakSelf.nativeExpressAdViews addObjectsFromArray:nativeExpressAdViews];
            for (MOBADNativeExpressAdView *expressView in weakSelf.nativeExpressAdViews) {
                expressView.controller = weakSelf;
                [expressView render];
            }
        }
        [weakSelf.tableView reloadData];
    } eCPMCallback:^(NSInteger eCPM) {
        NSLog(@"---> eCPM: %ld", (long)eCPM);
    } stateCallback:^(id adObject, MADState state, NSError *error) {
        if(error)
        {
            [HUDManager showTextHud:error.localizedDescription afterDelay:1.5f];
             weakSelf.loadButton.enabled = YES;
        }
        if (state == MADStateDidClose) {
            MOBADNativeExpressAdView *expressView = weakSelf.nativeExpressAdViews[0];
            [expressView.adView removeFromSuperview];

        }
        if(state == MADStateDidExposure || state == MADStateDidVisible || state == MADStateWillVisible)
        {
            weakSelf.loadButton.enabled = YES;
        }
    } dislikeCallback:^(id adObject, NSArray<NSString *> *reasons) {
        MOBADNativeExpressAdView *expressView = weakSelf.nativeExpressAdViews[0];
        [expressView.adView removeFromSuperview];
    }];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MOBADNativeExpressAdView *view = self.nativeExpressAdViews[indexPath.row];
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
    
    MOBADNativeExpressAdView *view = [self.nativeExpressAdViews objectAtIndex:indexPath.row];
    view.adView.tag = 1000;
//    cell.contentView.backgroundColor = [UIColor cyanColor];
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



- (NSMutableArray<MOBADNativeExpressAdView *> *)nativeExpressAdViews
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

-(void)testAction
{
    MOBADNativeExpressAdView *expressView = self.nativeExpressAdViews[0];
    [self.nativeExpressView addSubview:expressView.adView];
}

@end
