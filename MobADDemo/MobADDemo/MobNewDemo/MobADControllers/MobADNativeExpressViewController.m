//
//  MobADNativeExpressViewController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/15.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADNativeExpressViewController.h"
#import "MobADContentTableView.h"
#import <MobAD/MobAD.h>
#import "HUDManager.h"

#import "MobADContentTableViewCell.h"
#import "MobADNativeIDTableViewCell.h"
#import "MobADNativeSwitchTableViewCell.h"

static NSString * const ContentCell = @"MobADContentTableViewCell";
static NSString * const ADIDCell = @"MobADNativeIDTableViewCell";
static NSString * const SwitchCell = @"MobADNativeSwitchTableViewCell";

@interface MobADNativeExpressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) NSMutableArray *contentArray;

@property (strong, nonatomic) UIView *nativeExpressView;

@property (strong, nonatomic) MOBADNativeExpressAdView *expressView;

@end

@implementation MobADNativeExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"原生模版广告";
    self.view.backgroundColor = MOB_RGB(250, 250, 250);
    
    self.dataArray = @[@"广告位ID:",@"自定义模版边距:",@"广告背景颜色:",@"标题字体颜色:",@"标题字体大小:",@"详情字体颜色:",@"详情字体大小:",@"logo文字颜色:",@"logo文字字体大小:",@"logo图标宽度:",@"logo图标高度:",@"图片圆角:",@"隐藏关闭按钮:",@"加载原生模版"];
    
    self.contentArray = [NSMutableArray arrayWithObjects:kSNativeExpressPID,@"10",@"#FFFFFF",@"#000000",@"14",@"#000000",@"14",@"#000000",@"14",@"38",@"14",@"0.0", nil];
    
    
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        CGFloat tableViewHeight = 60 * self.dataArray.count;
        if(tableViewHeight > (ScreenHeight - 20 - NavigationBarHeight))
        {
            tableViewHeight = ScreenHeight - 20 - NavigationBarHeight;
        }
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 10 + NavigationBarHeight, ScreenWidth - 30, tableViewHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:ContentCell bundle:nil] forCellReuseIdentifier:ContentCell];
        [_tableView registerNib:[UINib nibWithNibName:ADIDCell bundle:nil] forCellReuseIdentifier:ADIDCell];
        [_tableView registerNib:[UINib nibWithNibName:SwitchCell bundle:nil] forCellReuseIdentifier:SwitchCell];
        
        _tableView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _tableView.layer.cornerRadius = 3.3;
        _tableView.layer.shadowColor = [UIColor colorWithRed:235/255.0 green:239/255.0 blue:241/255.0 alpha:1.0].CGColor;
        _tableView.layer.shadowOffset = CGSizeMake(0,2.7);
        _tableView.layer.shadowOpacity = 1;
        _tableView.layer.shadowRadius = 6.7;
        
    }
    return _tableView;
}

-(UIView *)nativeExpressView
{
    if(!_nativeExpressView)
    {
        _nativeExpressView = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight + 10, ScreenHeight , 10)];
        _nativeExpressView.backgroundColor = [UIColor redColor];
        _nativeExpressView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _nativeExpressView.layer.cornerRadius = 3.3;
        _nativeExpressView.layer.shadowColor = [UIColor colorWithRed:235/255.0 green:239/255.0 blue:241/255.0 alpha:1.0].CGColor;
        _nativeExpressView.layer.shadowOffset = CGSizeMake(0,2.7);
        _nativeExpressView.layer.shadowOpacity = 1;
        _nativeExpressView.layer.shadowRadius = 6.7;
    }
    return _nativeExpressView;
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.dataArray.count - 2)
    {
        MobADNativeIDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADIDCell];
        cell.titleLabel.text = self.dataArray[indexPath.row];
        cell.textFiledl.text = self.contentArray[indexPath.row];
        cell.getTextBlock = ^(NSString * _Nonnull text) {
            [self changeCustomDataWithText:text index:indexPath.row];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        if(indexPath.row == self.dataArray.count - 2)
        {
            MobADNativeSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SwitchCell];
            cell.titleLabel.text = self.dataArray[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
            MobADContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ContentCell];
            cell.titleLabel.text = self.dataArray[indexPath.row];
            cell.iconImgView.image = [UIImage imageNamed:@"icon_load"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
}

-(void)changeCustomDataWithText:(NSString *)text index:(NSInteger)index
{
    [self.contentArray replaceObjectAtIndex:index withObject:text];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == self.dataArray.count - 1)
    {
        [self loadNativeExpressAD];
    }
}

