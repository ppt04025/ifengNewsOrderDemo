//
//  OrderButton.m
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-27.
//  Copyright (c) 2014年 zer0. All rights reserved.
//

#import "OrderButton.h"
#import "OrderViewController.h"
#import "RootViewController.h"

@implementation OrderButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+ (id)orderButtonWithViewController:(UIViewController *)vc{
    OrderButton * orderButton = [OrderButton buttonWithType:UIButtonTypeCustom];
    [orderButton setVc:vc];
    [orderButton setImage:[UIImage imageNamed:OrderButtonImage] forState:UIControlStateNormal];
    [orderButton setImage:[UIImage imageNamed:OrderButtonImageSelected] forState:UIControlStateHighlighted];
    [orderButton setFrame:CGRectMake(OrderButtonFrameOriginX, OrderButtonFrameOriginY, OrderButtonFrameSizeX, OrderButtonFrameSizeY)];
    [orderButton addTarget:self action:@selector(orderViewOut:) forControlEvents:UIControlEventTouchUpInside];
    
    return orderButton;

}
+ (void)orderViewOut:(id)sender{
    
    OrderButton * orderButton = (OrderButton *)sender;
    NSLog(@"************%d",[[orderButton.vc.view subviews] count]);
    if([[orderButton.vc.view subviews] count]>1){
//        [[[orderButton.vc.view subviews]objectAtIndex:1] removeFromSuperview];
        NSLog(@"%@",[orderButton.vc.view subviews]);
    }
    OrderViewController * orderVC = [[OrderViewController alloc] init];
    UIView * orderView = [orderVC view];
    [orderView setFrame:CGRectMake(0, - orderButton.vc.view.bounds.size.height, orderButton.vc.view.bounds.size.width, orderButton.vc.view.bounds.size.height)];
    [orderView setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0]];
    
    [orderButton.vc.view addSubview:orderView];
//    [orderVC release];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [orderView setFrame:CGRectMake(0, 0, orderButton.vc.view.bounds.size.width, orderButton.vc.view.bounds.size.height)];
        
    } completion:^(BOOL finished){

    }];
    
}

- (void)dealloc
{
    [_vc release];
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
