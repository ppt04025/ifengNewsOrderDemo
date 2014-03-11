//
//  OrderViewController.h
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-27.
//  Copyright (c) 2014年 zer0. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController
{
    @public
    NSArray * _modelArr1;
    NSMutableArray * _viewArr1;
    NSMutableArray * _viewArr2;
}

@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * titleLabel2;
@property (nonatomic,strong)NSArray * titleArr;
@property (nonatomic,strong)NSArray * urlStringArr;
@property (nonatomic,strong)UIButton * backButton;
@end
