//
//  MineMakeInvoiceItemCell.m
//  FullCategory
//
//  Created by 浩杰 on 2023/3/11.
//

#import "MineMakeInvoiceItemCell.h"


@interface MineMakeInvoiceItemCell ()<UITextFieldDelegate>

@end
@implementation MineMakeInvoiceItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textField.delegate = self;
    // Initialization code
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.endEdittingBlock){
        self.endEdittingBlock(textField.text);
    }
}

@end
