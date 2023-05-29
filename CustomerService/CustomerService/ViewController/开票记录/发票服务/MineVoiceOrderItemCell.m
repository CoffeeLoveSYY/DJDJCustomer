//
//  MineVoiceOrderItemCell.m
//  FullCategory
//
//  Created by 浩杰 on 2023/3/10.
//

#import "MineVoiceOrderItemCell.h"

@interface MineVoiceOrderItemCell ()
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
@implementation MineVoiceOrderItemCell

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
    
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:[self.dataDic dicStringForKey:@"merchant_avatar"]]];
    self.shopNameLabel.text=[self.dataDic dicStringForKey:@"merchant_name"];
    self.statusLabel.text=[self.dataDic dicStringForKey:@"status_txt"];
    
    NSDictionary *projects=[self.dataDic dicValueforKey:@"projects"];
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:[projects dicStringForKey:@"images"]]];
    self.productNameLabel.text=[NSString stringWithFormat:@"%@x%@",[projects dicStringForKey:@"project_name"],[projects dicStringForKey:@"number"]];
    self.moneyLabel.text=[NSString stringWithFormat:@"¥%@",[projects dicStringForKey:@"price"]];
    self.timeLabel.text=[NSString stringWithFormat:@"预约时间:%@",[projects dicStringForKey:@"yuyue_time"]];
    
}


- (IBAction)clickDetailAction:(id)sender {
    if (self.clickMakeVoiceBlock) {
        self.clickMakeVoiceBlock();
    }
}

@end
