//
//  TKSelectedView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKSelectedView.h"
#import "TKTableView.h"
#import <Masonry.h>
#import "UIFont+PingFangSC.h"
#import "UIColor+Theme.h"

@interface TKSelectedView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;

@end

@implementation TKSelectedView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithR:0 G:0 B:0 A:0.4];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappp)];
//        tap.cancelsTouchesInView = NO;
//        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)tappp{
    [self hide];
}

-(void)setDataArr:(NSArray<KeyValueModel *> *)dataArr{
    _dataArr = dataArr;
    CGFloat h = dataArr.count * 40 < CGRectGetHeight(self.bounds) ? dataArr.count * 40 : CGRectGetHeight(self.bounds);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self);
        make.width.mas_equalTo(@(120));
        make.height.mas_equalTo(@(h));
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.textLabel.font = [UIFont boldPingFangFontOfSize:16];
        cell.textLabel.textColor = [UIColor colorWithR:102 G:102 B:102 A:1];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    KeyValueModel *model = [self.dataArr objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
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
    if (self.selectedViewDidDoneBlock) {
        KeyValueModel *model = [self.dataArr objectAtIndex:indexPath.row];
        self.selectedViewDidDoneBlock(model);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hide];
}
- (void)hide{
    [self removeFromSuperview];
}

-(TKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    return _tableView;
}

@end
