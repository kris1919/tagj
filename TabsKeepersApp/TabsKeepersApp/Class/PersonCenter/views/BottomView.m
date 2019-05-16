//
//  BottomView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "BottomView.h"
#import <Masonry.h>
#import "UIFont+PingFangSC.h"

@implementation BottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        [self.button addTarget:self action:@selector(buttonClickedAction) forControlEvents:UIControlEventTouchUpInside];
        [self.button setBackgroundImage:[UIImage imageNamed:@"icon_evaluate_submit"] forState:UIControlStateNormal];
        [self.button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
    }
    return self;
}

- (void)buttonClickedAction{
    if (self.clickHandler) {
        self.clickHandler();
    }
}

-(void)setBtnTitle:(NSString *)btnTitle{
    [self.button setTitle:btnTitle forState:UIControlStateNormal];
}

-(UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"添加家人" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _button.titleLabel.font = [UIFont boldPingFangFontOfSize:18];
    }
    return _button;
}
@end
