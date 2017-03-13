//
//  ViewController.m
//  ShoppingCar
//
//  Created by qiulibi on 17/3/10.
//  Copyright © 2017年 qiulibi. All rights reserved.
//

#import "ViewController.h"
#import "ShoppingCarModel.h"
#import "ShoppingCarTableViewCell.h"
#import "HeaderViewTableViewCell.h"
#import <ReactiveCocoa.h>

static NSString *const headerViewId = @"HeaderViewId";
static NSString *const tableViewCellId = @"shoppingCarCellId";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *allSelect;
@property (weak, nonatomic) IBOutlet UILabel *sumPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectNumLbl;

@property (strong, nonatomic) NSMutableArray *arrayContent;
@property (strong, nonatomic) ShoppingCarModel *model;
@property (assign, nonatomic) NSInteger selectNumber;
@property (assign, nonatomic) CGFloat sumPrice;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[_allSelect rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        
        
        
        self.sumPrice = 0;
        self.selectNumber = 0;
        self.allSelect.selected = !self.allSelect.isSelected;
        
        for (ShoppingCarDetailModel *carModel in _arrayContent) {
            for (ProductModel *productModel in carModel.cartList) {
                productModel.isSelected = [NSString stringWithFormat:@"%d",self.allSelect.selected];
                if (self.allSelect.selected == YES) {
                    self.selectNumber = self.selectNumber + productModel.goodsNum;
                    self.sumPrice = self.sumPrice + productModel.goodsPrice*productModel.goodsNum;
                }
            }
            
            carModel.isSelected = [NSString stringWithFormat:@"%d",self.allSelect.selected];
            if (self.allSelect.selected == YES) {
                carModel.proSelectedNumber = carModel.cartList.count;
            }
            else {
                carModel.proSelectedNumber = 0;
            }
            
        }
        [self selectNum:self.selectNumber sumPrice:self.sumPrice];
        [self.tableView reloadData];
    }];
    
    NSDictionary *responseDict = @{@"message" : @"查询成功",
                             @"result" : @{
                                     @"resultList" : @[
                                                       @{
                                                           @"cartList" : @[
                                                                           @{
                                                                               @"buyerId" : @"8",
                                                                               @"cartId" : @"485",
                                                                               @"columnId" : @"0",
                                                                               @"goodSpec" : @"白色,S",
                                                                               @"goodSpecIds" : @"1,12",
                                                                               @"goodsId" :  @"60",
                                                                               @"goodsImage" :  @"goodsImage",
                                                                               @"goodsName" : @"春装测试",
                                                                               @"goodsNum" : @"10",
                                                                               @"goodsPrice" : @"0.01",
                                                                               @"storeId" : @"40",
                                                                               @"storeName" : @"小店主",
                                                                           }
                                                                       ],
                                                           @"id" : @"40",
                                                           @"name" : @"小店主",
                                                       },
                                                       @{
                                                           @"cartList" : @[
                                                                         @{
                                                                             @"buyerId" : @"8",
                                                                             @"cartId" : @"393",
                                                                             @"columnId" : @"0",
                                                                             @"goodSpec" : @"白色,M",
                                                                             @"goodSpecIds" : @"1,13",
                                                                             @"goodsId" :  @"39",
                                                                             @"goodsImage" :  @"goodsImage",
                                                                             @"goodsName" : @"冬装长款文艺复古裙子",
                                                                             @"goodsNum" : @"2",
                                                                             @"goodsPrice" : @"0.25",
                                                                             @"storeId" : @"21",
                                                                             @"storeName" : @"麻麻店",
                                                                             },
                                                                         @{
                                                                             @"buyerId" : @"8",
                                                                             @"cartId" : @"392",
                                                                             @"columnId" : @"0",
                                                                             @"goodSpec" : @"白色,S",
                                                                             @"goodSpecIds" : @"1,12",
                                                                             @"goodsId" :  @"39",
                                                                             @"goodsImage" :  @"goodsImage",
                                                                             @"goodsName" : @"冬装长款文艺复古裙子",
                                                                             @"goodsNum" : @"2",
                                                                             @"goodsPrice" : @"0.25",
                                                                             @"storeId" : @"21",
                                                                             @"storeName" : @"麻麻店",
                                                                             }
                                                                         ],
                                                           @"id" : @"21",
                                                           @"name" : @"麻麻店",
                                                       }
                                                       ],
                             },
                             @"status" : @"200",
                             };
    ShoppingCarModel *model = [[ShoppingCarModel alloc] initWithDictionary:responseDict error:nil];
    
    [self.arrayContent addObjectsFromArray:model.result.resultList];
    [self.tableView reloadData];
}

