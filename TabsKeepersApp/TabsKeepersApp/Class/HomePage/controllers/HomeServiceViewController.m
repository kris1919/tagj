//
//  HomeServiceViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "HomeServiceViewController.h"
#import "TKTableView.h"
#import "TKCycleData.h"
#import "MCNetworking.h"
#import <YYModel.h>
#import <Masonry.h>
#import "TKRefreshFooter.h"
#import "TKRefreshHeader.h"
#import "KeyValueModel.h"
#import "ServiceListViewCell.h"
#import "ServerListModel.h"
#import "TKSelectedView.h"
#import "ServiceTopView.h"
#import "ServiceProtocalViewController.h"
#import "UIColor+Theme.h"

@interface HomeServiceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,assign)NSInteger currentPage;
@property (nonatomic ,strong)NSMutableArray *dataList;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,strong)KeyValueModel *selectedModel;
@property (nonatomic ,strong)TKSelectedView *selectView;
@property (nonatomic ,strong)ServiceTopView *topView;

@end

@implementation HomeServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mc_navigationBar.title = @"便民服务";
    
    [self requestList];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height + 50, 0, 0, 0));
    }];
    WS(weakSelf);
    self.tableView.mj_header = [TKRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf.dataArr removeAllObjects];
        [weakSelf requestData];
    }];
    self.tableView.mj_footer = [TKRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf requestData];
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(kNavigationBar_Height);
        make.height.mas_equalTo(@(50));
    }];
    self.topView.buttonClickedBlock = ^{
        weakSelf.selectView.dataArr = weakSelf.dataList;
        [weakSelf.view addSubview:weakSelf.selectView];
    };
    
}

- (void)requestData{
    if (self.selectedModel.code.length == 0) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSDictionary *param = @{@"customId":userModel.customId,
                            @"lxId":self.selectedModel.code,
                            @"page":@(self.currentPage)
                            };
    NSString *urlStr =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantGetShopList];
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        NSArray *listArr = [resDic objectForKey:@"list"];
        for (NSDictionary *d in listArr) {
            ServerListModel *model = [ServerListModel yy_modelWithJSON:d];
            [weakSelf.dataArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView reloadData];
        });
    } failure:^(NSString * _Nonnull errorMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    } showHUD:NO view:self.view];
}

- (void)requestList{

    NSString *urlStr =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantGetServiceType];
    WS(weakSelf);
    [MCNetworking GETWithUrl:urlStr success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        NSArray *listArr = [resDic objectForKey:@"list"];
        for (NSDictionary *d in listArr) {
            KeyValueModel *model = [KeyValueModel yy_modelWithJSON:d];
            [weakSelf.dataList addObject:model];
        }
        weakSelf.selectedModel = weakSelf.dataList.firstObject;
    } failure:^(NSString * _Nonnull errorMsg) {
        
    } showHUD:YES view:self.view];
}
- (void)setSelectedModel:(KeyValueModel *)selectedModel{
    _selectedModel = selectedModel;
    self.topView.leibeiStr = selectedModel.name;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView.mj_header beginRefreshing];
    });
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceListViewCell" forIndexPath:indexPath];
    cell.model = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
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
    ServiceProtocalViewController *pageVC = [[ServiceProtocalViewController alloc] init];
    ServerListModel *model = [self.dataArr objectAtIndex:indexPath.section];
    pageVC.urlStr = model.url;
    pageVC.mc_navigationBar.title = @"便民服务";
    [self.navigationController pushViewController:pageVC animated:YES];
}

-(TKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"ServiceListViewCell" bundle:nil] forCellReuseIdentifier:@"ServiceListViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = [UIColor colorWithR:249 G:249 B:249 A:1.0];
    }
    return _tableView;
}

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataList;
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

-(ServiceTopView *)topView{
    if (!_topView) {
        _topView = [[ServiceTopView alloc] init];
        [self.view addSubview:_topView];
    }
    return _topView;
}
-(TKSelectedView *)selectView{
    if (!_selectView) {
        CGFloat h = CGRectGetMaxY(self.topView.frame);
        _selectView = [[TKSelectedView alloc] initWithFrame:CGRectMake(0, h, kScreenWidth, kScreenHeight - h)];
        WS(weakSelf);
        _selectView.selectedViewDidDoneBlock = ^(KeyValueModel * _Nonnull model) {
            weakSelf.selectedModel = model;
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
