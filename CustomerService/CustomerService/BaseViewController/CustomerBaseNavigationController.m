//
//  CustomerBaseNavigationController.m
//  DDMassage
//
//  Created by 陈红波 on 2023/5/5.
//

#import "CustomerBaseNavigationController.h"

@interface CustomerBaseNavigationController ()

@end

@implementation CustomerBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBarAppearance *apperarance = [[UINavigationBarAppearance alloc] init];
    [apperarance configureWithOpaqueBackground];
    
    apperarance.backgroundColor = [UIColor whiteColor];
    apperarance.shadowColor = [UIColor whiteColor];
    
    self.navigationBar.standardAppearance = apperarance;
    if (@available(iOS 15.0, *)) {
        self.navigationBar.scrollEdgeAppearance = apperarance;
    }
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count==0) {
        [super pushViewController:viewController animated:animated];
        return;
    }else{
        viewController.hidesBottomBarWhenPushed=YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

@end
