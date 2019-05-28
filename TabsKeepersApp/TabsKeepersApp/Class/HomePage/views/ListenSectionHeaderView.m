//
//  ListenSectionHeaderView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "ListenSectionHeaderView.h"
#import <Masonry.h>
#import "UIColor+Theme.h"

@interface ListenSectionHeaderView ()
@property (nonatomic ,strong)UILabel *titleLabel;

@end


@implementation ListenSectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithR:239 G:239 B:239 A:1.0];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(16);
        }];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _titleLabel;
}

-(void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}


@end
