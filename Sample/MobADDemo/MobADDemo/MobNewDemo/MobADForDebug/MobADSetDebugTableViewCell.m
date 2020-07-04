//
//  MobADSetDebugTableViewCell.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/13.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADSetDebugTableViewCell.h"

@interface MobADSetDebugTableViewCell ()<UITextFieldDelegate>

@end

@implementation MobADSetDebugTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.apiTextField.delegate = self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellStyleSwitch
{
    self.closeBtn.hidden = YES;
    self.apiTextField.hidden = YES;
}

-(void)setCellStyleTextField
{
    self.debugSwitch.hidden = YES;
    self.btnWidth.constant = 15.f;
    [self.closeBtn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    
}

-(void)setCellStyleNormal
{
    self.debugSwitch.hidden = YES;
    self.apiTextField.hidden = YES;
    self.btnWidth.constant = 10.f;
    [self.closeBtn setImage:[UIImage imageNamed:@"icon_arrow"] forState:UIControlStateNormal];
    
}

- (IBAction)clearApiAction:(id)sender {
    self.apiTextField.text = @"";
}

- (IBAction)apiSwitchAction:(id)sender {
    if(self.switchBlock)
    {
        self.switchBlock(self.debugSwitch.on);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.apiTextField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *nowString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    if(self.getConfigBlock)
    {
        self.getConfigBlock(nowString);
    }
    return YES;;
}

@end
