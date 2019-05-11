//
//  PhotoCollectionCell.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/5.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "PhotoCollectionCell.h"

@interface PhotoCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picView;

@end

@implementation PhotoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.picView.backgroundColor = [UIColor lightGrayColor];
}

-(void)setImagePath:(NSString *)imagePath{
    if (imagePath) {
        self.picView.image = [UIImage imageNamed:imagePath];
    }
}

- (IBAction)closeBtnAction:(UIButton *)sender {
    if (self.deleteImageBlock) {
        self.deleteImageBlock();
    }
}

@end
