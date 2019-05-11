//
//  TKLoginViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/24.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKLoginViewController.h"
#import "NSString+Judge.h"

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
        return;
    }
    if (0 == self.pwdTF.text.length) {
        return;
    }
    if (!self.loginBtn.selected) {
        return;
    }
}
- (IBAction)forgetBtnAction:(UIButton *)sender {
    
}
- (IBAction)serverBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)showServerPage:(UIButton *)sender {
    
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
