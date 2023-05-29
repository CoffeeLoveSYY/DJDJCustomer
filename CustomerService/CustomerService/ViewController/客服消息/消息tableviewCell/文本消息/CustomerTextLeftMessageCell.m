//
//  CustomerTextLeftMessageCell.m
//  CustomerService
//
//  Created by 李杭玖 on 2023/5/25.
//

#import "CustomerTextLeftMessageCell.h"

@interface CustomerTextLeftMessageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;

@property (weak, nonatomic) IBOutlet UILabel *pjLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pjLabelTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pjLabelHeith;


@end

@implementation CustomerTextLeftMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.headerImageView.layer.cornerRadius=20;
    self.headerImageView.layer.masksToBounds=YES;
    
    self.pjLabel.layer.cornerRadius=13;
    self.pjLabel.layer.masksToBounds=YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic=dataDic;
    [self initData];
}

- (void)initData{
    
    NSInteger type=[[self.dataDic dicStringForKey:@"type"] integerValue];
    if (type==8){
        self.contentLabel.text=@"点击申请发票";
        self.contentLabel.textColor=[UIColor colorWithHexString:@"1FCC90"];
    }else{
        NSDictionary *body=[self.dataDic dicValueforKey:@"body"];
        self.contentLabel.text=[body dicStringForKey:@"content"];
        self.contentLabel.textColor=[UIColor blackColor];
    }
    
    if (type==5){
        self.pjLabelTop.constant=10;
        self.pjLabelHeith.constant=26;
        self.pjLabel.hidden=NO;
    }else{
        self.pjLabelTop.constant=0;
        self.pjLabelHeith.constant=0;
        self.pjLabel.hidden=YES;
    }
    
    NSDictionary *from_user=[self.dataDic dicValueforKey:@"from_user"];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[from_user dicStringForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"kefu"]];
    self.nameLabel.text=[from_user dicStringForKey:@"name"];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [UIView setCornerWithLeftTopCorner:0 rightTopCorner:10 bottomLeftCorner:10 bottomRightCorner:10 view:self.contentBgView frame:CGRectMake(0, 0, self.contentBgView.frame.size.width, self.contentBgView.frame.size.height)];
}



@end
