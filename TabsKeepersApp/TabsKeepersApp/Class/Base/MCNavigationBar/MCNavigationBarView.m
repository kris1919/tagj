//
//  MCNavigationBarView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/25.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "MCNavigationBarView.h"
#import <Masonry.h>
#import "UIFont+PingFangSC.h"

@interface MCNavigationBarView()
@property (nonatomic ,strong)UIButton *backButtonItem;
@property (nonatomic ,strong)UIButton *rightButtonItem;
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UIView *containerView;

@property (nonatomic ,copy)void (^rightButtonBlock)(void);

@end

@implementation MCNavigationBarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.contents = (id)[UIImage imageNamed:@"icon_navigation_bar"].CGImage;
        
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.height.mas_equalTo(@(44));
        }];
        
        [self.backButtonItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.containerView).offset(10);
            make.centerY.mas_equalTo(self.containerView);
            make.height.width.mas_equalTo(@(40));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.containerView);
        }];
        
        [self.rightButtonItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.containerView).offset(-15);
            make.centerY.mas_equalTo(self.containerView);
            make.height.width.mas_equalTo(@(40));
        }];
        
        [self.backButtonItem addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButtonItem addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)addRightBarItemWithImage:(UIImage *)image handle:(void(^)(void))handle{
    [self.rightButtonItem setImage:image forState:UIControlStateNormal];
    self.rightButtonBlock = handle;
    [self.rightButtonItem mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.containerView).offset(-15);
        make.centerY.mas_equalTo(self.containerView);
        make.height.width.mas_equalTo(@(40));
    }];
}
- (void)rightButtonClicked{
    if (self.rightButtonBlock) {
        self.rightButtonBlock();
    }
}

- (void)backButtonClicked{
    if (self.backButtonHandle) {
        self.backButtonHandle();
    }
}

-(void)setTitle:(NSString *)title{
    if (title) {
        self.titleLabel.text = title;
    }
}
-(void)setHideBackBtn:(BOOL)hideBackBtn{
    self.backButtonItem.hidden = hideBackBtn;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        [self addSubview:_containerView];
    }
    return _containerView;
}

-(UIButton *)backButtonItem{
    if (!_backButtonItem) {
        _backButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButtonItem setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [self.containerView addSubview:_backButtonItem];
    }
    return _backButtonItem;
}
-(UIButton *)rightButtonItem{
    if (!_rightButtonItem) {
        _rightButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.containerView addSubview:_rightButtonItem];
    }
    return _rightButtonItem;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldPingFangFontOfSize:18];
        [self.containerView addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
