//
//  NotificationListCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/5.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "NotificationListCell.h"
#import <UIImageView+WebCache.h>

@interface NotificationListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation NotificationListCell

-(void)setModel:(HouseNotificationModel *)model{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.titleLabel.text = model.title;
    self.nameLabel.text = model.zuozhe;
    self.timeLabel.text = model.pudate;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    self.iconView.layer.cornerRadius = 8;
    self.iconView.clipsToBounds = YES;
    
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGRect newRect = CGRectMake(rect.origin.x + 16, rect.origin.y, rect.size.width - 32, rect.size.height - 10);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:10];
    [[UIColor whiteColor] set];
    [path fill];
}

@end
