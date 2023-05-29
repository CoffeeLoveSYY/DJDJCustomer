//
//  MineInvoiceSelectOrderVC.m
//  FullCategory
//
//  Created by 浩杰 on 2023/3/11.
//

#import "MineInvoiceSelectOrderVC.h"
#import "InvoiceSelectOrderCell.h"

@interface MineInvoiceSelectOrderVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , copy) void(^confirmBlock)(NSDictionary *dic);
@property (nonatomic , assign) NSInteger pageNumber;
@property (nonatomic , assign) int dataType;

@end

@implementation MineInvoiceSelectOrderVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDataAction];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"InvoiceSelectOrderCell" bundle:nil] forCellReuseIdentifier:@"InvoiceSelectOrderCell"];
    self.tableView.mj_header=[MJRefreshHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self loadDataAction];
    }];
    self.tableView.mj_footer=[MJRefreshFooter footerWithRefreshingBlock:^{
        self.pageNumber++;
        [self loadDataAction];
    }];
    
    
}


- (void)presentFromViewController:(UIViewController *)viewController selectOrderBlock:(void(^)(NSDictionary *orderDic))orderBlock{
    
    self.confirmBlock = orderBlock;
    
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

- (void)loadDataAction
{
//    NSDictionary *userParam =@{@"token" : YU_SafeString(userModel.token),
//                               @"page"      : @(self.pageNumber),
//                               @"status"    : @(self.dataType)};
//    
//    if (self.dataArray.count == 0){
//        [self showHUD];
//    }
//    [NetworkTools requestWithType:HttpRequestTypeGet withUrlString:COMMON_API(@"/order/order_list") withParaments:userParam withCompletionBlock:^(BOOL success, id  _Nonnull data) {
//        //NSLog(@"home nearby_business = %@",data);
//        NSInteger total = 20;
//        if (success) {
//            
//            NSDictionary *sourceDic = [data safeObjectForKey:@"data"];
//            //判断数据格式
//            if ([sourceDic isKindOfClass:[NSDictionary class]]) {
//                NSArray *cacheArray = [sourceDic safeArrayForKey:@"list"];
//                total = [sourceDic safeIntegerForKey:@"total"];
//                if ([cacheArray isKindOfClass:[NSArray class]]) {
//                    
//                    if (self.pageNumber <= 1) {
//                        self.dataArray = [NSMutableArray arrayWithArray:cacheArray];
//                    }else{
//                        [self.dataArray addObjectsFromArray:cacheArray];
//                    }
//                }
//            }
//        }else{
//            SHOW_MESSAGE_MIDDLE(data);
//        }
//        
//        if (total <= self.dataArray.count || self.dataArray.count == 0) {
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        }else{
//            [self.tableView.mj_footer endRefreshing];
//        }
//        [self.tableView.mj_header endRefreshing];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//            [self dismiss];
//        });
//    }];
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
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InvoiceSelectOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvoiceSelectOrderCell"];
    
    NSDictionary *dataDic=[self.dataArray objectAtIndex:indexPath.row];
    cell.orderNumberLabel.text=[NSString stringWithFormat:@"订单号:%@",[dataDic dicStringForKey:@"order_sn"]];
    cell.statusLabel.text=[dataDic dicStringForKey:@"status_text"];
    
    NSArray *iArray = [self toArrayOrNSDictionary:[dataDic dicStringForKey:@"items"]];
    if ([iArray isKindOfClass:[NSArray class]] == YES && iArray.count > 0) {
        NSDictionary *dic = [iArray firstObject];
        [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:[dic dicStringForKey:@"item_image"]]];
        cell.productNameLabel.text = [NSString stringWithFormat:@"%@ x%@",[dic dicStringForKey:@"item_name"],[dic dicStringForKey:@"xmnuber"]];
    }
    
    cell.moneyLabel.text=[NSString stringWithFormat:@"¥%@",[dataDic dicStringForKey:@"order_total"]];
    cell.timeLabel.text=[NSString stringWithFormat:@"预约时间:%@",[dataDic dicStringForKey:@"createtime"]];
    
    cell.clickSendBlock = ^{
        if (self.confirmBlock){
            self.confirmBlock([self.dataArray objectAtIndex:indexPath.row]);
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    };
    
    return cell;
    
}

#pragma -mark cell点击方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//关闭
- (IBAction)closeButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:^{
       
    }];
}

- (id)toArrayOrNSDictionary:(NSString *)jsonData{

    if (jsonData != nil) {

        NSData* data = [jsonData dataUsingEncoding:NSUTF8StringEncoding];

        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        if (jsonObject != nil){

            return jsonObject;

        }else{

            // 解析错误

            return nil;

        }

    }

    return nil;

}

@end
