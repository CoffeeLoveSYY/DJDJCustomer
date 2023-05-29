//
//  CustomerOrderMessageCell.m
//  CustomerService
//
//  Created by 李杭玖 on 2023/5/25.
//

#import "CustomerOrderMessageCell.h"

@interface CustomerOrderMessageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *subBgView;
@property (weak, nonatomic) IBOutlet UIImageView *projectImageView;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectServiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectFinishLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceTimeLabel;


@end

@implementation CustomerOrderMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.headerImageView.layer.cornerRadius=20;
    self.headerImageView.layer.masksToBounds=YES;
    
    self.subBgView.layer.cornerRadius=10;
    self.subBgView.layer.masksToBounds=YES;
    
    self.headerImageView.layer.cornerRadius=6;
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
    NSDictionary *order=[body dicValueforKey:@"order"];
    NSDictionary *main_projects=[order dicValueforKey:@"main_projects"];
    
    [self.projectImageView sd_setImageWithURL:[NSURL URLWithString:[main_projects dicStringForKey:@"images"]]];
    self.projectNameLabel.text=[main_projects dicStringForKey:@"project_name"];
    self.projectServiceLabel.text=[NSString stringWithFormat:@"服务技师:%@",[order dicStringForKey:@"server_name"]];
    self.projectPriceLabel.text=[NSString stringWithFormat:@"¥%@",[order dicStringForKey:@"order_amount"]];
    self.projectFinishLabel.text=[order dicStringForKey:@"status_txt"];
    self.orderIdLabel.text=[NSString stringWithFormat:@"订单号:%@",[order dicStringForKey:@"order_sn"]];
    self.serviceTimeLabel.text=[NSString stringWithFormat:@"预约时间:%@",[order dicStringForKey:@"on_date"]];
    
    NSDictionary *from_user=[self.dataDic dicValueforKey:@"from_user"];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[from_user dicStringForKey:@"avatar"]]];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [UIView setCornerWithLeftTopCorner:12 rightTopCorner:0 bottomLeftCorner:12 bottomRightCorner:12 view:self.bgView frame:self.bgView.bounds];
}

@end
