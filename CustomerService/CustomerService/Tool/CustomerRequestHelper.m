//
//  CustomerRequestHelper.m
//  FullCategory
//
//  Created by 李杭玖 on 2023/3/9.
//

#import "CustomerRequestHelper.h"

@interface CustomerRequestHelper ()

@end

@implementation CustomerRequestHelper

+ (CustomerRequestHelper *)helper {
    CustomerRequestHelper *helper=[[CustomerRequestHelper alloc] init];
    return helper;
}

+ (AFHTTPSessionManager *)shareAFManager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager=[AFHTTPSessionManager manager];
        [manager.requestSerializer setTimeoutInterval:30];
        
        AFJSONResponseSerializer *serializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
        serializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        manager.responseSerializer=serializer;
        
    });
    return manager;
}

- (void)GET:(NSString *)url
  Parameters:(NSMutableDictionary *)parameters
         HUD:(BOOL)isShow
     success:(RequestSuccess)success
     failure:(RequestFailure)failure{
    
    CustomerReachability *r=[CustomerReachability reachabilityForInternetConnection];
    if ([r currentReachabilityStatus]==NotReachable) {
        if (failure) {
            failure(-2,NoNetworkAlert);
        }
        return;
    }

    if (parameters.count==0 || parameters==nil) {
        parameters=[[NSMutableDictionary alloc] init];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHH"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    [parameters setValue:[CustomerConfig sharedInstance].token forKey:@"token"];
    [parameters setValue:[CustomerConfig sharedInstance].userId forKey:@"userid"];
    [parameters setValue:[CustomerConfig sharedInstance].userId forKey:@"user_id"];
    [parameters setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [parameters setValue:[NSString stringWithFormat:@"imdewang%@",dateTime] forKey:@"isdebug"];
    [parameters setValue:@"1" forKey:@"is_local"];
    [parameters setValue:@"dXJkZXdhbmc=dXJkZXdhbmc=" forKey:@"the_wang"];

    if (isShow) {
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
    
    if ([url isEqualToString:@"/call/user/chat/idle_admin"] ||
        [url isEqualToString:@"/call/user/chat/history"] ||
        [url isEqualToString:@"/call/user/invoice/orders"] ||
        [url isEqualToString:@"/call/user/chat/evaluation"] ||
        [url isEqualToString:@"/call/user/invoice/make"]){
        url=[@"https://sujki.dongjiaoapp.com" stringByAppendingString:url];
    }

    if (![url containsString:@"http"]){
        url=[[CustomerConfig sharedInstance].serviceAddress stringByAppendingString:url];
    }
    
    AFHTTPSessionManager *manager=[CustomerRequestHelper shareAFManager];
    [manager.requestSerializer setValue:[CustomerConfig sharedInstance].token forHTTPHeaderField:@"token"];

    [manager GET:url parameters:parameters headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {


    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (isShow) {
            [SVProgressHUD dismiss];
        }

        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]){

            if ([responseObject dicFloatForKey:@"code"]==1){

                success(responseObject);

            }else if ([responseObject dicFloatForKey:@"code"]==401){

                [self LoginClear];
                
            }else{

                failure([[responseObject dicStringForKey:@"code"] intValue],[responseObject dicStringForKey:@"msg"]);

            }

        }else {

            if (failure) {
                failure(0,ServerErrorAlert);
            }

        }


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [SVProgressHUD dismiss];
        
        NSString *string=[self error:error];
        if ([string isEqualToString:@"401"]){
            [self LoginClear];
        }else{
            if (failure) {
                failure(0,[self error:error]);
            }
        }

    }];

}

- (void)POST:(NSString *)url
  Parameters:(NSMutableDictionary *)parameters
         HUD:(BOOL)isShow
     success:(RequestSuccess)success
     failure:(RequestFailure)failure{
    
    CustomerReachability *r=[CustomerReachability reachabilityForInternetConnection];
    if ([r currentReachabilityStatus]==NotReachable) {
        if (failure) {
            failure(-2,NoNetworkAlert);
        }
        return;
    }

    if (parameters.count==0 || parameters==nil) {
        parameters=[[NSMutableDictionary alloc] init];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHH"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    [parameters setValue:[CustomerConfig sharedInstance].token forKey:@"token"];
    [parameters setValue:[CustomerConfig sharedInstance].userId forKey:@"userid"];
    [parameters setValue:[CustomerConfig sharedInstance].userId forKey:@"user_id"];
    [parameters setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [parameters setValue:[NSString stringWithFormat:@"imdewang%@",dateTime] forKey:@"isdebug"];
    [parameters setValue:@"1" forKey:@"is_local"];
    [parameters setValue:@"dXJkZXdhbmc=dXJkZXdhbmc=" forKey:@"the_wang"];

    if (isShow) {
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }

    if ([url isEqualToString:@"/call/user/chat/idle_admin"] ||
        [url isEqualToString:@"/call/user/chat/history"] ||
        [url isEqualToString:@"/call/user/invoice/orders"] ||
        [url isEqualToString:@"/call/user/chat/evaluation"] ||
        [url isEqualToString:@"/call/user/invoice/make"]){
        url=[@"https://sujki.dongjiaoapp.com" stringByAppendingString:url];
    }

    if (![url containsString:@"http"]){
        url=[[CustomerConfig sharedInstance].serviceAddress stringByAppendingString:url];
    }
    
    AFHTTPSessionManager *manager=[CustomerRequestHelper shareAFManager];
    [manager.requestSerializer setValue:[CustomerConfig sharedInstance].token forHTTPHeaderField:@"token"];

    [manager POST:url parameters:parameters headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {


    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (isShow) {
            [SVProgressHUD dismiss];
        }

        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]){

            if ([responseObject dicFloatForKey:@"code"]==1){

                success(responseObject);

            }else if ([responseObject dicFloatForKey:@"code"]==401){

                [self LoginClear];
                
            }else{

                failure([[responseObject dicStringForKey:@"code"] intValue],[responseObject dicStringForKey:@"msg"]);

            }

        }else {

            if (failure) {
                failure(0,ServerErrorAlert);
            }

        }


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [SVProgressHUD dismiss];
        
        NSString *string=[self error:error];
        if ([string isEqualToString:@"401"]){
            [self LoginClear];
        }else{
            if (failure) {
                failure(0,[self error:error]);
            }
        }

    }];
    
}

- (void)UploadPhoto:(NSString *)urlString
                       Parameters:(id)parameter
                              HUD:(BOOL)isShow
                          success:(RequestSuccess)success
                          failure:(RequestFailure)failure{
    
    CustomerReachability *r = [CustomerReachability reachabilityForInternetConnection];
    if ([r currentReachabilityStatus] == NotReachable) {
        if (failure) {
            failure(-2,NoNetworkAlert);
        }
        return;
    }
    
    if (parameter==nil) {
        if (failure) {
            failure(-2,NoNetworkAlert);
        }
        return;
    }
    
    if (isShow==YES) {
        [SVProgressHUD showWithStatus:@"正在上传..."];
        [SVProgressHUD show];
    }
    
    urlString=[[CustomerConfig sharedInstance].serviceAddress stringByAppendingString:urlString];
    AFHTTPSessionManager *manager=[CustomerRequestHelper shareAFManager];
    
    [manager POST:urlString parameters:parameter headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        NSData *imageDatas=UIImageJPEGRepresentation(parameter,1.0f);
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString=[formatter stringFromDate:[NSDate date]];
        
        NSString *fileName=[NSString stringWithFormat:@"%@%d.png",dateString,arc4random()%999];
        [formData appendPartWithFileData:imageDatas name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (responseObject && [responseObject isKindOfClass:[NSMutableDictionary class]]) {

            if ([[responseObject dicStringForKey:@"code"] integerValue]==1){
                
                success(responseObject);
                
            }else if ([[responseObject dicStringForKey:@"code"] integerValue]==401){
                
                failure([[responseObject dicStringForKey:@"code"] intValue],[responseObject dicStringForKey:@"msg"]);
                [self LoginClear];
                
            }else{
                
                failure([[responseObject dicStringForKey:@"code"] intValue],[responseObject dicStringForKey:@"msg"]);
                
            }
            
        }else {
            
            if (failure) {
                failure(0,ServerErrorAlert);
            }
            
    
        }
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        
        NSString *string=[self error:error];
        if ([string isEqualToString:@"401"]){
            [self LoginClear];
        }else{
            if (failure) {
                failure(0,[self error:error]);
            }
        }
        
    }];
    
}


- (void)LoginClear{
    
    [[UIApplication sharedApplication].delegate.window makeToast:@"登录失效,请重新登录" duration:2 position:CSToastPositionCenter];
    
    CustomerBaseViewController *login=[CustomerConfig sharedInstance].loginVCString;
    if ([[self getTopViewController] isKindOfClass:[UIViewController class]]){
        return;
    }
    [[self getTopViewController].navigationController pushViewController:login animated:YES];
    
}

- (NSString *)error:(NSError * _Nullable)error {
    
    NSString *message = @"网络错误，请重试";
    
    if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
        
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSDictionary *serializedData = [NSDictionary dictionary];
        
        if(errorData){
            serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        }
        
        if (serializedData && [serializedData isKindOfClass:[NSDictionary class]]) {
            NSString *code = [NSString stringWithFormat:@"%@",serializedData[@"code"]];
            if ([code isEqual:@"401"]) {
                [self LoginClear];
                return @"401";
            }
            
        }
        
    } else if ([error.domain isEqualToString:NSCocoaErrorDomain]) {
        
        message = @"网络错误，请重试";
        
    } else if ([error.domain isEqualToString:NSURLErrorDomain]) {
        
        if (error.code == -1001) {
            
            message = @"网络请求超时，请重试";
            
        }else if (error.code == -1009) {
            
            message = @"当前网络不可用，请检查网络";
            
        }else{
            
            message = @"网络错误，请重试";
            
        }
    }
    return message;
}

- (UIViewController*)getTopViewController {
    
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
    
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
        
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *nav = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
        
    } else if (rootViewController.presentedViewController) {
        
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
        
    } else {
        
        return rootViewController;
        
    }
}


@end
