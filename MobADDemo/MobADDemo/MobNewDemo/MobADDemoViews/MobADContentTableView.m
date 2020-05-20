//
//  MobADContentTableView.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/15.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADContentTableView.h"
#import "MobADContentTableViewCell.h"

static NSString *const ContentCell = @"MobADContentTableViewCell";
    
@interface MobADContentTableView () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation MobADContentTableView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        self.layer.cornerRadius = 3.3;
        self.layer.shadowColor = [UIColor colorWithRed:235/255.0 green:239/255.0 blue:241/255.0 alpha:1.0].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,2.7);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 6.7;
    }
    return self;
}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:ContentCell bundle:nil] forCellReuseIdentifier:ContentCell];
        
    }
    return _tableView;
}

-(void)loadTableView
{
    [self addSubview:self.tableView];
}

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
    MobADContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ContentCell];
    cell.iconImgView.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
    cell.titleLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.selectCellBlock)
    {
        self.selectCellBlock(indexPath.row);
    }
}
@end
