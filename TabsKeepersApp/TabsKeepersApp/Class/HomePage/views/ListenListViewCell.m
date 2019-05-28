//
//  ListenListViewCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "ListenListViewCell.h"

@interface ListenListViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *cLable;

@end

@implementation ListenListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCText:(NSString *)cText{
    if (cText) {
        self.cLable.text = cText;
    }
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGRect newRect = CGRectMake(10, 5, rect.size.width - 20, rect.size.height - 10);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:8];
    [[UIColor whiteColor] set];
    [path fill];
}
@end
