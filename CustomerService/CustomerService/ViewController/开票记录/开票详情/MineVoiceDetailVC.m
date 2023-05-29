//
//  MineVoiceDetailVC.m
//  FullCategory
//
//  Created by 浩杰 on 2023/3/10.
//

#import "MineVoiceDetailVC.h"
#import "MineVoiceDetailItemCell.h"
#import "MineEditInvoiceVC.h"

@interface MineVoiceDetailVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@property (nonatomic , strong) NSMutableArray *dataArray;

@end

@implementation MineVoiceDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"F2F4F7"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MineVoiceDetailItemCell" bundle:nil] forCellReuseIdentifier:@"MineVoiceDetailItemCell"];
    [self createViewData];
    
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.scrollView.mj_header endRefreshing];
        });
    }];
}

- (void)createViewData
{
    self.dataArray = [NSMutableArray array];
    VoiceDetailItemModel *model = [[VoiceDetailItemModel alloc] init];
    model.title = @"抬头类型";
    model.subtitle = @"企业单位";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"#131D34"];
    [self.dataArray addObject:model];
    
    model = [[VoiceDetailItemModel alloc] init];
    model.title = @"公司名称";
    model.subtitle = @"重庆东郊到家";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"#131D34"];
    [self.dataArray addObject:model];
    
    model = [[VoiceDetailItemModel alloc] init];
    model.title = @"公司税号";
    model.subtitle = @"997685857868MU";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"#131D34"];
    [self.dataArray addObject:model];
    
    model = [[VoiceDetailItemModel alloc] init];
    model.title = @"开户行及账号";
    model.subtitle = @"—";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"#131D34"];
    [self.dataArray addObject:model];
    
    model = [[VoiceDetailItemModel alloc] init];
    model.title = @"地址、电话";
    model.subtitle = @"—";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"#131D34"];
    [self.dataArray addObject:model];
    
    model = [[VoiceDetailItemModel alloc] init];
    model.title = @"订单号";
    model.subtitle = @"2023030312325565556565656565";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"#131D34"];
    [self.dataArray addObject:model];
    
    model = [[VoiceDetailItemModel alloc] init];
    model.title = @"发票金额";
    model.subtitle = @"¥168.00";
    model.trailFont = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    model.trailColor = [UIColor colorWithHexString:@"#FF5D66"];
    [self.dataArray addObject:model];
    
    model = [[VoiceDetailItemModel alloc] init];
    model.title = @"电子邮箱";
    model.subtitle = @"zhong@126.com";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"#131D34"];
    [self.dataArray addObject:model];
    
    model = [[VoiceDetailItemModel alloc] init];
    model.title = @"申请时间";
    model.subtitle = @"2023-02-01 10:00:00";
    model.trailFont = [UIFont systemFontOfSize:13];
    model.trailColor = [UIColor colorWithHexString:@"#131D34"];
    [self.dataArray addObject:model];
    
    self.tableViewHeightConstraint.constant = 40 *self.dataArray.count + 20;
    [self.tableView reloadData];
    
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
    return 40.f;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0001f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineVoiceDetailItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineVoiceDetailItemCell"];
    VoiceDetailItemModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[VoiceDetailItemModel class]]){
        cell.titleLabel.text = model.title;
        cell.subtitleLabel.text = model.subtitle;
        cell.subtitleLabel.font = model.trailFont;
        cell.subtitleLabel.textColor = model.trailColor;
    }
    
    return cell;
    
}

#pragma -mark cell点击方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (IBAction)clickBackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)editButtonAction:(id)sender {
    MineEditInvoiceVC *vc = [MineEditInvoiceVC new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end


@implementation VoiceDetailItemModel

@end
