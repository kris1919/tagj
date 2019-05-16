//
//  ServiceTopView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "ServiceTopView.h"
#import "UIFont+PingFangSC.h"
#import "UIColor+Theme.h"
#import <Masonry.h>

@interface ServiceTopView ()
@property (nonatomic ,strong)UILabel *label1;
@property (nonatomic ,strong)UILabel *label2;
@property (nonatomic ,strong)UIButton *button;
@end

@implementation ServiceTopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.contents = (id)[UIImage imageNamed:@"icon_xiaoxi"].CGImage;
        
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(16);
        }];
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.label1.mas_right).offset(5);
        }];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-16);
        }];
        
        [self.button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)buttonAction{
    if (self.buttonClickedBlock) {
        self.buttonClickedBlock();
    }
}

-(void)setLeibeiStr:(NSString *)leibeiStr{
    self.label2.text = leibeiStr;
}

-(UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.font = [UIFont boldPingFangFontOfSize:16];
        _label1.textColor = [UIColor blackColor];
        _label1.text = @"类别:";
        [self addSubview:_label1];
    }
    return _label1;
}

-(UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.font = [UIFont boldPingFangFontOfSize:16];
        _label2.textColor = [UIColor blackColor];
        [self addSubview:_label2];
    }
    return _label2;
}

-(UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"更多 >" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor labelColorLevel102] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont boldPingFangFontOfSize:16];
        [self addSubview:_button];
    }
    return _button;
}

@end
