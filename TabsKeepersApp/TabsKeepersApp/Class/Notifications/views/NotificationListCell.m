//
//  NotificationListCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/5.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "NotificationListCell.h"

@implementation NotificationListCell

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

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGRect newRect = CGRectMake(rect.origin.x + 16, rect.origin.y, rect.size.width - 32, rect.size.height - 10);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:10];
    [[UIColor whiteColor] set];
    [path fill];
}

@end
