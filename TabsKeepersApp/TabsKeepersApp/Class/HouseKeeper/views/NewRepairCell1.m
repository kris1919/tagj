//
//  NewRepairCell1.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/3.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "NewRepairCell1.h"

@interface NewRepairCell1 ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *baoxiuBtn;
@property (weak, nonatomic) IBOutlet UITextView *inputView;

@end

@implementation NewRepairCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.inputView.delegate = self;
}
- (IBAction)baoxiuBtnClicked:(id)sender {
    if (self.selectBtnClicked) {
        self.selectBtnClicked();
    }
}
-(void)setSelectStr:(NSString *)selectStr{
    [self.baoxiuBtn setTitle:selectStr forState:UIControlStateNormal];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.textViewDidEndEditing) {
        self.textViewDidEndEditing(textView.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
