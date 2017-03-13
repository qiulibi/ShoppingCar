//
//  CALayer+XibConfiguration.h
//  EBluetooth
//
//  Created by ZhongSheng on 16/6/1.
//  Copyright © 2016年 pingread. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer(XibConfiguration)

// This assigns a CGColor to borderColor.
@property(nonatomic, assign) UIColor* borderUIColor;

@end
