//
//  CustomerBaseViewController.m
//  DDMassage
//
//  Created by 陈红波 on 2023/5/5.
//

#import "CustomerBaseViewController.h"

@interface CustomerBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation CustomerBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    //得到最上层VC
    UINavigationController *navigationVC=self.navigationController;
    if (navigationVC) {
        UIViewController *firstVC=navigationVC.viewControllers[0];
        if (self!=firstVC) {
            [self initView];
        }
    }
    
}

- (void)initView{
    
    UIButton *backBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [backBtn setImage:[UIImage imageNamed:[CustomerConfig sharedInstance].backImageString] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftItem;

}

- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (void)setNavigationViewColor:(UIColor *)color{
    
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    [appearance configureWithOpaqueBackground];
    
    appearance.backgroundColor = color;
    appearance.shadowColor=color;
    
    self.navigationController.navigationBar.standardAppearance = appearance;
    self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    
}

- (void)showMessage:(NSString *)message{
    [[UIApplication sharedApplication].delegate.window makeToast:message duration:2 position:CSToastPositionCenter];
}

@end