- (void)selectNum:(NSInteger)selectNum sumPrice:(CGFloat)sumPrice {
    self.sumPriceLbl.text = [NSString stringWithFormat:@"总价：¥%.2f",sumPrice];
    self.selectNumLbl.text = [NSString stringWithFormat:@"共%ld件商品",selectNum];
}

- (NSMutableArray *)arrayContent {
    if (_arrayContent == nil) {
        _arrayContent = [NSMutableArray array];
    }
    return _arrayContent;
}

//选中
- (void)selectedPro:(ProductModel *)proModel indexPath:(NSIndexPath *)indexPath {
    
    ShoppingCarDetailModel *carModel = _arrayContent[indexPath.section];
    if ([proModel.isSelected isEqualToString:@"1"]) {
        self.selectNumber = self.selectNumber + proModel.goodsNum;
        self.sumPrice = self.sumPrice + proModel.goodsPrice*proModel.goodsNum;
        carModel.proSelectedNumber++;
    }
    else {
        self.selectNumber = self.selectNumber - proModel.goodsNum;
        self.sumPrice = self.sumPrice - proModel.goodsPrice*proModel.goodsNum;
        carModel.proSelectedNumber--;
    }
    if (carModel.proSelectedNumber==carModel.cartList.count) {
        carModel.isSelected = @"1";
        
        self.allSelect.selected = [self judgeAllSelect];
    }
    else{
        
        carModel.isSelected = @"0";
        self.allSelect.selected = NO;
    }
    
    [self selectNum:self.selectNumber sumPrice:self.sumPrice];
    [self.tableView reloadData];
    
}

- (BOOL)judgeAllSelect {
    BOOL isAllSellected = YES;
    for (int i = 0; i < _arrayContent.count; i++) {
        ShoppingCarDetailModel *model = _arrayContent[i];
        if (![model.isSelected isEqualToString:@"1"]) {
            isAllSellected = NO;
            break;
        }
    }
    return isAllSellected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayContent.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    ShoppingCarDetailModel *carModel = _arrayContent[section];
    
    return carModel.cartList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    ShoppingCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellId];
    
    if (cell == nil) {
        
        cell = [[ShoppingCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellId];
    }
    ShoppingCarDetailModel *carModel = _arrayContent[indexPath.section];
    [cell setModel:carModel.cartList[indexPath.row]];
    
    
    //选中
    cell.selectedAction = ^(ProductModel *proModel) {
        [self selectedPro:proModel indexPath:indexPath];
    };
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HeaderViewTableViewCell *sectionHeaderCell = [tableView dequeueReusableCellWithIdentifier:headerViewId];
    
    ShoppingCarDetailModel *carModel = _arrayContent[section];
    if ([carModel.isSelected isEqualToString:@"1"]) {
        sectionHeaderCell.selectedBtn.selected = YES;
    }
    
    [sectionHeaderCell setModel:_arrayContent[section]];
    
    //选中按钮的点击事件
    sectionHeaderCell.selectedAction = ^(ShoppingCarDetailModel *model){
        
        //section及cell的状态改变
        if ([model.isSelected isEqualToString:@"1"]) {
            model.proSelectedNumber = model.cartList.count;
            for (ProductModel *proModel in model.cartList) {
                if (![proModel.isSelected isEqualToString:@"1"]) {
                    proModel.isSelected = @"1";
                    self.selectNumber = self.selectNumber + proModel.goodsNum;
                    self.sumPrice = self.sumPrice + proModel.goodsPrice*proModel.goodsNum;
                }
                
            }
            
            self.allSelect.selected = [self judgeAllSelect];
        }
        else {
            model.isSelected = @"0";
            model.proSelectedNumber = 0;
            for (ProductModel *proModel in model.cartList) {
                proModel.isSelected = @"0";
                self.selectNumber = self.selectNumber - proModel.goodsNum;
                self.sumPrice = self.sumPrice - proModel.goodsPrice*proModel.goodsNum;
            }
            
            self.allSelect.selected = NO;
        }
        
        
        [self selectNum:self.selectNumber sumPrice:self.sumPrice];
        [self.tableView reloadData];
        
        
    };
    
    return sectionHeaderCell.contentView;
}



//使用FDTemplateLayoutCell以缓存cell高度计算
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 135;
}

@end
