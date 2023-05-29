//
//  InvoiceSelectOrderCell.m
//  FullCategory
//
//  Created by 浩杰 on 2023/3/11.
//

#import "InvoiceSelectOrderCell.h"

@implementation InvoiceSelectOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)selectButtonAction:(id)sender {
    if (self.clickSendBlock){
        self.clickSendBlock();
    }
}


@end
