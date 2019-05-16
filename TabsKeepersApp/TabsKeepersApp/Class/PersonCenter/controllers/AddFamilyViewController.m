//
//  AddFamilyViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "AddFamilyViewController.h"
#import "UIColor+Theme.h"
#import "MCNetworking.h"
#import <YYModel.h>
#import "PLCountBtn.h"
#import "KeyValueModel.h"
#import "MCHUD.h"
#import "TKCycleData.h"
#import "TKSelectedView.h"

@interface AddFamilyViewController ()
@property (weak, nonatomic) IBOutlet UIButton *relationbtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNo;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;
@property (weak, nonatomic) IBOutlet UITextField *pwdTf1;
@property (weak, nonatomic) IBOutlet UITextField *pwdTf2;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet PLCountBtn *getCodeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic ,strong)NSMutableArray *relationArr;
@property (nonatomic ,strong)KeyValueModel *selectedRelationModel;
@property (nonatomic ,strong)TKSelectedView *selectView;

@end

@interface AddFamilyViewController ()

@end

@implementation AddFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mc_navigationBar.title = @"添加家人";
    self.view.backgroundColor = [UIColor tableViewBgColor];
    if (kIPhoneXSeries) {
        self.topConstraint.constant = 88 - 20 + 10;
    }
    [self.getCodeBtn setBackgroundImage:[UIImage imageNamed:@"icon_pwd_msgCode"] forState:UIControlStateNormal];
    [self.getCodeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    self.relationArr = [NSMutableArray arrayWithCapacity:0];
    
    [self requestRelationEnum];
}
- (void)getCode{
    if (self.phoneNo.text.length == 0) {
        [MCHUD showTips:@"请输入正确的手机号码" view:self.view];
        return;
    }
    WS(weakSelf);
    NSString *urlStr = [kTKApiConstantDomin stringByAppendingString:kTKApiConstantFamilyGetCode];
    NSDictionary *param = @{@"phone":self.phoneNo.text};
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        [weakSelf.getCodeBtn startCount];
        [MCHUD showTips:@"发送成功" view:weakSelf.view];
    } failure:^(NSString * _Nonnull errorMsg) {
        [MCHUD showTips:errorMsg view:weakSelf.view];
    } showHUD:YES view:self.view];
}

- (IBAction)relationBtnAction:(UIButton *)sender {
    self.selectView.dataArr = self.relationArr;
    [self.view addSubview:self.selectView];
}
- (IBAction)addbtnAction:(id)sender {
    if (self.phoneNo.text.length == 0) {
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
    NSString *urlStr = [kTKApiConstantDomin stringByAppendingString:kTKApiConstantFamilyAddNew];
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSDictionary *param = @{@"customId":userModel.customId,
                            @"gxId":self.selectedRelationModel.code,
                            @"phone":self.phoneNo.text,
                            @"yzm":self.codeTf.text,
                            @"password":self.pwdTf2.text
                            };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        [MCHUD showTips:@"添加成功" view:weakSelf.view];
        if (weakSelf.didAddNewFamilyMemberBlock) {
            weakSelf.didAddNewFamilyMemberBlock();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSString * _Nonnull errorMsg) {
        [MCHUD showTips:errorMsg view:weakSelf.view];
    } showHUD:YES view:self.view];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)requestRelationEnum{
    WS(weakSelf);
    NSString *urlStr = [kTKApiConstantDomin stringByAppendingString:kTKApiConstantRelationType];
    [MCNetworking GETWithUrl:urlStr success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *dic = [responseDic objectForKey:kTKResponseResultData];
        NSArray *listArr = [dic objectForKey:@"list"];
        for (NSDictionary *d in listArr) {
            KeyValueModel *model = [KeyValueModel yy_modelWithJSON:d];
            [weakSelf.relationArr addObject:model];
        }
        weakSelf.selectedRelationModel = weakSelf.relationArr.firstObject;
    } failure:^(NSString * _Nonnull errorMsg) {
        
    } showHUD:NO view:self.view];
}

-(void)setSelectedRelationModel:(KeyValueModel *)selectedRelationModel{
    _selectedRelationModel = selectedRelationModel;
    [self.relationbtn setTitle:selectedRelationModel.name forState:UIControlStateNormal];
}

-(TKSelectedView *)selectView{
    if (!_selectView) {
        CGFloat h = CGRectGetMaxY(self.containerView.frame);
        _selectView = [[TKSelectedView alloc] initWithFrame:CGRectMake(0, h, kScreenWidth, kScreenHeight - h)];
        WS(weakSelf);
        _selectView.selectedViewDidDoneBlock = ^(KeyValueModel * _Nonnull model) {
            weakSelf.selectedRelationModel = model;
        };
    }
    return _selectView;
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
