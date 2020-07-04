//
//  MobADAboutViewController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/12.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADAboutViewController.h"
#import "MobADAboutTableViewCell.h"


@interface MobADAboutViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIView *topView;

@property (strong, nonatomic) UIView *bottomView;

@property (strong, nonatomic) UILabel *label1;

@property (strong, nonatomic) UILabel *detail1;

@property (strong, nonatomic) UILabel *label2;

@property (strong, nonatomic) UILabel *detail2;

@property (strong, nonatomic) UILabel *labelTable;

@property (copy, nonatomic) NSArray *listArray;

@property (copy, nonatomic) NSArray *dateArray;

@end

@implementation MobADAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MOB_RGB(250, 250, 250);
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.title = @"关于MobAD";
    self.listArray = @[@"MobAD SDK版本 V2.1.5",@"MobAD SDK版本 V2.1.4"];
    self.dateArray = @[@"2020年5月4日",@"2020年4月28日"];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
}



-(UIView *)topView
{
    if(!_topView)
    {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(10, 10 + NavigationBarHeight, ScreenWidth - 20, 115)];
        _topView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _topView.layer.cornerRadius = 3.3;
        _topView.layer.shadowColor = [UIColor colorWithRed:235/255.0 green:239/255.0 blue:241/255.0 alpha:1.0].CGColor;
        _topView.layer.shadowOffset = CGSizeMake(0,2.7);
        _topView.layer.shadowOpacity = 1;
        _topView.layer.shadowRadius = 6.7;
        
        self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 65, 18)];
        self.label1.textColor = MOB_RGB(38, 50, 56);
        self.label1.font = PingFangRegularFont(15);
        self.label1.text = @"SDK版本";
        [_topView addSubview:self.label1];
        
        self.detail1 = [[UILabel alloc] initWithFrame:CGRectMake(_topView.frame.size.width - 80, 20, 65, 18)];
        self.detail1.textColor = MOB_RGB(84, 110, 122);
        self.detail1.font = PingFangRegularFont(15);
        self.detail1.text = @"v2.1.7";
        self.detail1.textAlignment = NSTextAlignmentRight;
        [_topView addSubview:self.detail1];
        
        self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 65, 18)];
        self.label2.textColor = MOB_RGB(38, 50, 56);
        self.label2.font = PingFangRegularFont(15);
        self.label2.text = @"更新时间";
        [_topView addSubview:self.label2];
        
        self.detail2 = [[UILabel alloc] initWithFrame:CGRectMake(_topView.frame.size.width - 135, 70, 120, 18)];
        self.detail2.textColor = MOB_RGB(84, 110, 122);
        self.detail2.font = PingFangRegularFont(15);
        self.detail2.text = @"2020年6月4日";
        self.detail2.textAlignment = NSTextAlignmentRight;
        [_topView addSubview:self.detail2];
        
    }
    return _topView;
}

-(UIView *)bottomView
{
    if(!_bottomView)
    {
        CGFloat viewHeight = 80 * self.listArray.count + 30;
        if(viewHeight > self.view.frame.size.height - CGRectGetMaxY(self.topView.frame) - 20.f - BottomMargin)
        {
            viewHeight =  - CGRectGetMaxY(self.topView.frame) - 20.f - BottomMargin;
        }
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.topView.frame) + 10, ScreenWidth - 20, viewHeight)];
        _bottomView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _bottomView.layer.cornerRadius = 3.3;
        _bottomView.layer.shadowColor = [UIColor colorWithRed:235/255.0 green:239/255.0 blue:241/255.0 alpha:1.0].CGColor;
        _bottomView.layer.shadowOffset = CGSizeMake(0,2.7);
        _bottomView.layer.shadowOpacity = 1;
        _bottomView.layer.shadowRadius = 6.7;
        
        self.labelTable = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 18)];
        self.labelTable.text = @"更新日志";
        self.labelTable.textColor = MOB_RGB(39, 50, 56);
        self.labelTable.font = PingFangRegularFont(15);
        
        [_bottomView addSubview:self.labelTable];
        [_bottomView addSubview:self.tableView];
        
    }
    return _bottomView;
}


-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.labelTable.frame), self.bottomView.frame.size.width, self.bottomView.frame.size.height - self.labelTable.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"MobADAboutTableViewCell" bundle:nil] forCellReuseIdentifier:@"MobADAboutTableViewCell"];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"MobADAboutTableViewCell";
    MobADAboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    cell.versionLabel.text = self.listArray[indexPath.row];
    cell.dateLabel.text = self.dateArray[indexPath.row];
    if(indexPath.row == self.listArray.count - 1)
    {
        cell.lineView.hidden = YES;
    }
    return cell;
}


@end
