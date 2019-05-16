//
//  NormalNotiCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/16.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "NormalNotiCell.h"

@interface NormalNotiCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *momoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconRedView;

@end

@implementation NormalNotiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(BillModel *)model{
    self.nameLabel.text = model.title;
    self.momoLabel.text = model.memo;
    self.timeLabel.text = model.pudate;
    self.iconRedView.hidden = (model.zt.integerValue == 2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
