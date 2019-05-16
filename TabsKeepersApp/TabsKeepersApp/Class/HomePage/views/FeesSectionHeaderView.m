//
//  FeesSectionHeaderView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "FeesSectionHeaderView.h"
#import "UIFont+PingFangSC.h"
#import "UIColor+Theme.h"
#import <Masonry.h>

@interface FeesSectionHeaderView ()
@property (nonatomic ,strong)UILabel *label;

@end


@implementation FeesSectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        [self addSubview:self.label];
        self.label.font = [UIFont boldPingFangFontOfSize:16];
        self.label.textColor = [UIColor labelColorLevel51];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 20, 0, 0));
        }];
    }
    return self;
}

-(void)setTitleStr:(NSString *)titleStr{
    self.label.text = titleStr;
}

@end
