//
//  HomeFeesTopView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "HomeFeesTopView.h"
#import "UIFont+PingFangSC.h"
#import "UIColor+Theme.h"
#import <Masonry.h>

@interface HomeFeesTopView ()
@property (nonatomic ,strong)UIImageView *iconView;
@property (nonatomic ,strong)UILabel *label;

@end

@implementation HomeFeesTopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.contents = (id)[UIImage imageNamed:@"icon_xiaoxi"].CGImage;
        
        self.iconView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"喇叭"];
            imageView;
        });
        [self addSubview:self.iconView];
        
        self.label = ({
            UILabel *label = [UILabel new];
            label.font = [UIFont pingFangFontOfSize:12];
            label.textColor = [UIColor labelColorLevel51];
            label.numberOfLines = 0;
            label;
        });
        [self addSubview:self.label];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(16);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(@(14));
            make.width.mas_equalTo(@(18));
        }];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.iconView.mas_right).offset(10);
            make.right.mas_equalTo(self).offset(-16);
        }];        
    }
    return self;
}

-(void)setTitleStr:(NSString *)titleStr{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    style.lineSpacing = 8;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:titleStr attributes:@{NSParagraphStyleAttributeName:style}];
    self.label.attributedText = attString;
}

@end
