//
//  HouseKeeperViewCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/29.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "HouseKeeperViewCell.h"
#import "UIColor+Theme.h"
#import "UIFont+PingFangSC.h"

@interface HouseKeeperViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *operBtn;
@property (nonatomic ,strong)UILabel *statusLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@end

@implementation HouseKeeperViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bgView.clipsToBounds = YES;
    self.contentLabel.numberOfLines = 3;
    self.backgroundColor = [UIColor tableViewBgColor];
    
    self.statusLabel2.frame = CGRectMake(kScreenWidth - 12 - 85, 10, 100, 25);
    self.statusLabel2.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    [self.operBtn addTarget:self action:@selector(operButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setModel:(BaoxiuModel *)model{
    _model = model;
    [self setDataWithModel:model];
}

- (void)setDataWithModel:(BaoxiuModel *)model{
    NSString *timeStr = [NSString stringWithFormat:@"维修时间: %@",model.pudate];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:timeStr];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithR:51 G:51 B:51 A:1.0],NSFontAttributeName:[UIFont boldPingFangFontOfSize:12]} range:NSMakeRange(0, 5)];
    self.timeLabel.attributedText = attributeStr;
    
    NSString *statusStr = [NSString stringWithFormat:@"维修状态: %@",model.ztStr];
    NSMutableAttributedString *attributeStr2 = [[NSMutableAttributedString alloc] initWithString:statusStr];
    [attributeStr2 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithR:51 G:51 B:51 A:1.0],NSFontAttributeName:[UIFont boldPingFangFontOfSize:12]} range:NSMakeRange(0, 5)];
    self.statusLabel.attributedText = attributeStr2;
    
    NSString *contentStr = [NSString stringWithFormat:@"报修描述: %@",model.describe];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSMutableAttributedString *attributeStr3 = [[NSMutableAttributedString alloc] initWithString:contentStr attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    [attributeStr3 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithR:51 G:51 B:51 A:1.0],NSFontAttributeName:[UIFont boldPingFangFontOfSize:12]} range:NSMakeRange(0, 5)];
    self.contentLabel.attributedText = attributeStr3;
    
    self.statusLabel2.text = model.ztStr;
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    
    [self configBtnWithModel:model];
}
- (void)configBtnWithModel:(BaoxiuModel *)model{
    if (model.zt.integerValue == 1) {//待处理
        [self.operBtn setTitle:@"撤销报销" forState:UIControlStateNormal];
        [self.operBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.operBtn setBackgroundImage:[UIImage imageNamed:@"icon_hk_撤销"] forState:UIControlStateNormal];
    }else if (model.zt.integerValue == 3){//已撤销
        [self.operBtn setTitle:@"已撤销" forState:UIControlStateNormal];
        [self.operBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.operBtn setBackgroundImage:[UIImage imageNamed:@"icon_hk_已评价"] forState:UIControlStateNormal];
    }else{
        if (model.pjZt.integerValue == 1) {//未评价
            [self.operBtn setTitle:@"评价" forState:UIControlStateNormal];
            [self.operBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.operBtn setBackgroundImage:[UIImage imageNamed:@"icon_hk_评价"] forState:UIControlStateNormal];
        }else if (model.pjZt.integerValue == 2){//已评价
            [self.operBtn setTitle:@"已评价" forState:UIControlStateNormal];
            [self.operBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.operBtn setBackgroundImage:[UIImage imageNamed:@"icon_hk_已评价"] forState:UIControlStateNormal];
        }
    }
}

-(UILabel *)statusLabel2{
    if (!_statusLabel2) {
        _statusLabel2 = [UILabel new];
        _statusLabel2.textColor = [UIColor whiteColor];
        _statusLabel2.backgroundColor = [UIColor redColor];
        _statusLabel2.font = [UIFont pingFangFontOfSize:12];
        _statusLabel2.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_statusLabel2];
    }
    return _statusLabel2;
}

- (void)operButtonClick:(UIButton *)button{
    if (self.model.zt.integerValue == 1) {//待处理
        if (self.operBtnHandleBlock) {
            self.operBtnHandleBlock(1,self.indenPath.section);
        }
    }else if (self.model.zt.integerValue == 3){//已撤销
        if (self.operBtnHandleBlock) {
            self.operBtnHandleBlock(0,self.indenPath.section);
        }
    }else{
        if (self.model.pjZt.integerValue == 1) {//未评价
            if (self.operBtnHandleBlock) {
                self.operBtnHandleBlock(2,self.indenPath.section);
            }
        }else if (self.model.pjZt.integerValue == 2){//已评价
            if (self.operBtnHandleBlock) {
                self.operBtnHandleBlock(0,self.indenPath.section);
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
