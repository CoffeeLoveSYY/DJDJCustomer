//
//  MineMakeInvoiceItemCell.h
//  FullCategory
//
//  Created by 浩杰 on 2023/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineMakeInvoiceItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *muLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic , copy) void(^endEdittingBlock)(NSString *string);

@end

NS_ASSUME_NONNULL_END
