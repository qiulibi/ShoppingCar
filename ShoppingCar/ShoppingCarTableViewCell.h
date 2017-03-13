//
//  ShoppingCarTableViewCell.h
//  ShiSanHang
//
//  Created by qiulibi on 16/10/19.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductModel;

@interface ShoppingCarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UIImageView *proImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *valueStrLbl;
@property (weak, nonatomic) IBOutlet UIButton *subtractBtn;//减
@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;//加
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic, strong) void(^selectedAction)(ProductModel *model);
@property (nonatomic, strong) void(^deleteAction)(ProductModel *model);
@property (nonatomic, strong) void(^editNumAction)(ProductModel *model,BOOL isAdd);

- (void)setModel:(id)model;
@end
