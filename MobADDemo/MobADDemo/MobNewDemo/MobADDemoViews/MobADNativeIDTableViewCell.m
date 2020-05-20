//
//  MobADNativeIDTableViewCell.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/19.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADNativeIDTableViewCell.h"

@interface MobADNativeIDTableViewCell ()<UITextFieldDelegate>

@end

@implementation MobADNativeIDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textFiledl.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)deleteAction:(id)sender {
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textFiledl resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *all = [NSString stringWithFormat:@"%@%@",textField.text,string];
    if(self.getTextBlock)
    {
        self.getTextBlock(all);
    }
    return YES;
}


@end
