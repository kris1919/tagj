//
//  NewPersonCenterViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/15.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "NewPersonCenterViewController.h"
#import "TKTableView.h"
#import "PersonCenterViewCell.h"
#import "KeyValueModel.h"
#import <YYModel.h>
#import <Masonry.h>
#import "PersonHeaderView.h"
#import "PersonFooterView.h"
#import "UIColor+Theme.h"
#import "TKCycleData.h"
#import "MyFamilyViewController.h"
#import "MyFeeManageViewController.h"
#import "MyNotiManageViewController.h"
#import "ContactsUsViewController.h"

@interface NewPersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,strong)NSMutableArray<NSMutableArray *> *dataArr;
@property (nonatomic ,strong)PersonHeaderView *headerView;
@property (nonatomic ,strong)PersonFooterView *footerView;
@end

@implementation NewPersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(-kNavigationBar_Height+44, 0, kTabBar_Height, 0));
    }];
    
    self.headerView.model = [TKCycleData shareInstance].userModel;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    
    WS(weakSelf);
    self.footerView.clickHandler = ^{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"确定要退出登录吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
        }];
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [weakSelf presentViewController:alertVC animated:YES completion:nil];
    };
}

-(PersonHeaderView *)headerView{
    if (!_headerView) {
        _headerView = (PersonHeaderView *)[TKUtils nibWithNibName:@"PersonHeaderView"];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 250 + (kIPhoneXSeries ? 24 : 0));
    }
    return _headerView;
}
-(PersonFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[PersonFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    }
    return _footerView;
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr[section].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonCenterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCenterViewCell" forIndexPath:indexPath];
    KeyValueModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 5 : 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MyFamilyViewController *vc = [[MyFamilyViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.row == 1){
            MyFeeManageViewController *vc = [[MyFeeManageViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2){
            MyNotiManageViewController *vc = [[MyNotiManageViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            [self call];
        }
    }
}

- (void)call{
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",userModel.kefu];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(TKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"PersonCenterViewCell" bundle:nil] forCellReuseIdentifier:@"PersonCenterViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        [self.view addSubview:_tableView];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithR:249 G:249 B:249 A:1.0];
    }
    return _tableView;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
        NSArray *list1 = @[@{@"code":@"icon_ps_family",@"name":@"我的家人"},
                           @{@"code":@"icon_ps_fee",@"name":@"我的缴费记录"},
                           @{@"code":@"icon_ps_noti",@"name":@"我的消息"}];
        NSArray *list2 = @[@{@"code":@"icon_ps_contacts",@"name":@"联系我们"}];
        NSMutableArray *a = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *d in list1) {
            KeyValueModel *model = [KeyValueModel yy_modelWithJSON:d];
            [a addObject:model];
        }
        [_dataArr addObject:a];
        NSMutableArray *b = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *d in list2) {
            KeyValueModel *model = [KeyValueModel yy_modelWithJSON:d];
            [b addObject:model];
        }
        [_dataArr addObject:b];
    }
    return _dataArr;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cornerRadius = 10;
    CGRect bounds = CGRectMake(CGRectGetMinX(cell.bounds) + 8, 0, CGRectGetWidth(cell.bounds) - 16, CGRectGetHeight(cell.bounds));
    NSInteger numOfRows = [tableView numberOfRowsInSection:indexPath.section];
    UIBezierPath *bezierPath = nil;
    if (numOfRows == 1) {
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:cornerRadius];
    }else if (indexPath.row == 0){
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    }else if (indexPath.row == numOfRows - 1){
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    }else{
        bezierPath = [UIBezierPath bezierPathWithRect:bounds];
    }
    bezierPath.lineWidth = 1;
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = [UIColor clearColor].CGColor;
    if (indexPath.row == numOfRows - 1) {
        layer.shadowOffset = CGSizeMake(0, 2);
        layer.shadowColor = [UIColor colorWithR:224 G:224 B:224 A:0.5].CGColor;
        layer.shadowOpacity = 1;
    }
    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    [testView.layer insertSublayer:layer atIndex:0];
    testView.backgroundColor = UIColor.clearColor;
    cell.backgroundView = testView;
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
