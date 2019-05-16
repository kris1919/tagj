//
//  TKDoubleLabelCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/5.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKDoubleLabelCell.h"
#import "UIColor+theme.h"
#import "UIFont+PingFangSC.h"
#import <Masonry.h>

@interface TKDoubleLabelCell ()
@property (strong, nonatomic)  UILabel *keyLabel;
@property (strong, nonatomic)  UILabel *valueLabel;
@end

@implementation TKDoubleLabelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.keyLabel];
        [self.contentView addSubview:self.valueLabel];
        [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(16);
            make.top.mas_equalTo(self.contentView).offset(10);
        }];
        [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.keyLabel.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-16);
            make.top.mas_equalTo(self.contentView).offset(10);
            make.bottom.mas_equalTo(self.contentView).offset(-10);
        }];
        [self.keyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    }
    return self;
}
-(void)setKeyString:(NSString *)keyString{
    self.keyLabel.text = keyString;
}
-(void)setValueString:(NSString *)valueString{
    if (valueString.length == 0) {
        self.valueLabel.attributedText = nil;
        return;
    }
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 8;
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:valueString attributes:@{NSParagraphStyleAttributeName:style}];
    self.valueLabel.attributedText = aString;
}
-(UILabel *)keyLabel{
    if (!_keyLabel) {
        _keyLabel = [UILabel new];
        _keyLabel.textColor = [UIColor labelColorLevel51];
        _keyLabel.font = [UIFont boldPingFangFontOfSize:16];
    }
    return _keyLabel;
}
-(UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [UILabel new];
        _valueLabel.textColor = [UIColor labelColorLevel153];
        _valueLabel.font = [UIFont boldPingFangFontOfSize:16];
        _valueLabel.numberOfLines = 0;
    }
    return _valueLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
