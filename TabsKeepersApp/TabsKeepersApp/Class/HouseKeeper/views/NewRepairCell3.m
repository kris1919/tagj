//
//  NewRepairCell3.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/3.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "NewRepairCell3.h"

@interface NewRepairCell3 ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressLabel;


@end

@implementation NewRepairCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.nameLabel.delegate = self;
    self.phoneLabel.delegate = self;
    self.addressLabel.delegate = self;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.textFieldDidEndEditing) {
        self.textFieldDidEndEditing(textField.text, textField == self.nameLabel ? 0 : textField == self.phoneLabel ? 1 : 2);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
