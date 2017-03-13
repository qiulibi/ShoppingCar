//
//  ShoppingCarTableViewCell.m
//  ShiSanHang
//
//  Created by qiulibi on 16/10/19.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import "ShoppingCarTableViewCell.h"
#import "ShoppingCarModel.h"
#import <ReactiveCocoa.h>

@interface ShoppingCarTableViewCell ()
@property (nonatomic, strong) ProductModel *proModel;
@end

@implementation ShoppingCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    //删除
//    [[self.deleteBtn rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(id x) {
//        _deleteAction(self.proModel);
//    }];
//    
    //选择
    [[self.selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.selectBtn.selected = !self.selectBtn.selected;
        BOOL select = self.selectBtn.isSelected;
        self.proModel.isSelected = [NSString stringWithFormat:@"%d",select];
        self.selectedAction(self.proModel);
    }];
//
//    //减
//    [[self.subtractBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        self.numTF.text = [NSString stringWithFormat:@"%d",self.numTF.text.intValue - 1];
//        if (self.numTF.text.intValue <= 1) {
//            self.subtractBtn.enabled = NO;
//        }
//        _proModel.goodsNum = self.numTF.text.integerValue;
//        _editNumAction(_proModel,NO);
//    }];
//    
//    //加
//    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        self.numTF.text = [NSString stringWithFormat:@"%d",self.numTF.text.intValue + 1];
//        if (self.numTF.text.intValue > 1) {
//            self.subtractBtn.enabled = YES;
//        }
//        _proModel.goodsNum = self.numTF.text.integerValue;
//        _editNumAction(_proModel,YES);
//    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(id)model {
    
    _proModel = model;
    _contentLbl.text = _proModel.goodsName;
    _proImage.image =  [UIImage imageNamed:_proModel.goodsImage];
    _priceLbl.text = [NSString stringWithFormat:@"¥%.2f",_proModel.goodsPrice];
    NSArray *attrArr = [_proModel.goodSpec componentsSeparatedByString:@","];
    _valueStrLbl.text = [NSString stringWithFormat:@"颜色：%@ 尺寸：%@",attrArr[0],attrArr[1]];
    _numTF.text = [NSString stringWithFormat:@"%ld",_proModel.goodsNum];
    if (self.numTF.text.intValue <= 1) {
        self.subtractBtn.enabled = NO;
    }
    else {
        self.subtractBtn.enabled = YES;
    }
    if ([_proModel.isSelected isEqualToString:@"1"]) {
        self.selectBtn.selected = YES;
    }
    else {
        self.selectBtn.selected = NO;
    }
}

@end
