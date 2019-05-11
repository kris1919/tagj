//
//  HomeHeaderCollectionCell.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/28.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface HomeCollectIconModel : NSObject

@property (nonatomic ,copy)NSString *iconStr;
@property (nonatomic ,copy)NSString *titleStr;

-(instancetype)initWithIcon:(NSString *)icon title:(NSString *)title;

@end

@interface HomeHeaderCollectionCell : UICollectionViewCell

@property (nonatomic ,strong)HomeCollectIconModel *iconModel;


@end

NS_ASSUME_NONNULL_END
