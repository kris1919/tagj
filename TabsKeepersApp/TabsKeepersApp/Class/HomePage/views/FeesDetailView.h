//
//  FeesDetailView.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeesListModel.h"
#import "WYFeesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeesDetailView : UIView


- (void)show;


@property (nonatomic ,strong)FeesListModel *model;


@property (nonatomic ,strong)WYFeesModel *wyModel;

@end

NS_ASSUME_NONNULL_END
