//
//  HomeWaterFeeViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "HomeWaterFeeViewController.h"
#import "TKTableView.h"
#import "TKCycleData.h"
#import "MCNetworking.h"
#import "FeesListModel.h"
#import <YYModel.h>
#import <Masonry.h>
#import "FeesListViewCell.h"
#import "FeesHistoryCell.h"
#import "TKRefreshFooter.h"
#import "FeesSectionHeaderView.h"
#import "HomeFeesTopView.h"
#import "ZhiFuView.h"
#import "FeesDetailView.h"
#import "TKAliapy.h"
#import "MCHUD.h"

@interface HomeWaterFeeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,strong)NSMutableArray *currentList;
@property (nonatomic ,strong)NSMutableArray *historyList;
@property (nonatomic ,copy)NSString *notiStr;
@property (nonatomic ,assign)NSInteger currentPage;
@property (nonatomic ,strong)HomeFeesTopView *topView;
@property (nonatomic ,strong)ZhiFuView *zhifuView;

@end

@implementation HomeWaterFeeViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_navigationBar.title = @"水费代缴";
    // Do any additional setup after loading the view.
    self.currentPage = 1;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height, 0, 0, 0));
    }];
    WS(weakSelf);
    self.tableView.mj_footer = [TKRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf.currentList removeAllObjects];
        [weakSelf requestData];
    }];
    
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayNoti:) name:kNotificationAppAliPayResult object:nil];
}

