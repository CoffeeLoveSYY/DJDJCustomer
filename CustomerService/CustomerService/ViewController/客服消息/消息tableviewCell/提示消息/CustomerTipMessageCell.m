//
//  CustomerTipMessageCell.m
//  CustomerService
//
//  Created by 李杭玖 on 2023/5/25.
//

#import "CustomerTipMessageCell.h"

@interface CustomerTipMessageCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelWidth;

@end

@implementation CustomerTipMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.titleLabel.layer.cornerRadius=13;
    self.titleLabel.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic=dataDic;
    [self initUIData];
}

- (void)initUIData{
    
    NSDictionary *body=[self.dataDic dicValueforKey:@"body"];
    
    if (body.count!=0){
        
        NSString *content=[body dicStringForKey:@"content"];
        self.titleLabel.text=content;
        
        self.titleLabelWidth.constant=[CustomerUtils calculateWidthWithString:content height:26 font:self.titleLabel.font]+20;
        
    }
    
   [self layoutIfNeeded];
}

@end
