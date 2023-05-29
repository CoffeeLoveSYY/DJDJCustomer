//
//  CustomerConfig.m
//  YueDongDong
//
//  Created by 李杭玖 on 2023/5/29.
//

#import "CustomerConfig.h"

@implementation CustomerConfig

+ (instancetype)sharedInstance {
    static CustomerConfig *sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedUser = [[self alloc] init];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        sharedUser.userId=[defaults objectForKey:@"id"];
        sharedUser.token=[defaults objectForKey:@"token"];
        sharedUser.serviceAddress=[defaults objectForKey:@"serviceAddress"];
        
    });
    return sharedUser;
}

- (void)synchronize{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.userId forKey:@"id"];
    [defaults setObject:self.token forKey:@"token"];
    [defaults setObject:self.serviceAddress forKey:@"serviceAddress"];
    
    [defaults synchronize];
}

@end
