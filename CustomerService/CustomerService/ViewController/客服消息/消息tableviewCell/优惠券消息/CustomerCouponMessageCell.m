//
//  CustomerCouponMessageCell.m
//  ProbjectForChongqing
//
//  Created by 李杭玖 on 2023/5/25.
//

#import "CustomerCouponMessageCell.h"

@interface CustomerCouponMessageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *bgSubView;

@end

@implementation CustomerCouponMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.headerImageView.layer.cornerRadius=20;
    self.headerImageView.layer.masksToBounds=YES;
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.bgSubView.bounds;
    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithHexString:@"DFFFF4"].CGColor,
                  (__bridge id)[UIColor colorWithHexString:@"F5FFFB"].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius=15;
    [self.bgSubView.layer insertSublayer:gl atIndex:0];
    
    self.selectBtn.layer.cornerRadius=13;
    self.selectBtn.layer.masksToBounds=YES;
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
    NSDictionary *coupon=[body dicValueforKey:@"coupon"];
    
    self.priceLabel.text=[NSString stringWithFormat:@"%.lf",[coupon dicFloatForKey:@"money"]];
    self.detailLabel.text=[NSString stringWithFormat:@"满%@可用",[coupon dicStringForKey:@"min_money"]];
    self.timeLabel.text=[NSString stringWithFormat:@"有效期至%@",[coupon dicStringForKey:@"updatetime"]];
    
    NSDictionary *from_user=[self.dataDic dicValueforKey:@"from_user"];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[from_user dicStringForKey:@"avatar"]]];
    self.nameLabel.text=[from_user dicStringForKey:@"name"];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [UIView setCornerWithLeftTopCorner:0 rightTopCorner:15 bottomLeftCorner:15 bottomRightCorner:15 view:self.bgView frame:self.bgView.bounds];
    
}

@end
