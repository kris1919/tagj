//
//  BillModel.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillModel : NSObject

@property (nonatomic ,copy)NSString *billId;

@property (nonatomic ,copy)NSString *title;

@property (nonatomic ,copy)NSString *memo;

@property (nonatomic ,copy)NSString *pudate;

@property (nonatomic ,copy)NSString *zt;

@end

NS_ASSUME_NONNULL_END
