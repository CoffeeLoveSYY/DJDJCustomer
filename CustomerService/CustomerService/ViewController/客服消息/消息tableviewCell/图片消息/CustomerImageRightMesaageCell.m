//
//  CustomerImageRightMesaageCell.m
//  CustomerService
//
//  Created by 李杭玖 on 2023/5/25.
//

#import "CustomerImageRightMesaageCell.h"

@interface CustomerImageRightMesaageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImageViewWidth;

@end

@implementation CustomerImageRightMesaageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.headerImageView.layer.cornerRadius=20;
    self.headerImageView.layer.masksToBounds=YES;
    
    self.contentImageView.layer.cornerRadius=10;
    self.contentImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    self.contentImageView.layer.borderWidth=5;
    self.contentImageView.layer.masksToBounds=YES;
    
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
    
    NSDictionary *from_user=[self.dataDic dicValueforKey:@"from_user"];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[from_user dicStringForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"kefu"]];
    
    NSDictionary *body=[self.dataDic dicValueforKey:@"body"];
    NSString *url=[body dicStringForKey:@"url"];
    
    NSString *cacheKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:url]];
    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:cacheKey];
    
    if (cachedImage){
        
        self.contentImageView.image=cachedImage;
        
        CGFloat width=cachedImage.size.width;
        CGFloat height=cachedImage.size.height;
        if (width>240){
            width=240;
            height=cachedImage.size.height/cachedImage.size.width*240;
        }
        self.contentImageViewWidth.constant=width;
        self.contentImageViewHeight.constant=height;
        
    }else{
        
        __weak __typeof(self)weakSelf = self;
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            CGFloat width=cachedImage.size.width;
            CGFloat height=cachedImage.size.height;
            if (width>240){
                width=240;
                height=cachedImage.size.height/cachedImage.size.width*240;
            }
            weakSelf.contentImageViewWidth.constant=width;
            weakSelf.contentImageViewHeight.constant=height;
                    
        }];
        
    }
    
    [self layoutIfNeeded];
    
}

@end
