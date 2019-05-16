//
//  WaterSectionView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "WaterSectionView.h"
#import "UIFont+PingFangSC.h"
#import <Masonry.h>

@implementation WaterSectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label1 = [self labelWithTitle:@"周期"];
        [self addSubview:label1];
        
        UILabel *label2 = [self labelWithTitle:@"吨数"];
        [self addSubview:label2];
        
        UILabel *label3 = [self labelWithTitle:@"支付方式"];
        [self addSubview:label3];
        
        UILabel *label4 = [self labelWithTitle:@"付款日期"];
        [self addSubview:label4];
        
        UILabel *label5 = [self labelWithTitle:@"金额"];
        [self addSubview:label5];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(16);
            make.width.mas_equalTo(@(69+15));
        }];
        
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-16);
            make.width.mas_equalTo(@(60));
        }];
        
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(label1.mas_right).offset(10);
        }];
        
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(label4.mas_left).offset(-10);
        }];
        
        [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(label2.mas_right).offset(5);
            make.right.mas_equalTo(label3.mas_left).offset(-5);
            make.width.mas_equalTo(label2.mas_width);
            make.width.mas_equalTo(label3.mas_width);
        }];
        
        
        label1.textAlignment = NSTextAlignmentLeft;
        label2.textAlignment = NSTextAlignmentCenter;
        label3.textAlignment = NSTextAlignmentCenter;
        label5.textAlignment = NSTextAlignmentCenter;
        label4.textAlignment = NSTextAlignmentRight;
        
        
    }
    return self;
}
- (UILabel *)labelWithTitle:(NSString *)title{
    UILabel *label = [UILabel new];
    label.text = title;
    label.font = [UIFont boldPingFangFontOfSize:14];
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}
@end
