//
//  MineMakeVoiceVC.m
//  FullCategory
//
//  Created by 浩杰 on 2023/3/10.
//

#import "MineMakeVoiceVC.h"
#import "MineMakeInvoiceItemCell.h"

@interface MineMakeVoiceVC ()

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *qiyeButton;
@property (weak, nonatomic) IBOutlet UIButton *gerenButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewheightConstraint;

@property (nonatomic , assign) BOOL isSelectQiYeType;

@end

@implementation MineMakeVoiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请发票";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MineMakeInvoiceItemCell" bundle:nil] forCellReuseIdentifier:@"MineMakeInvoiceItemCell"];
    
    self.isSelectQiYeType = YES;
    
    [self initProductUI];
    [self createViewData];
}

- (void)createViewData{
    
    self.dataArray = [NSMutableArray array];
    
    MakeVoiceViewModel *model = [[MakeVoiceViewModel alloc] init];
    model.title = @"公司名称";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"131D34"];
    model.placeholder = @"请填写公司名称";
    model.editenable = YES;
    model.headerString = @"*";
    model.subtitle = @"";
    [self.dataArray addObject:model];
    
    if (self.isSelectQiYeType){
        
        model = [[MakeVoiceViewModel alloc] init];
        model.title = @"公司税号";
        model.trailFont = [UIFont systemFontOfSize:13];
        model.trailColor = [UIColor colorWithHexString:@"131D34"];
        model.placeholder = @"请填写公司税号";
        model.editenable = YES;
        model.headerString = @"*";
        model.subtitle = @"";
        [self.dataArray addObject:model];
        
        model = [[MakeVoiceViewModel alloc] init];
        model.title = @"开户行及账号";
        model.trailFont = [UIFont systemFontOfSize:13];
        model.trailColor = [UIColor colorWithHexString:@"131D34"];
        model.placeholder = @"选填";
        model.editenable = YES;
        model.headerString = @"";
        model.subtitle = @"";
        [self.dataArray addObject:model];
        
        model = [[MakeVoiceViewModel alloc] init];
        model.title = @"地址、电话";
        model.trailFont = [UIFont systemFontOfSize:13];
        model.trailColor = [UIColor colorWithHexString:@"131D34"];
        model.placeholder = @"选填";
        model.editenable = YES;
        model.headerString = @"";
        model.subtitle = @"";
        [self.dataArray addObject:model];
        
    }
    
    model = [[MakeVoiceViewModel alloc] init];
    model.title = @"订单号";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"131D34"];
    model.placeholder = @"";
    model.editenable = 0;
    model.headerString = @"";
    model.subtitle = [self.dataDic dicStringForKey:@"order_sn"];
    [self.dataArray addObject:model];
    
    model = [[MakeVoiceViewModel alloc] init];
    model.title = @"发票金额";
    model.trailFont = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    model.trailColor = [UIColor colorWithHexString:@"FF5D66"];
    model.placeholder = @"";
    model.editenable = 0;
    model.headerString = @"";
    model.subtitle = [NSString stringWithFormat:@"¥%@",[self.dataDic dicStringForKey:@"price"]];
    [self.dataArray addObject:model];
    
    model = [[MakeVoiceViewModel alloc] init];
    model.title = @"电子邮箱";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"131D34"];
    model.placeholder = @"请填写准确的电子邮箱";
    model.editenable = YES;
    model.headerString = @"*";
    model.subtitle = @"";
    [self.dataArray addObject:model];
    
    self.tableViewHeightConstraint.constant = self.dataArray.count * 50;
    self.bgViewheightConstraint.constant = 78 + 64 + self.tableViewHeightConstraint.constant;
    [self.tableView reloadData];
    
}

- (void)initProductUI{
    
    NSDictionary *projects=[self.dataDic dicValueforKey:@"projects"];
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:[projects dicStringForKey:@"images"]]];
    self.productNameLabel.text=[NSString stringWithFormat:@"%@x%@",[projects dicStringForKey:@"project_name"],[projects dicStringForKey:@"number"]];
    self.moneyLabel.text=[NSString stringWithFormat:@"¥%@",[projects dicStringForKey:@"price"]];
    self.timeLabel.text=[NSString stringWithFormat:@"预约时间:%@",[projects dicStringForKey:@"on_date"]];
    
    
}

