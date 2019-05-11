//
//  PhotoCollectionCell.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/5.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollectionCell : UICollectionViewCell

@property (nonatomic ,copy)NSString *imagePath;

@property (nonatomic ,copy)void(^deleteImageBlock)(void);

@end

NS_ASSUME_NONNULL_END
