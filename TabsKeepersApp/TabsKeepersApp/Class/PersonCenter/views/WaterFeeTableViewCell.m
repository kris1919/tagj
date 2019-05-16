//
//  WaterFeeTableViewCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "WaterFeeTableViewCell.h"

@interface WaterFeeTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *dunLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation WaterFeeTableViewCell

-(void)setModel:(WYFeeModel *)model{
    self.startDateLabel.text = model.date1;
    self.endDateLabel.text = model.date2;
    self.feeLabel.text = model.money;
    self.typeLabel.text = model.zffs.integerValue == 1 ? @"微信" : @"支付宝";
    self.dateLabel.text = model.zfDate;
    self.dunLabel.text = model.dun;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.containerView.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
