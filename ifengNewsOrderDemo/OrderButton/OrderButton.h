//
//  OrderButton.h
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-27.
//  Copyright (c) 2014年 zer0. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderButton : UIButton

@property (nonatomic,strong) UIViewController * vc;
@property (nonatomic,strong) NSArray * titleArr;
@property (nonatomic,strong) NSArray * urlStringArr;

+ (id)orderButtonWithViewController:(UIViewController *)vc titleArr:(NSArray *)titleArr urlStringArr:(NSArray *)urlStringArr;
@end
