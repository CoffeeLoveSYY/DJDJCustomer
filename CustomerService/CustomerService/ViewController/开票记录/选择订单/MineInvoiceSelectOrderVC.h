//
//  MineInvoiceSelectOrderVC.h
//  FullCategory
//
//  Created by 浩杰 on 2023/3/11.
//

#import "CustomerBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineInvoiceSelectOrderVC : CustomerBaseViewController

- (void)presentFromViewController:(UIViewController *)viewController selectOrderBlock:(void(^)(NSDictionary *orderDic))orderBlock;
@end

NS_ASSUME_NONNULL_END
