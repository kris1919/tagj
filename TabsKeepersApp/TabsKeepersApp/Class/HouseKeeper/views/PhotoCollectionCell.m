//
//  PhotoCollectionCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/5.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "PhotoCollectionCell.h"
#import <UIImageView+WebCache.h>

@interface PhotoCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end

@implementation PhotoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.picView.contentMode = UIViewContentModeScaleAspectFill;
    self.picView.clipsToBounds = YES;
}

-(void)setImagePath:(NSString *)imagePath{
    if (imagePath) {
        if ([imagePath containsString:@"http"]) {
            [self.picView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
        }else{
            self.picView.image = [UIImage imageNamed:imagePath];
        }
    }
}

-(void)setCloseBtnHidden:(BOOL)closeBtnHidden{
    self.closeBtn.hidden = closeBtnHidden;
}

- (IBAction)closeBtnAction:(UIButton *)sender {
    if (self.deleteImageBlock) {
        self.deleteImageBlock(self.indexPath.row);
    }
}

@end
