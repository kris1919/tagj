//
//  TKRegisterViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/25.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKRegisterViewController.h"
#import "PLCountBtn.h"
#import "NSString+Judge.h"
#import "MCHUD.h"
#import "MCNetworking.h"

@interface TKRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContraint;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;
@property (weak, nonatomic) IBOutlet UITextField *pwdTf1;
@property (weak, nonatomic) IBOutlet UITextField *pwdTf2;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet PLCountBtn *getCodeBtn;

@end

@implementation TKRegisterViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.mc_navigationBar.title = @"找回密码";
    
    [self setpUI];
}
- (void)setpUI{
    if (kIPhoneXSeries) {
        self.topContraint.constant = 88 + 48;
    }
    [self.getCodeBtn setBackgroundImage:[UIImage imageNamed:@"icon_pwd_msgCode"] forState:UIControlStateNormal];
    [self.getCodeBtn setBackgroundImage:[UIImage imageNamed:@"icon_pwd_msgCode"] forState:UIControlStateDisabled];
}
- (void)keyboardWillShow:(NSNotification *)noti{
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat offset = (kScreenHeight - CGRectGetMaxY(self.resetBtn.frame) - 10) - rect.size.height;
    if (offset < 0) {
        CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0, offset, kScreenWidth, kScreenHeight);
        }];
    }
}
- (void)keyboardWillHide:(NSNotification *)noti{
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)countBtnAction:(PLCountBtn *)sender {
    if (![self.phoneTf.text isPhoneNum] || self.phoneTf.text.length == 0) {
        [MCHUD showTips:@"请输入正确的手机号码" view:self.view];
        return;
    }
    NSString *urlStr = [kTKApiConstantDomin stringByAppendingString:kTKApiConstantGetPhoneMsgCode];
    NSDictionary *param = @{@"phone":self.phoneTf.text};
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        [weakSelf.getCodeBtn startCount];
    } failure:^(NSString * _Nonnull errorMsg) {
        [MCHUD showTips:errorMsg view:self.view];
    } showHUD:YES view:self.view];
}
- (IBAction)resetBtnAction:(UIButton *)sender {
    if (![self.phoneTf.text isPhoneNum] || self.phoneTf.text.length == 0) {
        [MCHUD showTips:@"请输入正确的手机号码" view:self.view];
        return;
    }
    if (self.codeTf.text.length == 0) {
        [MCHUD showTips:@"请输入验证码" view:self.view];
        return;
    }
    if (self.pwdTf1.text.length == 0) {
        [MCHUD showTips:@"请输入密码" view:self.view];
        return;
    }
    if (self.pwdTf2.text.length == 0) {
        [MCHUD showTips:@"请再次输入密码" view:self.view];
        return;
    }
    if (![self.pwdTf1.text isEqualToString:self.pwdTf2.text]) {
        [MCHUD showTips:@"2次输入的密码不一致" view:self.view];
        return;
    }
    NSString *urlStr = [kTKApiConstantDomin stringByAppendingString:kTKApiConstantResetPwd];
    NSDictionary *param = @{
                            @"phone":self.phoneTf.text,
                            @"yzm":self.codeTf.text,
                            @"password":self.pwdTf1.text
                            };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        if (weakSelf.resetPwdSuccess) {
            weakSelf.resetPwdSuccess(weakSelf.phoneTf.text,weakSelf.pwdTf1.text);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString * _Nonnull errorMsg) {
        
    } showHUD:YES view:self.view];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
