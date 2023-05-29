//
//  MineMakeVoiceVC.h
//  FullCategory
//
//  Created by 浩杰 on 2023/3/10.
//

#import "CustomerBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineMakeVoiceVC : CustomerBaseViewController

@property (nonatomic,strong)NSDictionary *dataDic;

@end

@interface MakeVoiceViewModel : NSObject


@property (nonatomic , strong) UIColor *trailColor;


@property (nonatomic , strong) UIFont *trailFont;


@property (nonatomic , copy) NSString *title;


@property (nonatomic , copy) NSString *subtitle;

/**   是否必填提示  */
@property (nonatomic , copy) NSString *headerString;


@property (nonatomic , copy) NSString *placeholder;

/**   是否可编辑  */
@property (nonatomic , assign) BOOL editenable;

@end

NS_ASSUME_NONNULL_END
