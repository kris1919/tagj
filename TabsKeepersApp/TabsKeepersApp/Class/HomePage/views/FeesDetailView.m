//
//  FeesDetailView.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "FeesDetailView.h"
#import "UIColor+Theme.h"

@interface FeesDetailView ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;

@property (nonatomic ,strong)UIView *mask;

@end

@implementation FeesDetailView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    CGRect rect = CGRectMake((kScreenWidth - 320) / 2, (kScreenHeight * 0.25), 320, 300);
    self.frame = rect;
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.mask];
    [window addSubview:self];
}
- (IBAction)hide:(id)sender{
    [self.mask removeFromSuperview];
    [self removeFromSuperview];
}

-(void)setModel:(FeesListModel *)model{
    NSString *str1 = @"上月抄表数：";
    NSString *str2 = @"本月抄表数：";
    NSString *str3 = @"周期：";
    NSString *str4 = @"单价：";
    NSString *str5 = @"合计：";
    NSDictionary *para = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]};
    NSMutableAttributedString *s1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str1,model.biao1]];
    [s1 addAttributes:para range:NSMakeRange(0, str1.length)];
    self.label1.attributedText = s1;
    
    NSMutableAttributedString *s2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str2,model.biao2]];
    [s2 addAttributes:para range:NSMakeRange(0, str2.length)];
    self.label2.attributedText = s2;
    
    NSMutableAttributedString *s3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str3,model.zhouqi]];
    [s3 addAttributes:para range:NSMakeRange(0, str3.length)];
    self.label3.attributedText = s3;
    
    NSMutableAttributedString *s4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str4,model.danjia]];
    [s4 addAttributes:para range:NSMakeRange(0, str4.length)];
    self.label4.attributedText = s4;
    
    NSString *ssss = [NSString stringWithFormat:@"%@%@",str5,model.sum];
    NSMutableAttributedString *s5 = [[NSMutableAttributedString alloc] initWithString:ssss];
    [s5 addAttributes:para range:NSMakeRange(0, str5.length)];
    self.label5.attributedText = s5;
}

-(void)setWyModel:(WYFeesModel *)wyModel{
    NSString *str1 = @"面积：";
    NSString *str2 = @"单价：";
    NSString *str3 = @"周期：";
    NSString *str4 = @"月数：";
    NSString *str5 = @"合计：";
    NSDictionary *para = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]};
    NSMutableAttributedString *s1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str1,wyModel.size]];
    [s1 addAttributes:para range:NSMakeRange(0, str1.length)];
    self.label1.attributedText = s1;
    
    NSMutableAttributedString *s2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str2,wyModel.danjia]];
    [s2 addAttributes:para range:NSMakeRange(0, str2.length)];
    self.label2.attributedText = s2;
    
    NSMutableAttributedString *s3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str3,wyModel.zhouqi]];
    [s3 addAttributes:para range:NSMakeRange(0, str3.length)];
    self.label3.attributedText = s3;
    
    NSMutableAttributedString *s4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str4,wyModel.yueNum]];
    [s4 addAttributes:para range:NSMakeRange(0, str4.length)];
    self.label4.attributedText = s4;
    
    NSString *ssss = [NSString stringWithFormat:@"%@%@",str5,wyModel.sum];
    NSMutableAttributedString *s5 = [[NSMutableAttributedString alloc] initWithString:ssss];
    [s5 addAttributes:para range:NSMakeRange(0, str5.length)];
    self.label5.attributedText = s5;
}

-(UIView *)mask{
    if (!_mask) {
        _mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _mask.backgroundColor = [UIColor colorWithR:0 G:0 B:0 A:0.4];
    }
    return _mask;
}

@end
