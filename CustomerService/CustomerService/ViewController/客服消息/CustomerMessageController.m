//
//  CustomerMessageController.m
//  FullCategory
//
//  Created by 李杭玖 on 2023/3/9.
//

#import "CustomerMessageController.h"

#import <SocketRocket/SRWebSocket.h>
#import <TZImagePickerController.h>
#import <TZVideoPlayerController.h>

#import "CustomerTipMessageCell.h"
#import "CustomerTextLeftMessageCell.h"
#import "CustomerTextRightMessageCell.h"
#import "CustomerImageLeftMessageCell.h"
#import "CustomerImageRightMesaageCell.h"
#import "CustomerOrderMessageCell.h"
#import "CustomerCouponMessageCell.h"

#import "MineInvoiceSelectOrderVC.h"
#import "MineVoiceOrderListVC.h"
#import "MineInvoiceCommentVC.h"

@interface CustomerMessageController ()

<UITableViewDelegate,
UITableViewDataSource,
SRWebSocketDelegate,
UITextViewDelegate,
UIPickerViewDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuViewHeight;

@property (nonatomic,strong)SRWebSocket *webSocket;

@property (nonatomic,strong)NSDictionary *customerDic;//客服信息
@property (nonatomic,strong)NSString *chat_id;//会话id
@property (nonatomic,strong)NSMutableArray *messageArray;//消息列表


@end

@implementation CustomerMessageController

- (NSMutableArray *)messageArray{
    if (_messageArray){
        _messageArray=[[NSMutableArray alloc] init];
    }
    return _messageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self initUIStyle];
    [self initFreeCustomer];
    [self initTableView];
    
}

- (void)initUIStyle{
    
    self.title=@"在线客服";
    self.view.backgroundColor=[UIColor colorWithHexString:@"F2F4F7"];
    
    self.endBtn.layer.cornerRadius=13;
    self.endBtn.layer.borderWidth=1;
    self.endBtn.layer.borderColor=[UIColor colorWithHexString:@"CED0D9"].CGColor;
    self.endBtn.layer.masksToBounds=YES;
    
    self.textView.layer.cornerRadius=5;
    self.textView.layer.masksToBounds=YES;
    self.textView.translatesAutoresizingMaskIntoConstraints=NO;
    self.textView.textContainerInset=UIEdgeInsetsMake(13, 13, 13, 13);
    self.textView.textContainer.lineBreakMode=NSLineBreakByWordWrapping;
    self.textView.textContainer.lineFragmentPadding = 0;
    self.textView.font=[UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.textView.delegate=self;
}

- (void)initFreeCustomer{
    
    [[CustomerRequestHelper helper] GET:@"/call/user/chat/idle_admin" Parameters:[NSMutableDictionary dictionary] HUD:YES success:^(NSMutableDictionary * _Nullable responseDic) {
            
        self.customerDic=[responseDic dicValueforKey:@"data"];
        if (self.customerDic.count==0){
            [self showMessage:@"当前暂无空闲客服"];
        }else{
            [self initSocketRocket];
            [self initHistoryData];
        }
        
    } failure:^(int failureCode, NSString * _Nullable message) {
        
    }];
    
}


- (void)initSocketRocket{
    
    NSURL *url=[NSURL URLWithString:@"ws://sujki.dongjiaoapp.com:2348"];
    self.webSocket = [[SRWebSocket alloc] initWithURL:url];
    self.webSocket.delegate = self;
    
    dispatch_queue_t referQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_async(referQueue, ^{
        [self.webSocket open];
    });
    
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    
    NSDictionary *tokenDic=@{@"user_id":[CustomerConfig sharedInstance].userId,@"type":@"1",@"admin_id":[self.customerDic dicStringForKey:@"id"]};
    NSDictionary *dataDic=@{@"channel":@"user",@"type":@"0",
                            @"data":tokenDic
    };
    
    NSError *error=nil;
    NSData *data=[self convertToJsonData:dataDic];
    
    [self.webSocket sendData:data error:&error];
    
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"WebSocket did receive message: %@", message);
    
    if ([message isKindOfClass:[NSString class]]){
        [self addMessageToArray:message];
    }
    
}

- (void)addMessageToArray:(id)message{
    
    NSData *jsonData=[message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    NSInteger type=[[dictionary dicStringForKey:@"type"] integerValue];
    
    if (type==1){
        NSDictionary *messageDic=[dictionary dicValueforKey:@"data"];
        [self.messageArray addObject:messageDic];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            NSInteger lastSectionIndex=[self.tableView numberOfSections] - 1;
            NSInteger lastRowIndex=[self.tableView numberOfRowsInSection:lastSectionIndex] - 1;
            if (lastSectionIndex>=0 && lastRowIndex>=0) {
                NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
                [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
        });
        
    }
    
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"WebSocket did fail with error: %@", error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"WebSocket did close with code: %ld reason: %@", (long)code, reason);
}

