//
//  NewRepairCell2.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/3.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewRepairCell2 : UITableViewCell

@property (nonatomic ,assign)BOOL canEditing;

@property (nonatomic ,strong)NSMutableArray *imgs;

@property (nonatomic ,copy)void (^selectedImg)(NSInteger index ,BOOL show,UICollectionViewCell *collectCell);

@property (nonatomic ,copy)void (^deleteImg)(NSInteger index);


@end

NS_ASSUME_NONNULL_END