- (void)setNotiStr:(NSString *)notiStr{
    _notiStr = notiStr;
    if (_notiStr.length > 0) {
        self.topView.titleStr = notiStr;
        [self reloadUIWithString:notiStr];
    }
}
- (void)reloadUIWithString:(NSString *)str{
    CGFloat h = [TKUtils heightForString:str Width:kScreenWidth - 60 fontSize:12 lineSpace:8] + 20;
    CGFloat height = h < 56 ? 56 : h;
    self.topView.frame = CGRectMake(0, kNavigationBar_Height, kScreenWidth, height);
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height + height, 0, 0, 0));
    }];
}
- (void)requestData{
    dispatch_group_t group = dispatch_group_create();
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSString *urlStr =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantCurrentWaterFee];
    NSDictionary *param = @{@"customId":userModel.customId};
    WS(weakSelf);
    dispatch_group_enter(group);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        NSArray *listArr = [resDic objectForKey:@"list"];
        for (NSDictionary *d in listArr) {
            FeesListModel *model = [FeesListModel yy_modelWithJSON:d];
            [weakSelf.currentList addObject:model];
        }
        weakSelf.notiStr = [resDic objectForKey:@"title"];
        dispatch_group_leave(group);
    } failure:^(NSString * _Nonnull errorMsg) {
        dispatch_group_leave(group);
    } showHUD:YES view:self.view];
    
    NSString *urlStr2 =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantHistoryWaterFee];
    dispatch_group_enter(group);
    NSDictionary *param2 = @{@"customId":userModel.customId,
                            @"page":@(self.currentPage)
                            };
    [MCNetworking POSTWithUrl:urlStr2 parameter:param2 success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        NSArray *listArr = [resDic objectForKey:@"list"];
        for (NSDictionary *d in listArr) {
            FeesListModel *model = [FeesListModel yy_modelWithJSON:d];
            [weakSelf.historyList addObject:model];
        }
        dispatch_group_leave(group);
    } failure:^(NSString * _Nonnull errorMsg) {
        dispatch_group_leave(group);
    } showHUD:YES view:self.view];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    });
}
- (void)readyAlipay:(NSInteger)index{
    FeesListModel *model = [self.currentList objectAtIndex:index];
    NSString *urlStr2 =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantAPPPay];
    NSDictionary *param2 = @{@"type":@"1",
                             @"id":model.feeid,
                             @"zffs":@"2"
                             };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr2 parameter:param2 success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        if ([resDic.allKeys containsObject:@"Parms"]) {
            NSString *signStr = [resDic objectForKey:@"Parms"];
            [TKAliapy alipayWithSign:signStr callBack:^(NSDictionary * _Nonnull resultDic) {
                
            }];
        }
    } failure:^(NSString * _Nonnull errorMsg) {
        [MCHUD showTips:@"支付调用出错" view:weakSelf.view];
    } showHUD:YES view:self.view];
}
- (void)aliPayNoti:(NSNotification *)noti{
    NSDictionary *resultDic = noti.object;
    if ([resultDic.allKeys containsObject:@"resultStatus"]) {
        [self.zhifuView hidde];
        NSInteger rsCode = [resultDic[@"resultStatus"] integerValue];
        if (rsCode == 9000) {
            [self.historyList removeAllObjects];
            [self requestData];
            [MCHUD showTips:@"订单支付成功" view:[UIApplication sharedApplication].keyWindow];
        }else{
            if ([resultDic.allKeys containsObject:@"memo"]) {
                [MCHUD showTips:resultDic[@"memo"] view:[UIApplication sharedApplication].keyWindow];
            }
        }
    }
}
#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return (self.currentList.count > 0) + (self.historyList.count > 0);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.currentList.count > 0) {
        if (section == 0) {
            return self.currentList.count;
        }
        if (section == 1) {
            return self.historyList.count;
        }
    }
    if (self.historyList.count > 0) {
        return self.historyList.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.currentList.count > 0) {
        if (indexPath.section == 0) {
            FeesListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeesListViewCell" forIndexPath:indexPath];
            cell.indexPath = indexPath;
            cell.model = [self.currentList objectAtIndex:indexPath.row];
            WS(weakSelf);
            cell.detailButtonBlock = ^(NSInteger index) {
                if (self.currentList.count > index) {
                    FeesDetailView *detailVeiw = (FeesDetailView *)[TKUtils nibWithNibName:@"FeesDetailView"];
                    detailVeiw.model = [weakSelf.currentList objectAtIndex:index];
                    [detailVeiw show];
                }
            };
            cell.moneyButtonBlock = ^(NSInteger index) {
                weakSelf.zhifuView.payBlock = ^(NSInteger type) {
                    [weakSelf readyAlipay:index];
                };
                [weakSelf.zhifuView show];
            };
            return cell;
        }
        if (indexPath.section == 1) {
            FeesHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeesHistoryCell" forIndexPath:indexPath];
            cell.indexPath = indexPath;
            cell.model = [self.historyList objectAtIndex:indexPath.row];
            WS(weakSelf);
            cell.detailButtonBlock = ^(NSInteger index) {
                FeesDetailView *detailVeiw = (FeesDetailView *)[TKUtils nibWithNibName:@"FeesDetailView"];
                detailVeiw.model = [weakSelf.historyList objectAtIndex:index];
                [detailVeiw show];
            };
            return cell;
        }
    }
    if (self.historyList.count > 0) {
        FeesHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeesHistoryCell" forIndexPath:indexPath];
        cell.indexPath = indexPath;
        cell.model = [self.historyList objectAtIndex:indexPath.row];
        WS(weakSelf);
        cell.detailButtonBlock = ^(NSInteger index) {
            FeesDetailView *detailVeiw = (FeesDetailView *)[TKUtils nibWithNibName:@"FeesDetailView"];
            detailVeiw.model = [weakSelf.historyList objectAtIndex:index];
            [detailVeiw show];
        };
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentList.count > 0) {
        if (indexPath.section == 0) {
            return 145;
        }
        if (indexPath.section == 1) {
            return 86;
        }
    }
    if (self.historyList.count > 0) {
        return 86;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FeesSectionHeaderView *headerView = (FeesSectionHeaderView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FeesSectionHeaderView"];
    if (!headerView) {
        headerView = [[FeesSectionHeaderView alloc] init];
    }
    if (self.currentList.count > 0) {
        if (section == 0) {
            headerView.titleStr = @"应缴账单";
        }
        if (section == 1) {
            headerView.titleStr = @"历史账单";
        }
    }else if (self.historyList.count > 0) {
        headerView.titleStr = @"历史账单";
    }
    return headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(TKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"FeesListViewCell" bundle:nil] forCellReuseIdentifier:@"FeesListViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"FeesHistoryCell" bundle:nil] forCellReuseIdentifier:@"FeesHistoryCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

-(NSMutableArray *)historyList{
    if (!_historyList) {
        _historyList = [NSMutableArray arrayWithCapacity:0];
    }
    return _historyList;
}

-(NSMutableArray *)currentList{
    if (!_currentList) {
        _currentList = [NSMutableArray arrayWithCapacity:0];
    }
    return _currentList;
}
-(HomeFeesTopView *)topView{
    if (!_topView) {
        _topView = [[HomeFeesTopView alloc] initWithFrame:CGRectMake(0, kNavigationBar_Height, kScreenWidth, 56)];
        [self.view addSubview:_topView];
    }
    return _topView;
}
-(ZhiFuView *)zhifuView{
    if (!_zhifuView) {
        _zhifuView = (ZhiFuView *)[TKUtils nibWithNibName:@"ZhifuView"];
    }
    return _zhifuView;
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
