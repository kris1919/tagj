//
//  HomeHeaderCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/28.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "HomeHeaderCell.h"
#import <Masonry.h>
#import "UIFont+PingFangSC.h"
#import "HomeHeaderCollectionCell.h"

@interface HomeHeaderCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong)UIImageView *bgImageView;
@property (nonatomic ,strong)UIImageView *adImageView;
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong)UIImageView *locationImageView;
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)NSMutableArray *dataArr;

@end

@implementation HomeHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        NSArray *icons = @[@"icon_home_waterfee",@"icon_home_note",@"icon_home_carfee",@"icon_home_repaire",@"icon_home_fee",@"icon_home_servce",@"icon_home_video",@"icon_home_store"];
        NSArray *titles = @[@"水费代缴",@"小区公告",@"停车缴费",@"业主报修",@"物业缴费",@"便民服务",@"监控中心",@"商城"];
        for (NSString *icon in icons) {
            NSInteger index = [icons indexOfObject:icon];
            NSString *title = [titles objectAtIndex:index];
            HomeCollectIconModel *model = [[HomeCollectIconModel alloc] initWithIcon:icon title:title];
            [self.dataArr addObject:model];
        }
        [self addMasonry];
    }
    return self;
}
- (void)addMasonry{
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(@(224));
    }];
    [self.adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom).offset(15);
        make.height.mas_equalTo(self.adImageView.mas_width).multipliedBy(0.45);
    }];
    CGFloat topMargin = kIPhoneXSeries ? 45 : 32;
    [self.locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(topMargin);
        make.width.mas_equalTo(@(26));
        make.height.mas_equalTo(@(24));
        make.centerX.mas_equalTo(self).offset(-50);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).offset(15);
        make.centerY.mas_equalTo(self.locationImageView.mas_centerY);
    }];
    CGFloat heigth = (kScreenWidth - 30) / 4.0 * 2;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.adImageView.mas_bottom).offset(15);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(@(heigth));
    }];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        CGFloat width = (kScreenWidth - 30) / 4.0;
        layout.itemSize = CGSizeMake(width, width);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[HomeHeaderCollectionCell class] forCellWithReuseIdentifier:@"HomeHeaderCollectionCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

-(UIImageView *)locationImageView{
    if (!_locationImageView) {
        _locationImageView = [[UIImageView alloc] init];
        _locationImageView.image = [UIImage imageNamed:@"icon_home_location"];
        [self addSubview:_locationImageView];
    }
    return _locationImageView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"天安别墅";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont pingFangFontOfSize:22];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"icon_home_top"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_bgImageView];
    }
    return _bgImageView;
}

-(UIImageView *)adImageView{
    if (!_adImageView) {
        _adImageView = [UIImageView new];
        _adImageView.layer.cornerRadius = 8;
        _adImageView.clipsToBounds = YES;
        _adImageView.contentMode = UIViewContentModeScaleAspectFill;
        _adImageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_adImageView];
    }
    return _adImageView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeHeaderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHeaderCollectionCell" forIndexPath:indexPath];
    cell.iconModel = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(indexPath.row);
    }
}

@end
