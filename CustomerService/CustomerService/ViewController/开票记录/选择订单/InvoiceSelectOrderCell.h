//
//  InvoiceSelectOrderCell.h
//  FullCategory
//
//  Created by 浩杰 on 2023/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InvoiceSelectOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic , copy) void(^clickSendBlock)(void);

@end

NS_ASSUME_NONNULL_END
