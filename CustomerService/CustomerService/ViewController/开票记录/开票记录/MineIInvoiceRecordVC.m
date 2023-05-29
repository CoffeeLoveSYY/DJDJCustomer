//
//  MineIInvoiceRecordVC.m
//  FullCategory
//
//  Created by 浩杰 on 2023/3/10.
//

#import "MineIInvoiceRecordVC.h"
#import "MineVoiceRecordItemCell.h"
#import "MineVoiceDetailVC.h"
#import "MineVoiceOrderListVC.h"
#import "MineInvoiceSelectOrderVC.h"
#import "MineInvoiceCommentVC.h"

@interface MineIInvoiceRecordVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *noneView;

@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , assign) NSInteger pageNumber;

@end

@implementation MineIInvoiceRecordVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDataAction];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"开票记录";
    
    self.noneView.frame = CGRectMake(0, 0, ScreenWidth, 300);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MineVoiceRecordItemCell" bundle:nil] forCellReuseIdentifier:@"MineVoiceRecordItemCell"];
    self.tableView.mj_header=[MJRefreshHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self loadDataAction];
    }];
    self.tableView.mj_footer=[MJRefreshFooter footerWithRefreshingBlock:^{
        self.pageNumber++;
        [self loadDataAction];
    }];
    
}

- (void)clickOrderListAction{
    MineVoiceOrderListVC *vc = [MineVoiceOrderListVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadDataAction{
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc] init];
    [param setValue:@(self.pageNumber) forKey:@"page"];
    
    [[CustomerRequestHelper helper] GET:@"/call/user/invoice/orders" Parameters:[NSMutableDictionary dictionary] HUD:YES success:^(NSMutableDictionary * _Nullable responseDic) {
        
        NSDictionary *dataDic = [responseDic dicValueforKey:@"data"];
        if (dataDic.count==0){
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.hidden=YES;
            [self.tableView reloadData];
            return;
        }
        
        NSInteger total = [[dataDic dicStringForKey:@"total"] integerValue];
        NSArray *cacheArray = [dataDic dicArrayForKey:@"data"];
        
        if (self.pageNumber <= 1) {
            self.dataArray = [NSMutableArray arrayWithArray:cacheArray];
        }else{
            [self.dataArray addObjectsFromArray:cacheArray];
        }
        
        if (total <= self.dataArray.count || self.dataArray.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
            
    } failure:^(int failureCode, NSString * _Nullable message) {
        [self.tableView.mj_header endRefreshing];
    }];
    
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
    return UITableViewAutomaticDimension;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.dataArray.count == 0){
        return 300.f;
    }
    return 8.0001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.dataArray.count == 0){
        return self.noneView;
    }
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineVoiceRecordItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineVoiceRecordItemCell"];
    
    NSDictionary *dataDic=[self.dataArray objectAtIndex:indexPath.row];
    cell.dataDic=dataDic;
    
    return cell;
    
}

#pragma -mark cell点击方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    if (indexPath.row == 0){
//        MineInvoiceSelectOrderVC *vc = [MineInvoiceSelectOrderVC new];
//        [vc presentFromViewController:self selectOrderBlock:^(NSDictionary * _Nonnull orderDic) {
//
//        }];
//        return;
//    }
    
//    if (indexPath.row == 1){
//        MineInvoiceCommentVC *vc = [MineInvoiceCommentVC new];
//        [vc presentFromViewController:self completionBlock:^{
//
//        }];
//        return;
//    }
    
    
    MineVoiceDetailVC *vc = [MineVoiceDetailVC new];
    vc.sourceDic = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
