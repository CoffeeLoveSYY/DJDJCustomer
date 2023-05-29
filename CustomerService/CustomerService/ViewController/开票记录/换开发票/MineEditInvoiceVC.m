//
//  MineEditInvoiceVC.m
//  FullCategory
//
//  Created by 浩杰 on 2023/3/11.
//

#import "MineEditInvoiceVC.h"
#import "MineMakeVoiceVC.h"
#import "MineMakeInvoiceItemCell.h"

@interface MineEditInvoiceVC ()
@property (weak, nonatomic) IBOutlet UIButton *qiyeButton;
@property (weak, nonatomic) IBOutlet UIButton *gerenButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewheightConstraint;

/**   是否选择企业类型  */
@property (nonatomic , assign) BOOL isSelectQiYeType;
@end

@implementation MineEditInvoiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"填写发票信息";
    [self.tableView registerNib:[UINib nibWithNibName:@"MineMakeInvoiceItemCell" bundle:nil] forCellReuseIdentifier:@"MineMakeInvoiceItemCell"];
    self.isSelectQiYeType = YES;
    [self createViewData];
}

- (void)createViewData
{
    self.dataArray = [NSMutableArray array];
    MakeVoiceViewModel *model = [[MakeVoiceViewModel alloc] init];
    model.title = @"公司名称";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"131D34"];
    model.placeholder = @"请填写公司名称";
    model.editenable = YES;
    model.headerString = @"*";
    model.subtitle = @"重庆东郊到家";
    [self.dataArray addObject:model];
    
    if (self.isSelectQiYeType){
        model = [[MakeVoiceViewModel alloc] init];
        model.title = @"公司税号";
        model.trailFont = [UIFont systemFontOfSize:13];
        model.trailColor = [UIColor colorWithHexString:@"131D34"];
        model.placeholder = @"请填写公司税号";
        model.editenable = YES;
        model.headerString = @"*";
        model.subtitle = @"997685857868MU";
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
    model.subtitle = @"2023030312325565556565656565";
    [self.dataArray addObject:model];
    
    model = [[MakeVoiceViewModel alloc] init];
    model.title = @"发票金额";
    model.trailFont = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    model.trailColor = [UIColor colorWithHexString:@"FF5D66"];
    model.placeholder = @"";
    model.editenable = 0;
    model.headerString = @"";
    model.subtitle = @"¥168.00";
    [self.dataArray addObject:model];
    
    model = [[MakeVoiceViewModel alloc] init];
    model.title = @"电子邮箱";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"131D34"];
    model.placeholder = @"请填写准确的电子邮箱";
    model.editenable = YES;
    model.headerString = @"*";
    model.subtitle = @"zhong@126.com";
    [self.dataArray addObject:model];
    
    self.tableViewHeightConstraint.constant = self.dataArray.count * 50;
    self.bgViewheightConstraint.constant = 64 + self.tableViewHeightConstraint.constant;
    [self.tableView reloadData];
    
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
    
}
@end
