//
//  ShoppingCarModel.h
//  ShiSanHang
//
//  Created by qiulibi on 16/10/19.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
//#import "ProductModel.h"
@class ShoppingCarResultModel;
@protocol ShoppingCarDetailModel;
@protocol ProductModel;

@interface ShoppingCarModel : JSONModel

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *status;
@property(nonatomic,strong) ShoppingCarResultModel *result;

@end

@interface ShoppingCarResultModel : JSONModel

@property(nonatomic,strong)NSArray<ShoppingCarDetailModel> *resultList;


@end

@interface ShoppingCarDetailModel : JSONModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSMutableArray<ProductModel> *cartList;

@property (nonatomic, strong) NSString *isSelected;//是否选中
@property (nonatomic, assign) NSInteger proSelectedNumber;//商品选中的个数
@end

@interface ProductModel : JSONModel
@property (nonatomic, assign) NSInteger cartId;//购物车id
@property (nonatomic, assign) NSInteger goodsId;//产品id
@property (nonatomic, strong) NSString *goodsName;//产品名
@property (nonatomic, strong) NSString *goodsImage;//默认略缩图
@property (nonatomic, assign) NSInteger storeId;//商店id
@property (nonatomic, strong) NSString *storeName;//商店名

@property (nonatomic, strong) NSString *goodSpec;//颜色、尺寸
@property (nonatomic, assign) NSInteger goodsNum;//数量
@property (nonatomic, assign) double goodsPrice;
@property (nonatomic, strong) NSString *isSelected;
@end
