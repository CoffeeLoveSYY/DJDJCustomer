//
//  MineVoiceRecordItemCell.m
//  FullCategory
//
//  Created by 浩杰 on 2023/3/10.
//

#import "MineVoiceRecordItemCell.h"

@interface MineVoiceRecordItemCell ()
@property (weak, nonatomic) IBOutlet UILabel *applyDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *projectImageView;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuyueDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation MineVoiceRecordItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.detLabel.layer.borderColor = [UIColor colorWithHexString:@"#848B9E"].CGColor;
    self.detLabel.layer.borderWidth = 1;
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic=dataDic;
    [self initUIData];
}

- (void)initUIData{
    
    NSDictionary *invoice=[self.dataDic dicValueforKey:@"invoice"];
    self.applyDateLabel.text=[NSString stringWithFormat:@"申请时间:%@",[invoice dicStringForKey:@"createtime"]];
    
    self.statusLabel.text=[self.dataDic dicStringForKey:@"status_text"];
    
    NSDictionary *projects=[self.dataDic dicValueforKey:@"projects"];
    [self.projectImageView sd_setImageWithURL:[NSURL URLWithString:[projects dicStringForKey:@"images"]]];
    self.projectNameLabel.text=[NSString stringWithFormat:@"%@ x%@",[projects dicStringForKey:@"project_name"],[projects dicStringForKey:@"number"]];
    
    self.yuyueDateLabel.text=[NSString stringWithFormat:@"预约时间:%@",[self.dataDic dicStringForKey:@"on_date"]];
    self.priceLabel.text=[NSString stringWithFormat:@"¥%@",[self.dataDic dicStringForKey:@"order_fee"]];
    
}


@end
