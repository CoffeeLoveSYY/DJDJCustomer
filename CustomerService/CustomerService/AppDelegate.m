//
//  AppDelegate.m
//  CustomerService
//
//  Created by 李杭玖 on 2023/5/22.
//

#import "AppDelegate.h"

#import "CustomerMessageController.h"
#import "CustomerBaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CustomerMessageController *vc=[[CustomerMessageController alloc] init];
    CustomerBaseNavigationController *navigationVC=[[CustomerBaseNavigationController alloc] initWithRootViewController:vc];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = navigationVC;
    [self.window makeKeyAndVisible];
    self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    
    return YES;
}


@end
