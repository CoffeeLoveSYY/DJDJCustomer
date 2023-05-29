//
//  CustomerConfig.h
//  YueDongDong
//
//  Created by 李杭玖 on 2023/5/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomerConfig : NSObject

@property (nonatomic,strong)NSString *token;

@property (nonatomic,strong)NSString *userId;

@property (nonatomic,strong)NSString *serviceAddress;

@property (nonatomic,strong)CustomerBaseViewController *loginVCString;

@property (nonatomic,strong)NSString *backImageString;

+ (CustomerConfig *)sharedInstance;
- (void)synchronize;

@end

NS_ASSUME_NONNULL_END
