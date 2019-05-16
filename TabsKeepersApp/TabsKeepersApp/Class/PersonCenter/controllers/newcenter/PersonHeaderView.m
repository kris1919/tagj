//
//  PersonHeaderView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/15.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "PersonHeaderView.h"

@interface PersonHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation PersonHeaderView

-(void)setModel:(TKUserModel *)model{
    self.nameLabel.text = model.name;
    self.sizeLabel.text = model.size;
    self.addressLabel.text = model.address;
    self.phoneLabel.text = model.phone;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

@end
