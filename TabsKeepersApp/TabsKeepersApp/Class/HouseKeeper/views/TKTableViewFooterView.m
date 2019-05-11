//
//  TKTableViewFooterView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/5.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKTableViewFooterView.h"
#import "UIFont+PingFangSC.h"
#import <Masonry.h>

@interface TKTableViewFooterView ()
@property (nonatomic ,strong)UIButton *operationBtn;

@end

@implementation TKTableViewFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.operationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        [self.operationBtn addTarget:self action:@selector(operationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)operationBtnAction:(UIButton *)button{
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button);
    }
}

-(void)setImageName:(NSString *)imageName{
    [self.operationBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

-(void)setBtnTitle:(NSString *)btnTitle{
    [self.operationBtn setTitle:btnTitle forState:UIControlStateNormal];
}

-(UIButton *)operationBtn{
    if (!_operationBtn) {
        _operationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _operationBtn.titleLabel.font = [UIFont boldPingFangFontOfSize:18];
        [_operationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _operationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
        [self addSubview:_operationBtn];
    }
    return _operationBtn;
}

@end
