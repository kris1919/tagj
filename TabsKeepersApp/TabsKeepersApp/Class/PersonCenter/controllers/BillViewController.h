//
//  BillViewController.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillViewController : UIViewController

@property (nonatomic ,copy)void (^notiDidReadBlock)(void);

@end

NS_ASSUME_NONNULL_END
