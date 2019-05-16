//
//  ServerListModel.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServerListModel : NSObject

@property (nonatomic ,copy)NSString *shopId;

@property (nonatomic ,copy)NSString *shopName;

@property (nonatomic ,copy)NSString *phone;

@property (nonatomic ,copy)NSString *address;

@property (nonatomic ,copy)NSString *img;

@property (nonatomic ,copy)NSString *url;


@end

NS_ASSUME_NONNULL_END
