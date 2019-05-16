//
//  WaterFeeViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "WaterFeeViewController.h"
#import "TKTableView.h"
#import "MCNetworking.h"
#import "TKCycleData.h"
#import <Masonry.h>
#import <YYModel.h>
#import "WYFeeModel.h"
#import "TKRefreshHeader.h"
#import "TKRefreshFooter.h"
#import "WaterFeeTableViewCell.h"
#import "WaterSectionView.h"
#import "UIColor+Theme.h"

@interface WaterFeeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,assign)NSInteger currentPage;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@end

@implementation WaterFeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.currentPage = 1;
    // Do any additional setup after loading the view.
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
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
    
    [self.tableView.mj_header beginRefreshing];
}
//- (NSArray *)arrrr{
//    return @[@{
//                 @"date1": @"2019.1",
//                 @"date2": @"2019.3",
//                 @"dun": @"10",
//                 @"money": @"529.2",
//                 @"zffs": @"1",
//                 @"zfDate": @"1月5日"
//                 },
//             @{
//                 @"date1": @"2019.1",
//                 @"date2": @"2019.3",
//                 @"dun": @"10",
//                 @"money": @"529.2",
//                 @"zffs": @"1",
//                 @"zfDate": @"1月5日"
//                 }
//             ];
//}
- (void)requestData{
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSString *urlStr =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantFeeWater];
    NSDictionary *param = @{@"customId":userModel.customId,
                            @"page":@(self.currentPage)
                            };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        NSArray *listArr = [resDic objectForKey:@"list"];
        for (NSDictionary *d in listArr) {
            WYFeeModel *model = [WYFeeModel yy_modelWithJSON:d];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WaterFeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WaterFeeTableViewCell" forIndexPath:indexPath];
    WYFeeModel *model = [self.dataArr objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WaterSectionView *view = (WaterSectionView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WaterSectionView"];
    if (!view) {
        view = [[WaterSectionView alloc] init];
    }
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(TKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"WaterFeeTableViewCell" bundle:nil] forCellReuseIdentifier:@"WaterFeeTableViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        _tableView.backgroundColor = [UIColor colorWithR:249 G:249 B:249 A:1];

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
