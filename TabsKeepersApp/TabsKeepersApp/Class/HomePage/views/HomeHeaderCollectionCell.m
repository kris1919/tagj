//
//  HomeHeaderCollectionCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/28.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "HomeHeaderCollectionCell.h"
#import "UIColor+Theme.h"
#import "UIFont+PingFangSC.h"
#import <Masonry.h>

@implementation HomeCollectIconModel

-(instancetype)initWithIcon:(NSString *)icon title:(NSString *)title{
    self = [super init];
    if (self) {
        self.iconStr = icon;
        self.titleStr = title;
    }
    return self;
}

@end

@interface HomeHeaderCollectionCell ()
@property (nonatomic ,strong)UIImageView *iconImageView;
@property (nonatomic ,strong)UILabel *titleLabel;

@end

@implementation HomeHeaderCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(5);
            make.centerX.mas_equalTo(self);
            make.width.height.mas_equalTo(@(36));
        }];
    
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(10);
            make.left.right.mas_equalTo(self);
        }];
    }
    return self;
}

-(void)setIconModel:(HomeCollectIconModel *)iconModel{
    self.iconImageView.image = [UIImage imageNamed:iconModel.iconStr];
    self.titleLabel.text = iconModel.titleStr;
}

-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor labelColorLevel51];
        _titleLabel.font = [UIFont pingFangFontOfSize:12];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
