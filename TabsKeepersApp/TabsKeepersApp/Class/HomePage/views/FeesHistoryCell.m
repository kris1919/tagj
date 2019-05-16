//
//  FeesHistoryCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "FeesHistoryCell.h"

@interface FeesHistoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *tLabel;
@property (weak, nonatomic) IBOutlet UILabel *mLabel;

@end

@implementation FeesHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setModel:(FeesListModel *)model{
    self.tLabel.text = model.title;
    self.mLabel.text = [NSString stringWithFormat:@"￥%@",model.money];
}
-(void)setWyModel:(WYFeesModel *)wyModel{
    self.tLabel.text = wyModel.title;
    self.mLabel.text = [NSString stringWithFormat:@"￥%@",wyModel.money];
}

- (IBAction)detailBtnAction:(id)sender {
    if (self.detailButtonBlock) {
        self.detailButtonBlock(self.indexPath.row);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
