//
//  ZhiFuView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "ZhiFuView.h"
#import "UIColor+Theme.h"

@interface ZhiFuView ()

@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;
@property (nonatomic ,strong)UIView *mask;

@end

@implementation ZhiFuView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    CGRect rect = CGRectMake((kScreenWidth - 320) / 2, (kScreenHeight * 0.25), 320, 300);
    self.frame = rect;
}

- (IBAction)wechatBtnAction:(id)sender {
    self.wechatBtn.selected = YES;
    self.alipayBtn.selected = NO;
}
- (IBAction)alipayBtnAction:(id)sender {
    self.wechatBtn.selected = NO;
    self.alipayBtn.selected = YES;
}
- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.mask];
    [window addSubview:self];
}

- (IBAction)hide:(id)sender{
    [self.mask removeFromSuperview];
    [self removeFromSuperview];
}

-(UIView *)mask{
    if (!_mask) {
        _mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _mask.backgroundColor = [UIColor colorWithR:0 G:0 B:0 A:0.4];
    }
    return _mask;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)closeBtnAction:(id)sender {
}

@end
