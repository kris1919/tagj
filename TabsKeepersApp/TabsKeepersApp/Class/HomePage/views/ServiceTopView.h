//
//  ServiceTopView.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServiceTopView : UIView

@property (nonatomic ,copy)void (^buttonClickedBlock)(void);


@property (nonatomic ,copy)NSString *leibeiStr;


@end

NS_ASSUME_NONNULL_END
