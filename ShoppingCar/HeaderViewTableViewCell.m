//
//  HeaderViewTableViewCell.m
//  ShiSanHang
//
//  Created by qiulibi on 16/10/19.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import "HeaderViewTableViewCell.h"
#import "ShoppingCarModel.h"
#import <ReactiveCocoa.h>

@interface HeaderViewTableViewCell ()
@property (nonatomic, strong) ShoppingCarDetailModel *carModel;
@end

@implementation HeaderViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    [[_selectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        _selectedBtn.selected = !_selectedBtn.isSelected;
        _carModel.isSelected = [NSString stringWithFormat:@"%d",_selectedBtn.selected];
        _selectedAction(_carModel);
        
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(id)model {
    _carModel = model;
    self.storeNameLbl.text = _carModel.name;
    if ([_carModel.isSelected isEqualToString:@"1"]) {
        self.selectedBtn.selected = YES;
    }
    else {
        self.selectedBtn.selected = NO;
    }
}

@end
