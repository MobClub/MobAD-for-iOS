//
//  MobADNormalButton.m
//  MobADDemo
//
//  Created by Sands_Lee on 2019/9/5.
//  Copyright © 2019 Max. All rights reserved.
//

#import "MobADNormalButton.h"

#define buttonHeight 40
#define leftEdge 30


@implementation MobADNormalButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(leftEdge, frame.origin.y, MOBMINScreenSide-2*leftEdge, buttonHeight)];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundColor:mainColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(void)setShowRefreshIncon:(BOOL)showRefreshIncon {
    _showRefreshIncon = showRefreshIncon;
    if (showRefreshIncon) {
        [self setImage:[UIImage imageNamed:@"shuaxin.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"shuaxin.png"] forState:UIControlStateHighlighted];
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    }
}

@end
