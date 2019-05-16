//
//  HomeAdvertiseCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/28.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "HomeAdvertiseCell.h"
#import <UIImageView+WebCache.h>

@implementation HomeAdvertiseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.adImageView.clipsToBounds = YES;
    self.adImageView.layer.cornerRadius = 5;
}

-(void)setModel:(HomeAdModel *)model{
    [self.adImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