- (void)setIsSelectQiYeType:(BOOL)isSelectQiYeType
{
    _isSelectQiYeType = isSelectQiYeType;
    if (isSelectQiYeType){
        [self.qiyeButton setImage:[UIImage imageNamed:@"geeenselected"] forState:UIControlStateNormal];
        [self.gerenButton setImage:[UIImage imageNamed:@"greenselect"] forState:UIControlStateNormal];
    }else{
        [self.qiyeButton setImage:[UIImage imageNamed:@"greenselect"] forState:UIControlStateNormal];
        [self.gerenButton setImage:[UIImage imageNamed:@"geeenselected"] forState:UIControlStateNormal];
    }
}

#pragma -mark TableView delegate and datasouse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineMakeInvoiceItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineMakeInvoiceItemCell"];
    MakeVoiceViewModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    if ([model isKindOfClass:[MakeVoiceViewModel class]]){
        cell.muLabel.text = model.headerString;
        cell.titleLabel.text = model.title;
        cell.textField.text = model.subtitle;
        cell.textField.enabled = model.editenable;
        cell.textField.placeholder = model.placeholder;
        cell.textField.font = model.trailFont;
        cell.textField.textColor = model.trailColor;
    }
    cell.endEdittingBlock = ^(NSString * _Nonnull string) {
        model.subtitle=string;
    };
    
    
    return cell;
    
}

#pragma -mark cell点击方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (IBAction)clickQiyeButtonAction:(id)sender {
    if (self.isSelectQiYeType == NO){
        self.isSelectQiYeType = YES;
        [self createViewData];
    }
}

- (IBAction)clickGerenButtonAction:(id)sender {
    if (self.isSelectQiYeType == YES){
        self.isSelectQiYeType = NO;
        [self createViewData];
    }
}

- (IBAction)commitButtonAction:(id)sender {
    
    [self.tableView endEditing:YES];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc] init];
    [param setValue:[self.dataDic dicStringForKey:@"id"] forKey:@"order_id"];
    [param setValue:[self.dataDic dicStringForKey:@"price"] forKey:@"money"];
    
    if (self.isSelectQiYeType==YES){
        [param setValue:@"1" forKey:@"rise_type"];
    }else{
        [param setValue:@"2" forKey:@"rise_type"];
    }
    
    for (MakeVoiceViewModel *model in self.dataArray) {
        if ([model.title isEqualToString:@"电子邮箱"]){
            if (model.subtitle.length==0){
                [self showMessage:@"请填写准确的电子邮箱"];
                return;
            }
            [param setValue:model.subtitle forKey:@"receive_email"];
            break;
        }
    }
    
    for (MakeVoiceViewModel *model in self.dataArray) {
        if ([model.title isEqualToString:@"公司税号"]){
            if (model.subtitle.length==0){
                [self showMessage:@"请填写公司税号"];
                return;
            }
            [param setValue:model.subtitle forKey:@"tax_number"];
            break;
        }
    }
    
    for (MakeVoiceViewModel *model in self.dataArray) {
        if ([model.title isEqualToString:@"地址、电话"]){
            [param setValue:model.subtitle forKey:@"address"];
            break;
        }
    }
    
    for (MakeVoiceViewModel *model in self.dataArray) {
        if ([model.title isEqualToString:@"开户行及账号"]){
            [param setValue:model.subtitle forKey:@"bank_info"];
            break;
        }
    }
    
    for (MakeVoiceViewModel *model in self.dataArray) {
        if ([model.title isEqualToString:@"公司名称"]){
            [param setValue:model.subtitle forKey:@"invoice_rise"];
            break;
        }
    }
    
    [[CustomerRequestHelper helper] POST:@"/call/user/invoice/make" Parameters:param HUD:YES success:^(NSMutableDictionary * _Nullable responseDic) {
            
        [self showMessage:@"申请成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(int failureCode, NSString * _Nullable message) {
        
        [self showMessage:message];
        
    }];
    
}

@end


@implementation MakeVoiceViewModel


@end
