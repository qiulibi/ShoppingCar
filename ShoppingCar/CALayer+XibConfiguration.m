//
//  CALayer+XibConfiguration.m
//  EBluetooth
//
//  Created by ZhongSheng on 16/6/1.
//  Copyright © 2016年 pingread. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer(XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end