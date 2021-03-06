//
//  TKEvaluateView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/30.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKEvaluateView.h"
#import "UIColor+Theme.h"
#import <Masonry.h>
#import "UIFont+PingFangSC.h"

@interface TKEvaluateView ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic ,strong)UIView *mask;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation TKEvaluateView

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    CGRect rect = CGRectMake((kScreenWidth - 320) / 2, (kScreenHeight * 0.25), 320, 300);
    self.frame = rect;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tap.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tap];
    
    self.textView.delegate = self;
}
- (void)keyboardWillShow:(NSNotification *)noti{
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect btnRect = [self convertRect:self.submitBtn.frame toView:window];
    CGFloat offset = (kScreenHeight - CGRectGetMaxY(btnRect) - 10) - rect.size.height;
    if (offset < 0) {
        CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        [UIView animateWithDuration:duration animations:^{
            CGRect rect = self.frame;
            rect.origin.y += offset;
            self.frame = rect;
        }];
    }
}
- (void)keyboardWillHide:(NSNotification *)noti{
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect rect = CGRectMake((kScreenWidth - 320) / 2, (kScreenHeight * 0.25), 320, 300);
        self.frame = rect;
    }];
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.mask];
    [window addSubview:self];
}

-(void)tk_hidden{
    [self hide];
}

- (void)hide{
    [self.mask removeFromSuperview];
    [self removeFromSuperview];
}

-(void)tap{
    [self endEditing:YES];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.textViewEndEditingBlock) {
        self.textViewEndEditingBlock(textView.text);
    }
}

-(UIView *)mask{
    if (!_mask) {
        _mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _mask.backgroundColor = [UIColor colorWithR:0 G:0 B:0 A:0.4];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.cancelsTouchesInView = NO;
        [_mask addGestureRecognizer:tap];
    }
    return _mask;
}
- (IBAction)closeBtnAction:(UIButton *)sender {
    [self hide];
}
- (IBAction)evaluateBtnAction:(UIButton *)sender {
    UIButton *button1 = [self viewWithTag:1];
    UIButton *button2 = [self viewWithTag:2];
    UIButton *button3 = [self viewWithTag:3];
    button1.selected = NO;
    button2.selected = NO;
    button3.selected = NO;
    sender.selected = YES;
    if (self.evaluateBlock) {
        self.evaluateBlock(sender.tag);
    }
}
- (IBAction)submitBtnAction:(UIButton *)sender {
    if (self.submitBlock) {
        self.submitBlock();
    }
}

@end
