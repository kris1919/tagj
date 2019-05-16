//
//  FamilyTableViewCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "FamilyTableViewCell.h"
#import "UIColor+Theme.h"

@interface FamilyTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *relationLabel;
@property (weak, nonatomic) IBOutlet UILabel *relationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation FamilyTableViewCell

-(void)setModel:(MyFamilyListModel *)model{
    self.relationLabel.text = @"关系:";
    self.relationNameLabel.text = model.gxName;
    self.phoneLabel.text = model.phone;
    NSInteger ztCode = model.zt.integerValue;
    if (ztCode == 1) {
        self.statusLabel.text = @"审核中";
        self.statusLabel.textColor = [UIColor whiteColor];
        self.iconView.image = [UIImage imageNamed:@"审核中"];
    }else if (ztCode == 2){
        self.statusLabel.text = @"已开通";
        self.statusLabel.textColor = [UIColor labelColorLevel51];
        self.iconView.image = nil;
    }else if (ztCode == 3){
        self.statusLabel.text = @"已拒绝";
        self.statusLabel.textColor = [UIColor labelColorLevel51];
        self.iconView.image = [UIImage imageNamed:@"已拒绝"];
    }else{
        self.statusLabel.text = @"";
        self.statusLabel.textColor = [UIColor labelColorLevel51];
        self.iconView.image = nil;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
