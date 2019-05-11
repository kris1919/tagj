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
    
    [self setData];
}

- (void)setData{
    NSString *timeStr = @"维修时间: 2019-04-29";
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:timeStr];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithR:51 G:51 B:51 A:1.0],NSFontAttributeName:[UIFont boldPingFangFontOfSize:12]} range:NSMakeRange(0, 5)];
    self.timeLabel.attributedText = attributeStr;
    
    NSString *statusStr = @"维修状态: 待处理";
    NSMutableAttributedString *attributeStr2 = [[NSMutableAttributedString alloc] initWithString:statusStr];
    [attributeStr2 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithR:51 G:51 B:51 A:1.0],NSFontAttributeName:[UIFont boldPingFangFontOfSize:12]} range:NSMakeRange(0, 5)];
    self.statusLabel.attributedText = attributeStr2;
    
    NSString *contentStr = @"报修描述: 文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息文本信息jdkahsdk";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSMutableAttributedString *attributeStr3 = [[NSMutableAttributedString alloc] initWithString:contentStr attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    [attributeStr3 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithR:51 G:51 B:51 A:1.0],NSFontAttributeName:[UIFont boldPingFangFontOfSize:12]} range:NSMakeRange(0, 5)];
    self.contentLabel.attributedText = attributeStr3;
    
    self.statusLabel2.text = @"待处理";
    [self.operBtn setTitle:@"撤销报销" forState:UIControlStateNormal];
    [self.operBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.operBtn setBackgroundImage:[UIImage imageNamed:@"icon_hk_撤销"] forState:UIControlStateNormal];
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
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
    if (self.operBtnHandleBlock) {
        self.operBtnHandleBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