#pragma mark load AD
-(void)loadNativeExpressAD
{
    [HUDManager showLoading];
    [self.nativeExpressView removeFromSuperview];
    self.nativeExpressView = nil;
    CGFloat edge = 10;
    if([self isPureFloat:self.contentArray[1]])
    {
        edge = [self.contentArray[1] floatValue];
    }
    UIColor *backColor = [self colorWithHexString:self.contentArray[2] alpha:1];
    UIColor *titleColor = [self colorWithHexString:self.contentArray[3] alpha:1];
    UIFont *titleFont = [UIFont systemFontOfSize:14];
    if([self isPureFloat:self.contentArray[4]])
    {
        titleFont = [UIFont systemFontOfSize:[self.contentArray[4] floatValue]];
    }
    UIColor *detailColor = [self colorWithHexString:self.contentArray[5] alpha:1];
    UIFont *detialFont = [UIFont systemFontOfSize:14];
    if([self isPureFloat:self.contentArray[6]])
    {
        detialFont = [UIFont systemFontOfSize:[self.contentArray[6] floatValue]];
    }
    UIColor *logoColor = [self colorWithHexString:self.contentArray[7] alpha:1];
    UIFont *logoFont = [UIFont systemFontOfSize:14];
    if([self isPureFloat:self.contentArray[8]])
    {
        logoFont = [UIFont systemFontOfSize:[self.contentArray[8] floatValue]];
    }
    CGFloat logoWidth = 38;
    CGFloat logoHeight = 14;
    if([self isPureFloat:self.contentArray[9]])
    {
        logoWidth = [self.contentArray[9] floatValue];
    }
    if([self isPureFloat:self.contentArray[10]])
    {
        logoHeight = [self.contentArray[10] floatValue];
    }
    CGFloat radius = 0.0;
    if([self isPureFloat:self.contentArray[11]])
    {
        radius = [self.contentArray[11] floatValue];
    }
    [MobAD nativeExpressAdWithPlacementId:self.contentArray[0] adSize:CGSizeMake(ScreenWidth, 0) edgeInsets:UIEdgeInsetsMake(edge, edge, edge, edge) backgroundColor:backColor titleFont:titleFont titleColor:titleColor contentFont:detialFont contentColor:detailColor tipFont:logoFont tipColor:logoColor imageViewCornerRadius:radius hideCloseButton:YES adIconSize:CGSizeMake(logoWidth, logoHeight) adViewsCallback:^(NSArray<MOBADNativeExpressAdView *> *nativeExpressAdViews, NSError *error) {
        for (MOBADNativeExpressAdView *expressView in nativeExpressAdViews) {
            expressView.controller = self;
            [expressView render];
        }
        self.expressView = nativeExpressAdViews[0];
        
    } eCPMCallback:^(NSInteger eCPM) {
        
    } stateCallback:^(id adObject, MADState state, NSError *error) {
        [HUDManager hidenHud];
        if(error)
        {
            [HUDManager showTextHud:error.localizedDescription];
        }
        NSLog(@"%@",self.nativeExpressView);
        if(state == MADStateViewRenderSuccess)
        {
            [UIView animateWithDuration:0.3f animations:^{
                self.nativeExpressView.frame = CGRectMake(0, NavigationBarHeight + 10, ScreenHeight, self.expressView.adView.bounds.size.height);
                [self.nativeExpressView addSubview:self.expressView.adView];
                [self.view addSubview:self.nativeExpressView];
                
                CGFloat tableViewHeight = 60 * self.dataArray.count;
                if(tableViewHeight > (ScreenHeight - 20 - CGRectGetMaxY(self.nativeExpressView.frame)))
                {
                    tableViewHeight = ScreenHeight - 20 - CGRectGetMaxY(self.nativeExpressView.frame);
                }
                self.tableView.frame = CGRectMake(15, 10 + CGRectGetMaxY(self.nativeExpressView.frame), ScreenWidth - 30, tableViewHeight);
            }];
            
        }
        
        if(state == MADStateDidClose)
        {
            [UIView animateWithDuration:0.3f animations:^{
                [self.nativeExpressView removeFromSuperview];
                self.nativeExpressView = nil;
                CGFloat tableViewHeight = 60 * self.dataArray.count;
                if(tableViewHeight > (ScreenHeight - 20 - NavigationBarHeight))
                {
                    tableViewHeight = ScreenHeight - 20 - NavigationBarHeight;
                }
                self.tableView.frame = CGRectMake(15, 10 + NavigationBarHeight, ScreenWidth - 30, tableViewHeight);
            }];
          
        }
    } dislikeCallback:^(id adObject, NSArray<NSString *> *reasons) {
        
    }];
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

//判断字符串是否为浮点数
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


@end
