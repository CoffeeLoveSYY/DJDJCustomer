//
//  CustomerRequestHelper.m
//  FullCategory
//
//  Created by 李杭玖 on 2023/3/9.
//

#define NoNetworkAlert @"网络异常请稍后重试"
#define ServerErrorAlert @"服务器繁忙"

#import <Foundation/Foundation.h>

#import <AFHTTPSessionManager.h>

typedef enum : NSUInteger {
    RequestTypePost,
    RequestTypeGet
} RequestType;

typedef void (^RequestSuccess)(NSMutableDictionary * _Nullable responseDic);
typedef void (^RequestFailure)(int failureCode,NSString * _Nullable message);

NS_ASSUME_NONNULL_BEGIN

@interface CustomerRequestHelper : NSObject

+ (AFHTTPSessionManager *)shareAFManager;

+ (CustomerRequestHelper *)helper;

- (void)GET:(NSString *)url Parameters:(NSMutableDictionary *)parameters HUD:(BOOL)isShow success:(RequestSuccess)success failure:(RequestFailure)failure;

- (void)POST:(NSString *)url Parameters:(NSMutableDictionary *)parameters HUD:(BOOL)isShow success:(RequestSuccess)success failure:(RequestFailure)failure;

- (void)UploadPhoto:(NSString *)urlString Parameters:(id)parameter HUD:(BOOL)isShow success:(RequestSuccess)success failure:(RequestFailure)failure;
    
@end

NS_ASSUME_NONNULL_END
