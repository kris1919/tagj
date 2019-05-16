//
//  PersonCenterViewCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/15.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "PersonCenterViewCell.h"

@interface PersonCenterViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation PersonCenterViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}
-(void)setModel:(KeyValueModel *)model{
    self.iconView.image = [UIImage imageNamed:model.code];
    self.nameLabel.text = model.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
