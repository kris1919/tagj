//
//  TKRegisterViewController.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/25.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKRegisterViewController : TKBaseViewController

@property (nonatomic ,copy)void (^resetPwdSuccess)(NSString *phone,NSString *pwd);

@end

NS_ASSUME_NONNULL_END
