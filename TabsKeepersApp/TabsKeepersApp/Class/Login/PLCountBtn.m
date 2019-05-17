//
//  PLCountBtn.m
//  postLoanApp
//
//  Created by tsfa on 2018/12/6.
//  Copyright © 2018 Marco. All rights reserved.
//

#import "PLCountBtn.h"
#import "UIFont+PingFangSC.h"

@interface PLCountBtn ()
@property (nonatomic ,strong)NSTimer *timer;
@property (nonatomic ,assign)NSInteger tempCount;

@end

@implementation PLCountBtn

-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.count = 60;
    [self setTitle:@"验证码" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    self.titleLabel.font = [UIFont pingFangFontOfSize:14];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(minusCount) userInfo:nil repeats:YES];
    [self addTarget:self action:@selector(btnClickedHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.timer setFireDate:[NSDate distantFuture]];
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.count = 60;
        [self setTitle:@"验证码" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont pingFangFontOfSize:14];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(minusCount) userInfo:nil repeats:YES];
        [self addTarget:self action:@selector(btnClickedHandler) forControlEvents:UIControlEventTouchUpInside];
        [self.timer setFireDate:[NSDate distantFuture]];
    }
    return self;
}

- (void)minusCount{
    if (self.tempCount > 0) {
        [self setTitle:[NSString stringWithFormat:@"%@s后重新获取",@(self.tempCount)] forState:UIControlStateDisabled];
        self.enabled = NO;
        self.tempCount--;
    }else{
        self.tempCount = self.count;
        [self.timer setFireDate:[NSDate distantFuture]];
        self.enabled = YES;
         [self setTitle:@"验证码" forState:UIControlStateNormal];
    }
}

- (void)btnClickedHandler{
    if (self.loginBtnCLicked) {
        self.loginBtnCLicked(self);
    }
}

-(void)setCount:(NSInteger)count{
    _count = count;
    self.tempCount = count;
}

-(void)startCount{
    [self.timer setFireDate:[NSDate date]];
}
@end
