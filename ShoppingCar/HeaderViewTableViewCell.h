//
//  HeaderViewTableViewCell.h
//  ShiSanHang
//
//  Created by qiulibi on 16/10/19.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingCarDetailModel;

@interface HeaderViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLbl;

@property (nonatomic, strong) void(^selectedAction)(ShoppingCarDetailModel *model);
- (void)setModel:(id)model;
@end
