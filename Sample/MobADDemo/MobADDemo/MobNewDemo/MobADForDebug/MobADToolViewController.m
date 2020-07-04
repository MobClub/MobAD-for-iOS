//
//  MobADToolViewController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/11.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADToolViewController.h"
#import "MobADToolTableViewCell.h"
#import "MobADToolLinkViewController.h"

static NSString *const ToolCell = @"MobADToolTableViewCell";

@interface MobADToolViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *listArray;

@property (copy, nonatomic) NSArray *iconArray;

@end

@implementation MobADToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MOB_RGB(250, 250, 250);
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.listArray = @[@"Link跳转",@"DeepLink跳转"];
    self.iconArray = @[@"icon_link",@"icon_deeplink"];
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = MOB_RGB(250, 250, 250);
        [_tableView registerNib:[UINib nibWithNibName:ToolCell bundle:nil] forCellReuseIdentifier:ToolCell];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MobADToolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ToolCell];
    cell.iconImgView.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
    cell.titleLabel.text = self.listArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        self.hidesBottomBarWhenPushed = YES;
        MobADToolLinkViewController *linkVc = [[MobADToolLinkViewController alloc] init];
        [linkVc isDeepLink:NO];
        [self.navigationController pushViewController:linkVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if(indexPath.row == 1)
       {
           self.hidesBottomBarWhenPushed = YES;
           MobADToolLinkViewController *linkVc = [[MobADToolLinkViewController alloc] init];
           [linkVc isDeepLink:YES];
           [self.navigationController pushViewController:linkVc animated:YES];
           self.hidesBottomBarWhenPushed = NO;
       }
}

@end
