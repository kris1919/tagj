//
//  TKSelectedView.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyValueModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKSelectedView : UIView

@property (nonatomic ,strong)NSArray<KeyValueModel *> *dataArr;

@property (nonatomic ,copy)void (^selectedViewDidDoneBlock)(KeyValueModel *model);

@end

NS_ASSUME_NONNULL_END
