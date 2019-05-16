//
//  FFBannerViewCell.m
//  BannerView
//
//  Created by tsfa on 2018/4/10.
//  Copyright © 2018年 tsfa. All rights reserved.
//

#import "FFBannerViewCell.h"
#import <UIImageView+WebCache.h>

@interface FFBannerViewCell()
@property (nonatomic ,strong)UIImageView *imageView;
@end
//
@implementation FFBannerViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.imageView];
        self.imageView.frame = CGRectMake(16, 0, CGRectGetWidth(self.frame) - 32, CGRectGetHeight(self.frame));
    }
    return self;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius = 10;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}

-(void)setImageUrl:(NSString *)imageUrl{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

@end
