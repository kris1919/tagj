//
//  FFBannerView.h
//  BannerView
//
//  Created by tsfa on 2018/4/10.
//  Copyright © 2018年 tsfa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFBannerView : UIView

/**
 init methods

 @param frame frame
 @param images image assets
 @return instance
 */
-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;
/**
 images assets
 */
@property (nonatomic ,strong)NSArray<UIImage *> *imagesAsssets;

@property (nonatomic ,strong)NSArray<NSString *> *imagesUrl;
/**
 autoScroll default is NO.
 */
@property (nonatomic ,assign)BOOL autoScroll;

/**
 pageControl indicatorTintColor
 */
@property (nonatomic ,strong)UIColor *indicatorTintColor;

/**
 pageControl currentIndicatorTintColor
 */
@property (nonatomic ,strong)UIColor *currentIndicatorTintColor;


@property (nonatomic ,assign)CGFloat itemScale;

@property (nonatomic ,assign)BOOL hidePageControl;

@property (nonatomic ,copy)void (^didSelectedItemBlock)(NSInteger index);

@end
