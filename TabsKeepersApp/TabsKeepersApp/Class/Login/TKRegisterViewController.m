//
//  TKRegisterViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/25.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKRegisterViewController.h"
#import "PLCountBtn.h"

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
