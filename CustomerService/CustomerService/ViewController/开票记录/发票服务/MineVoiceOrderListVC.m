//
//  MineVoiceOrderListVC.m
//  FullCategory
//
//  Created by 浩杰 on 2023/3/10.
//

#import "MineVoiceOrderListVC.h"
#import "MineVoiceOrderItemCell.h"
#import "MineMakeVoiceVC.h"

@interface MineVoiceOrderListVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *noneView;

@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , assign) NSInteger pageNumber;

@end

@implementation MineVoiceOrderListVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDataAction];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发票服务";
    
    self.noneView.frame = CGRectMake(0, 0, ScreenWidth, 300);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MineVoiceOrderItemCell" bundle:nil] forCellReuseIdentifier:@"MineVoiceOrderItemCell"];
    self.tableView.mj_header=[MJRefreshHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self loadDataAction];
    }];
    self.tableView.mj_footer=[MJRefreshFooter footerWithRefreshingBlock:^{
        self.pageNumber++;
        [self loadDataAction];
    }];
    
}

- (void)loadDataAction
{
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc] init];
    [param setValue:@(self.pageNumber) forKey:@"page"];
    
    [[CustomerRequestHelper helper] GET:@"/call/user/invoice/orders" Parameters:[NSMutableDictionary dictionary] HUD:YES success:^(NSMutableDictionary * _Nullable responseDic) {
        
        NSDictionary *dataDic = [responseDic dicValueforKey:@"data"];
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
    MineVoiceOrderItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineVoiceOrderItemCell"];
    
    NSDictionary *dataDic=[self.dataArray objectAtIndex:indexPath.row];
    cell.dataDic=dataDic;
    
    cell.clickMakeVoiceBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            MineMakeVoiceVC *vc = [MineMakeVoiceVC new];
            vc.dataDic=dataDic;
            [self.navigationController pushViewController:vc animated:YES];
        });
    };
    
    return cell;
    
}


#pragma -mark cell点击方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
