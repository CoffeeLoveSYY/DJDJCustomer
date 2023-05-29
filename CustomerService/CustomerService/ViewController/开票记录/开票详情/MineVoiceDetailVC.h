//
//  MineVoiceDetailVC.h
//  FullCategory
//
//  Created by 浩杰 on 2023/3/10.
//

#import "CustomerBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineVoiceDetailVC : CustomerBaseViewController

@property (nonatomic , retain) NSDictionary *sourceDic;

@end

@interface VoiceDetailItemModel : NSObject


@property (nonatomic , strong) UIColor *trailColor;


@property (nonatomic , strong) UIFont *trailFont;


@property (nonatomic , copy) NSString *title;


@property (nonatomic , copy) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