- (void)initTableView{
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor colorWithHexString:@"F2F4F7"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomerTipMessageCell" bundle:nil] forCellReuseIdentifier:@"CustomerTipMessageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomerTextLeftMessageCell" bundle:nil] forCellReuseIdentifier:@"CustomerTextLeftMessageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomerTextRightMessageCell" bundle:nil] forCellReuseIdentifier:@"CustomerTextRightMessageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomerImageLeftMessageCell" bundle:nil] forCellReuseIdentifier:@"CustomerImageLeftMessageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomerImageRightMesaageCell" bundle:nil] forCellReuseIdentifier:@"CustomerImageRightMesaageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomerOrderMessageCell" bundle:nil] forCellReuseIdentifier:@"CustomerOrderMessageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomerCouponMessageCell" bundle:nil] forCellReuseIdentifier:@"CustomerCouponMessageCell"];
    
        
}



- (void)initHistoryData{
    
    self.messageArray=[[NSMutableArray alloc] init];
    
    [[CustomerRequestHelper helper] GET:@"/call/user/chat/history" Parameters:[NSMutableDictionary dictionary] HUD:YES success:^(NSMutableDictionary * _Nullable responseDic) {
            
        NSDictionary *dataDic=[responseDic dicValueforKey:@"data"];
        NSArray *dataArray=[dataDic dicArrayForKey:@"data"];
        if (dataArray.count!=0){
            //倒叙数组
            [self.messageArray addObjectsFromArray:dataArray];
            self.messageArray = (NSMutableArray *)[[self.messageArray reverseObjectEnumerator] allObjects];
            //获取chat_id
            self.chat_id=[[self.messageArray firstObject] dicStringForKey:@"chat_id"];
        }
        
        
        [self.tableView reloadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            NSInteger lastSectionIndex=[self.tableView numberOfSections] - 1;
            NSInteger lastRowIndex=[self.tableView numberOfRowsInSection:lastSectionIndex] - 1;
            if (lastSectionIndex>=0 && lastRowIndex>=0) {
                NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
                [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
        });
        
    } failure:^(int failureCode, NSString * _Nullable message) {
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dataDic=[self.messageArray objectAtIndex:indexPath.row];
    NSInteger type=[[dataDic dicStringForKey:@"type"] integerValue];
    NSString *from_id=[dataDic dicStringForKey:@"from_id"];
    NSString *from_id_type=[dataDic dicStringForKey:@"from_id_type"];
    
    if (type==0 || type==5 || type==6 || type==7 || type==8){
        if ([from_id isEqualToString:[CustomerConfig sharedInstance].userId] && [from_id_type isEqualToString:@"1"]){
            CustomerTextRightMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CustomerTextRightMessageCell" forIndexPath:indexPath];
            
            cell.dataDic=dataDic;
            
            return cell;
        }else{
            CustomerTextLeftMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CustomerTextLeftMessageCell" forIndexPath:indexPath];
            
            cell.dataDic=dataDic;
            
            return cell;
        }
    }else if (type==1){
        if ([from_id isEqualToString:[CustomerConfig sharedInstance].userId] && [from_id_type isEqualToString:@"1"]){
            CustomerImageRightMesaageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CustomerImageRightMesaageCell" forIndexPath:indexPath];
            
            cell.dataDic=dataDic;
            
            return cell;
        }else{
            CustomerImageLeftMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CustomerImageLeftMessageCell" forIndexPath:indexPath];
            
            cell.dataDic=dataDic;
            
            return cell;
        }
    }else if (type==2){
        CustomerOrderMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CustomerOrderMessageCell" forIndexPath:indexPath];
        
        cell.dataDic=dataDic;
        
        return cell;
    }else if (type==3){
        CustomerTipMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CustomerTipMessageCell" forIndexPath:indexPath];

        cell.dataDic=dataDic;

        return cell;
    }else if (type==4){
        CustomerCouponMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CustomerCouponMessageCell" forIndexPath:indexPath];
        
        cell.dataDic=dataDic;
        
        return cell;
    }else{

        return [UITableViewCell new];

    }


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dataDic=[self.messageArray objectAtIndex:indexPath.row];
    NSInteger type=[[dataDic dicStringForKey:@"type"] integerValue];
    
    //发票
    if (type==8){
        MineVoiceOrderListVC *vc=[[MineVoiceOrderListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    //评价
    if (type==5){
        MineInvoiceCommentVC *vc=[[MineInvoiceCommentVC alloc] init];
        vc.admin_id=[self.customerDic dicStringForKey:@"id"];
        vc.chat_id=self.chat_id;
        [vc presentFromViewController:self completionBlock:^{
            
        }];
    }
    
}

- (IBAction)ClickMore:(id)sender {
    self.moreBtn.selected=!self.moreBtn.selected;
    if (self.moreBtn.selected==NO){
        self.menuView.hidden=YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.menuViewHeight.constant=0;
            [self.view layoutIfNeeded];
        }];
    }else{
        self.menuView.hidden=NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.menuViewHeight.constant=126;
            [self.view layoutIfNeeded];
        }];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        NSInteger lastSectionIndex=[self.tableView numberOfSections] - 1;
        NSInteger lastRowIndex=[self.tableView numberOfRowsInSection:lastSectionIndex] - 1;
        if (lastSectionIndex>=0 && lastRowIndex>=0) {
            NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
            [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    });
    
}

- (IBAction)ClickXC:(id)sender {
    
    TZImagePickerController *picker=[[TZImagePickerController alloc] init];
    picker.autoSelectCurrentWhenDone=NO;
    picker.alwaysEnableDoneBtn=NO;
    picker.allowPickingVideo=NO;
    picker.allowTakePicture=NO;
    picker.allowCrop=NO;
    picker.delegate=self;
    [self.navigationController pushViewController:picker animated:YES];
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    for (UIImage *image in photos) {
        [self UploadPhoto:image];
    }
    
}

- (IBAction)ClickPZ:(id)sender {
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:pickerController animated:YES completion:nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (image!=nil){
        [self UploadPhoto:image];
    }
    
}

- (void)UploadPhoto:(UIImage *)image{
    
    [[CustomerRequestHelper helper] UploadPhoto:@"/common/upload_new" Parameters:image HUD:YES success:^(NSMutableDictionary * _Nullable responseDic) {
        
        NSDictionary *dataDic=[responseDic dicValueforKey:@"data"];
        NSString *url=[dataDic dicStringForKey:@"url"];
        
        NSDictionary *tokenDic=@{@"type":@"1",@"url":url,@"user_id":[self.customerDic dicStringForKey:@"id"],@"user_type":@"0"};
        NSDictionary *sendDataDic=@{@"channel":@"user",@"type":@"1",
                                @"data":tokenDic
        };
        NSError *error=nil;
        NSData *data=[self convertToJsonData:sendDataDic];
        [self.webSocket sendData:data error:&error];
        
    } failure:^(int failureCode, NSString * _Nullable message) {
        
    }];
    
}

#pragma mark --点击订单
- (IBAction)ClickDD:(id)sender {
    __weak typeof(self) weakSelf = self;
    MineInvoiceSelectOrderVC *vc=[[MineInvoiceSelectOrderVC alloc] init];
    [vc presentFromViewController:self selectOrderBlock:^(NSDictionary * _Nonnull orderDic) {
        [weakSelf sendOrderMessage:orderDic];
    }];
}

#pragma mark --发送订单消息
- (void)sendOrderMessage:(NSDictionary *)orderDic{
    NSDictionary *messageDic=@{@"type":@"2",@"order_id":@"20",@"user_id":[self.customerDic dicStringForKey:@"id"],@"user_type":@"0"};
    NSDictionary *sendDic=@{@"channel":@"user",@"type":@"1",
                            @"data":messageDic
    };
    NSError *error=nil;
    NSData *data=[self convertToJsonData:sendDic];
    BOOL flag=[self.webSocket sendData:data error:&error];
    if (!flag){
        [self showMessage:@"发送失败"];
    }
}

- (IBAction)ClickJSHH:(id)sender {
    
}

- (IBAction)ClickPJ:(id)sender {
    
}

- (void)textViewDidChange:(UITextView *)textView {
    CGSize size = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)];
    CGFloat newHeight = fmin(size.height, 13 * 6 + 26); // 最大高度限制为 6 行高度
    if (newHeight<44){
        newHeight=44;
    }
    self.textViewHeight.constant = newHeight;
    [self.textView scrollRectToVisible:CGRectMake(0, 0, size.width, size.height) animated:NO];
    [self.view layoutIfNeeded]; // 触发布局更新
}

#pragma mark --发送文本消息
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){
        
        [self sendTextMessage:textView.text];
        
        return NO;
    }
    return YES;
}

- (void)sendTextMessage:(NSString *)string{
    
    NSDictionary *tokenDic=@{@"type":@"0",@"content":string,@"user_id":[self.customerDic dicStringForKey:@"id"],@"user_type":@"0"};
    NSDictionary *dataDic=@{@"channel":@"user",@"type":@"1",
                            @"data":tokenDic
    };
    NSError *error=nil;
    NSData *data=[self convertToJsonData:dataDic];
    BOOL flag=[self.webSocket sendData:data error:&error];
    if (flag==YES){
        self.textView.text=@"";
        self.textViewHeight.constant=44;
        [self.view endEditing:YES];
    }
    
}

#pragma mark --NSDictionary转NSData
- (NSData *)convertToJsonData:(id)dict{

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    if (!jsonData) {
        return nil;
    }else{
        return jsonData;
    }

}


@end
 
