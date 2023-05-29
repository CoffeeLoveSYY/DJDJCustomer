//
//  CustomerTextRightMessageCell.m
//  CustomerService
//
//  Created by 李杭玖 on 2023/5/25.
//

#import "CustomerTextRightMessageCell.h"

@interface CustomerTextRightMessageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation CustomerTextRightMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.headerImageView.layer.cornerRadius=20;
    self.headerImageView.layer.masksToBounds=YES;
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
    self.contentLabel.text=[body dicStringForKey:@"content"];
    
    NSDictionary *from_user=[self.dataDic dicValueforKey:@"from_user"];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[from_user dicStringForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"kefu"]];
 
    [self layoutIfNeeded];
}

@end
