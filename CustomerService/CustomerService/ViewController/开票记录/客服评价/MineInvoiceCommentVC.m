//
//  MineInvoiceCommentVC.m
//  FullCategory
//
//  Created by 浩杰 on 2023/3/11.
//

#import "MineInvoiceCommentVC.h"
#import "LPLevelView.h"

@interface MineInvoiceCommentVC ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *yijiejueButton;
@property (weak, nonatomic) IBOutlet UIButton *weijiejueButton;
@property (weak, nonatomic) IBOutlet LPLevelView *scoreView;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic , copy) void(^confirmBlock)(void);

/**   是否已解决，默认已解决  */
@property (nonatomic , assign) BOOL isResolve;

@end

@implementation MineInvoiceCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.textView.delegate = self;
    
    self.scoreView.canScore = YES;
    self.scoreView.levelInt = YES;
    
    self.scoreView.iconSize = CGSizeMake(32, 32);
    self.scoreView.backgroundColor = [UIColor clearColor];
    self.scoreView.iconEmpty = [UIImage imageNamed:@"m_fp_comment_e"];
    self.scoreView.iconHalf = [UIImage imageNamed:@"m_fp_comment_f"];
    self.scoreView.iconFull = [UIImage imageNamed:@"m_fp_comment_f"];
    self.scoreView.level = 5;
    self.isResolve = YES;
    self.noticeLabel.text = @"非常满意";
    self.yijiejueButton.layer.borderWidth = 1;
    self.weijiejueButton.layer.borderWidth = 1;
/*
 1、评价等级：5星-非常满意、4星-满意、3星-一般、2星-不满意、1星-非常不满意；
 2、星级默认5星-非常满意；您的问题，默认已解决；
 3、评价内容为非必填；您的问题为必填不能取消；
 4、点击提交评价，toast提示“感谢您的评价”；
 */
    self.scoreView.scoreBlock = ^(float level) {
        if (level == 1.f){
            self.noticeLabel.text = @"非常不满意";
        }else if (level == 2.f){
            self.noticeLabel.text = @"不满意";
        }else if (level == 3.f){
            self.noticeLabel.text = @"一般";
        }else if (level == 4.f){
            self.noticeLabel.text = @"满意";
        }else if (level == 5.f){
            self.noticeLabel.text = @"非常满意";
        }
    };
    // Do any additional setup after loading the view from its nib.
}

- (void)setIsResolve:(BOOL)isResolve
{
    _isResolve = isResolve;
    if (isResolve){
        [self.yijiejueButton setTitleColor:[UIColor colorWithHexString:@"#1FCC90"] forState:UIControlStateNormal];
        [self.yijiejueButton setBackgroundColor:[UIColor colorWithHexString:@"#E5FFF6"]];
        self.yijiejueButton.layer.borderColor = [UIColor colorWithHexString:@"#1FCC90"].CGColor;
        [self.weijiejueButton setTitleColor:[UIColor colorWithHexString:@"#848B9E"] forState:UIControlStateNormal];
        [self.weijiejueButton setBackgroundColor:[UIColor colorWithHexString:@"#F2F4F7"]];
        self.weijiejueButton.layer.borderColor = [UIColor colorWithHexString:@"#DCDFE5"].CGColor;
    }else{
        [self.weijiejueButton setTitleColor:[UIColor colorWithHexString:@"#1FCC90"] forState:UIControlStateNormal];
        [self.weijiejueButton setBackgroundColor:[UIColor colorWithHexString:@"#E5FFF6"]];
        self.weijiejueButton.layer.borderColor = [UIColor colorWithHexString:@"#1FCC90"].CGColor;
        [self.yijiejueButton setTitleColor:[UIColor colorWithHexString:@"#848B9E"] forState:UIControlStateNormal];
        [self.yijiejueButton setBackgroundColor:[UIColor colorWithHexString:@"#F2F4F7"]];
        self.yijiejueButton.layer.borderColor = [UIColor colorWithHexString:@"#DCDFE5"].CGColor;
    }
}

- (void)presentFromViewController:(UIViewController *)viewController completionBlock:(void(^)(void))completionBlock;
{
    self.confirmBlock = completionBlock;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
        
        
        
        if (viewController.tabBarController.presentedViewController) {
            [viewController.presentedViewController presentViewController:self animated:YES completion:nil];
        }else{
            [viewController presentViewController:self animated:YES completion:nil];
        }
    });
}
- (void)textViewDidChange:(UITextView *)textView;
{
    self.placeholderLabel.hidden = textView.text.length > 0;
    self.countLabel.text = [NSString stringWithFormat:@"%zd/200",textView.text.length];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    int limit = 200;
    return !([textView.text length]>limit && [text length] > range.length);
}


//未解决
- (IBAction)clickWeiJieJueButtonAction:(id)sender {
    if (self.isResolve == YES){
        self.isResolve = NO;
    }
}

//已解决
- (IBAction)clickYiJieJueButtonAction:(id)sender {
    if (self.isResolve == NO){
        self.isResolve = YES;
    }
}

- (IBAction)closeButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)commitButtonAction:(id)sender {
    
    if (self.textView.text.length==0){
        [self showMessage:@"请输入您对本次服务的评价内容"];
        return;
    }
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc] init];
    [param setValue:self.admin_id forKey:@"admin_id"];
    [param setValue:self.chat_id forKey:@"chat_id"];
    [param setValue:@"1" forKey:@"user_type"];
    [param setValue:@(self.scoreView.level) forKey:@"level"];
    [param setValue:self.textView.text forKey:@"content"];
    [param setValue:@(self.isResolve) forKey:@"result"];
    
    [[CustomerRequestHelper helper] POST:@"/call/user/chat/evaluation" Parameters:param HUD:YES success:^(NSMutableDictionary * _Nullable responseDic) {
            
        [self showMessage:@"感谢您的评价"];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(int failureCode, NSString * _Nullable message) {
        
        [self showMessage:message];
        
    }];
    
}

@end
