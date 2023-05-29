//
//  MineInvoiceCommentVC.h
//  FullCategory
//
//  Created by 浩杰 on 2023/3/11.
//

#import "CustomerBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineInvoiceCommentVC : CustomerBaseViewController

@property (nonatomic,strong)NSString *admin_id;
@property (nonatomic,strong)NSString *chat_id;

- (void)presentFromViewController:(UIViewController *)viewController completionBlock:(void(^)(void))completionBlock;

@end

NS_ASSUME_NONNULL_END
