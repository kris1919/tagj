//
//  AddFamilyViewController.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddFamilyViewController : TKBaseViewController

@property (nonatomic ,copy)void (^didAddNewFamilyMemberBlock)(void);

@end

NS_ASSUME_NONNULL_END
