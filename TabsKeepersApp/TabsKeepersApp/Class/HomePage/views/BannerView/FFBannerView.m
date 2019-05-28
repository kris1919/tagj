//
//  FFBannerView.m
//  BannerView
//
//  Created by tsfa on 2018/4/10.
//  Copyright © 2018年 tsfa. All rights reserved.
//

#import "FFBannerView.h"
#import "FFBannerFlowLayout.h"
#import "FFBannerViewCell.h"
#import <AVFoundation/AVFoundation.h>
#define kTimePadding 3

@interface FFBannerView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong)UIPageControl *pageControl;
@property (nonatomic ,strong)NSTimer *myTimer;
@property (nonatomic ,strong)NSMutableArray *images;
@end

@implementation FFBannerView

-(void)dealloc{
    if (_myTimer) {
        [self.myTimer invalidate];
        self.myTimer = nil;
    }
}

-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images{
    self = [super initWithFrame:frame];
    if (self) {
        self.images = images.mutableCopy;
        [self setupUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _itemScale = 1;
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}

- (void)timerAction{
    CGFloat offX = self.collectionView.contentOffset.x;
    CGPoint point = CGPointMake(offX + self.collectionView.frame.size.width, 0);
    [self.collectionView setContentOffset:point animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_myTimer) {
        [self.myTimer setFireDate:[NSDate distantFuture]];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_myTimer) {
        [self.myTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:kTimePadding]];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.autoScroll) {
        NSInteger page = (int)self.collectionView.contentOffset.x / CGRectGetWidth(self.collectionView.bounds);
        self.pageControl.currentPage = page;
    }else{
        if (self.collectionView.contentOffset.x > self.collectionView.frame.size.width * (self.images.count - 1)) {
            [self.collectionView setContentOffset:CGPointMake(CGRectGetWidth(self.collectionView.bounds), 0) animated:NO];
        }
        if (self.collectionView.contentOffset.x < self.collectionView.frame.size.width) {
            [self.collectionView setContentOffset:CGPointMake(CGRectGetWidth(self.collectionView.bounds) *(self.images.count - 1), 0) animated:NO];
        }
        NSInteger page = (int)self.collectionView.contentOffset.x / CGRectGetWidth(self.collectionView.bounds);
        page = page == (self.images.count - 1)  ? 0 : page;
        self.pageControl.currentPage = page - 1;
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    self.collectionView.contentOffset = CGPointMake(CGRectGetWidth(self.collectionView.bounds) * self.autoScroll, 0);
    self.pageControl.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 30, CGRectGetWidth(self.bounds), 30);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FFBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bannerCell" forIndexPath:indexPath];
    id image = [self.images objectAtIndex:indexPath.row];
    if ([image isKindOfClass:[UIImage class]]) {
        cell.image = image;
    }else{
        cell.imageUrl = image;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectedItemBlock) {
        NSInteger page = (int)self.collectionView.contentOffset.x / CGRectGetWidth(self.collectionView.bounds);
        page = page == (self.images.count - 1) ? 0 : (page == 0) ? self.images.count - 1 : page - 1;
        self.didSelectedItemBlock(page);
    }
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenWidth, (kScreenWidth - 30) * 0.45);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[FFBannerViewCell class] forCellWithReuseIdentifier:@"bannerCell"];
    }
    return _collectionView;
}
-(NSTimer *)myTimer{
    if (!_myTimer) {
        __weak __typeof(self) weakSelf = self;
        if (@available(iOS 10.0, *)) {
            _myTimer = [NSTimer timerWithTimeInterval:kTimePadding repeats:YES block:^(NSTimer * _Nonnull timer) {
                [weakSelf timerAction];
            }];
        } else {
            _myTimer = [NSTimer scheduledTimerWithTimeInterval:kTimePadding target:self selector:@selector(autoScrollAction) userInfo:nil repeats:YES];
        }
    }
    return _myTimer;
}
- (void)autoScrollAction{
    [self timerAction];
}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.numberOfPages = self.images.count;
    }
    return _pageControl;
}
-(void)setIndicatorTintColor:(UIColor *)indicatorTintColor{
    self.pageControl.pageIndicatorTintColor = indicatorTintColor;
}
-(void)setCurrentIndicatorTintColor:(UIColor *)currentIndicatorTintColor{
    self.pageControl.currentPageIndicatorTintColor = currentIndicatorTintColor;
}
-(void)setImagesAsssets:(NSArray<UIImage *> *)imagesAsssets{
    if (imagesAsssets.count > 0) {
        self.images = imagesAsssets.mutableCopy;
        self.pageControl.numberOfPages = imagesAsssets.count;
        self.autoScroll = self.autoScroll;
        [self.collectionView reloadData];
    }
}
-(void)setImagesUrl:(NSArray<NSString *> *)imagesUrl{
    if (imagesUrl.count > 0) {
        [self.myTimer invalidate];
        self.myTimer = nil;
        self.images = imagesUrl.mutableCopy;
        self.pageControl.numberOfPages = imagesUrl.count;
        self.autoScroll = YES;
        if (self.images.count > 0) {
            UIImage *firstImg = self.images.firstObject;
            UIImage *lastImg = self.images.lastObject;
            [self.images addObject:firstImg];
            [self.images insertObject:lastImg atIndex:0];
        }
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.bounds.size.width, 0) animated:NO];
        [[NSRunLoop mainRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
        [self.collectionView reloadData];
    }
}
-(void)setHidePageControl:(BOOL)hidePageControl{
    self.pageControl.hidden = hidePageControl;
}

@end
