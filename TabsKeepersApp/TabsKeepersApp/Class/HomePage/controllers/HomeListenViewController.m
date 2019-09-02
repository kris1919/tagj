//
//  HomeListenViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "HomeListenViewController.h"
#import "TKTableView.h"
#import "TKCycleData.h"
#import "MCNetworking.h"
#import "ListenListModel.h"
#import <YYModel.h>
#import "ListenListViewCell.h"
#import <Masonry.h>
#import "ListenSectionHeaderView.h"
#import <DSSPlatformDataAdapterUser.h>
#import "AdapterLoginModel.h"
#import "DHLoginManager.h"
#import "DHHudPrecess.h"
#import "DHDataCenter.h"
#import "ListenSelectViewController.h"
@interface HomeListenViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,strong)NSMutableArray<ListenListModel *> *dataArr;
@property (nonatomic ,strong)AdapterLoginModel *loginModel;

@end

@implementation HomeListenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_navigationBar.title = @"监控中心";
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    // Do any additional setup after loading the view.
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height, 0, 0, 0));
    }];
    [self requestData];
}
- (void)requestData{
    NSString *urlStr2 =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantListenList];
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSDictionary *param2 = @{
                             @"customId":userModel.customId
                             };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr2 parameter:param2 success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        NSArray *resultArr = [resDic objectForKey:@"list"];
        for (NSDictionary *d in resultArr) {
            ListenListModel *model = [ListenListModel yy_modelWithJSON:d];
            [weakSelf.dataArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } failure:^(NSString * _Nonnull errorMsg) {
        
    } showHUD:YES view:self.view];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ListenListModel *listModel = [self.dataArr objectAtIndex:section];
    return listModel.shebei.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListenListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListenListViewCell" forIndexPath:indexPath];
    ListenListModel *listModel = [self.dataArr objectAtIndex:indexPath.section];
    ListenDeviceModel *model = [listModel.shebei objectAtIndex:indexPath.row];
    cell.cText = model.sbName;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ListenSectionHeaderView *view = (ListenSectionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ListenSectionHeaderView"];
    if (!view) {
        view = [[ListenSectionHeaderView alloc] init];
    }
    ListenListModel *listModel = [self.dataArr objectAtIndex:section];
    view.title = listModel.typeName;
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListenListModel *listModel = [self.dataArr objectAtIndex:indexPath.section];
    ListenDeviceModel *model = [listModel.shebei objectAtIndex:indexPath.row];
    [self requestDataForLogin:model.sbId];
}
- (void)requestDataForLogin:(NSString *)deviceId{
    if (!deviceId || deviceId.length == 0) {
        return;
    }
    NSString *urlStr2 =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantListenDetail];
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSDictionary *param2 = @{
                             @"customId":userModel.customId,
                             @"sbId":deviceId
                             };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr2 parameter:param2 success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        weakSelf.loginModel = [AdapterLoginModel yy_modelWithJSON:resDic];
        weakSelf.loginModel.sbId = deviceId;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf login];
        });
    } failure:^(NSString * _Nonnull errorMsg) {
        
    } showHUD:YES view:self.view];
}
- (void)login{
    [[DHHudPrecess sharedInstance] showWaiting:@"请求中..."
                                WhileExecuting:@selector(loginServer)
                                      onTarget:self
                                    withObject:NULL
                                      animated:YES
                                        atView:self.view];
}

- (void)loginServer{
    [[DHDataCenter sharedInstance] setHost:self.loginModel.szIp port:self.loginModel.nPort.intValue];
    NSError *error = nil;
    DSSUserInfo *userInfo = [[DHLoginManager sharedInstance] loginWithUserName:self.loginModel.szUsername Password:self.loginModel.szPassword error:&error];
    //call after login
    [[DHDeviceManager sharedInstance] afterLoginInExcute:userInfo];
    [[DHDeviceManager sharedInstance] loadDeviceTree:&error];
    [DHDataCenter sharedInstance].channelId = self.loginModel.szCameraId;
    [DHDataCenter sharedInstance].channelName = self.loginModel.sbName;
    [DHDataCenter sharedInstance].deviceId = self.loginModel.sbId;
    RunOnMainThread({
        ListenSelectViewController *selectVC = [[ListenSelectViewController alloc] init];
        selectVC.mc_navigationBar.title = self.loginModel.sbName;
        [self.navigationController pushViewController:selectVC animated:YES];
    });
}


-(TKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"ListenListViewCell" bundle:nil] forCellReuseIdentifier:@"ListenListViewCell"];
        
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
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
