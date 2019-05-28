//
//  TKLoginViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/24.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKLoginViewController.h"
#import "NSString+Judge.h"
#import "MCHUD.h"
#import "MCNetworking.h"
#import "ServiceProtocalViewController.h"
#import "TKRegisterViewController.h"
#import "TKUserDefault.h"
#import "TKCycleData.h"

@interface TKLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *serverBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation TKLoginViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.mc_navigationBar.hidden = YES;
}

- (void)keyboardWillShow:(NSNotification *)noti{
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat offset = (kScreenHeight - CGRectGetMaxY(self.loginBtn.frame) - 10) - rect.size.height;
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

- (IBAction)loginBtnAction:(UIButton *)sender {
    if (![self.phoneTF.text isPhoneNum]) {
        [MCHUD showTips:@"请填写正确的手机号码" view:self.view];
        return;
    }
    if (0 == self.pwdTF.text.length) {
        [MCHUD showTips:@"请填写密码" view:self.view];
        return;
    }
    if (!self.serverBtn.selected) {
        [MCHUD showTips:@"请认真阅读协议" view:self.view];
        return;
    }
    NSString *urlStr = [kTKApiConstantDomin stringByAppendingString:kTKApiConstantLogin];
    NSString *jpushId = [TKCycleData shareInstance].jpushRegisterId;
    NSDictionary *param = @{@"phone":self.phoneTF.text,
                            @"password":self.pwdTF.text,
                            @"tsId":jpushId.length != 0 ? jpushId : @"9999"
                          };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        [TKUserDefault setUserInfo:[responseDic objectForKey:kTKResponseResultData]];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
    } failure:^(NSString * _Nonnull errorMsg) {
       [MCHUD showTips:errorMsg view:weakSelf.view];
    } showHUD:YES view:self.view];
}
- (IBAction)forgetBtnAction:(UIButton *)sender {
    
}
- (IBAction)serverBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)showServerPage:(UIButton *)sender {
    ServiceProtocalViewController *pageVC = [[ServiceProtocalViewController alloc] init];
    NSString *urlStr = [kTKApiConstantDomin stringByAppendingString:kTKApiConstantServicePage];
    pageVC.urlStr = urlStr;
    pageVC.mc_navigationBar.title = @"服务协议";
    [self.navigationController pushViewController:pageVC animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender NS_AVAILABLE_IOS(5_0){
    if([segue.destinationViewController isKindOfClass:[TKRegisterViewController class]]){
        TKRegisterViewController *registVC = (TKRegisterViewController *)segue.destinationViewController;
        WS(weakSelf);
        registVC.resetPwdSuccess = ^(NSString * _Nonnull phone, NSString * _Nonnull pwd) {
            weakSelf.phoneTF.text = phone;
            weakSelf.pwdTF.text = pwd;
            [weakSelf loginBtnAction:weakSelf.loginBtn];
        };
    }
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
