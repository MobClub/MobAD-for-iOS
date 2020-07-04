//
//  MobADDeviceAlertView.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/12.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADDeviceAlertView.h"
#import <AdSupport/AdSupport.h>

@implementation MobADDeviceAlertView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 50, 20, 100, 16)];
        label.text = @"设备标识";
        label.font = PingFangSemiboldFont(16);
        label.textColor = MOB_RGB(38, 50, 56);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UILabel *idfaLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label.frame) + 20, self.frame.size.width - 30, 40)];
        idfaLabel.font = PingFangRegularFont(15);
        idfaLabel.textColor = MOB_RGB(38, 50, 56);
        idfaLabel.numberOfLines = 0;
        NSString *idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        idfaLabel.text = [NSString stringWithFormat:@"idfa:%@",idfaStr];
        [self addSubview:idfaLabel];
        
        UIButton *copyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(idfaLabel.frame) + 20, self.frame.size.width / 2, 50.f)];
        [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
        [copyBtn addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
        [copyBtn setTitleColor:MOB_RGB(0, 154, 158) forState:UIControlStateNormal];
        copyBtn.titleLabel.font = PingFangMediumFont(14);
        [self addSubview:copyBtn];
        
        UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(copyBtn.frame), CGRectGetMaxY(idfaLabel.frame) + 20, self.frame.size.width / 2, 50.f)];
        [okBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [okBtn setBackgroundColor:MOB_RGB(0, 154, 158)];
        okBtn.titleLabel.font = PingFangMediumFont(14);
        [self addSubview:okBtn];
        
    }
    return self;
}

-(void)copyAction
{
    NSString *idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = idfaStr;
    
    if(self.copyBlock)
    {
        self.copyBlock();
    }
}

-(void)okAction
{
    if(self.dismissBlock)
    {
        self.dismissBlock();
    }
}

@end
