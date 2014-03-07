//
//  RootViewController.m
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-26.
//  Copyright (c) 2014年 zer0. All rights reserved.
//

#import "RootViewController.h"
#import "OrderViewController.h"
#import "OrderButton.h"
#import "TouchView.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    OrderButton * orderButton = [OrderButton orderButtonWithViewController:self titleArr:[NSArray arrayWithObjects:KChannelList, nil] urlStringArr:[NSArray arrayWithObjects:KChannelUrlStringList, nil]];
    [self.view addSubview:orderButton];
    [orderButton addTarget:self action:@selector(orderViewOut:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)orderViewOut:(id)sender{
    
    OrderButton * orderButton = (OrderButton *)sender;
    if([[orderButton.vc.view subviews] count]>1){
        //        [[[orderButton.vc.view subviews]objectAtIndex:1] removeFromSuperview];
        NSLog(@"%@",[orderButton.vc.view subviews]);
    }
    OrderViewController * orderVC = [[[OrderViewController alloc] init] autorelease];
    orderVC.titleArr = orderButton.titleArr;
    orderVC.urlStringArr = orderButton.urlStringArr;
    UIView * orderView = [orderVC view];
    [orderView setFrame:CGRectMake(0, - orderButton.vc.view.bounds.size.height, orderButton.vc.view.bounds.size.width, orderButton.vc.view.bounds.size.height)];
    [orderView setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0]];
    [orderVC.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:orderView];
    [self addChildViewController:orderVC];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [orderView setFrame:CGRectMake(0, 0, orderButton.vc.view.bounds.size.width, orderButton.vc.view.bounds.size.height)];
        
    } completion:^(BOOL finished){
        
    }];
    
}


- (void)backAction{
    OrderViewController * orderVC = [self.childViewControllers objectAtIndex:0];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [orderVC.view setFrame:CGRectMake(0, - self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
        
    } completion:^(BOOL finished){
        NSString * string = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString * filePath = [string stringByAppendingString:@"/modelArray0.swh"];
        NSString * filePath1 = [string stringByAppendingString:@"/modelArray1.swh"];
        NSMutableArray * modelArr = [NSMutableArray array];
        
        
        for (TouchView * touchView in orderVC->_viewArr1) {
            [modelArr addObject:touchView.touchViewModel];
        }
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:modelArr];
        [data writeToFile:filePath atomically:YES];
        [modelArr removeAllObjects];
        for (TouchView * touchView in orderVC->_viewArr2) {
            [modelArr addObject:touchView.touchViewModel];
        }
        data = [NSKeyedArchiver archivedDataWithRootObject:modelArr];
        [data writeToFile:filePath1 atomically:YES];
        [[[self.childViewControllers  objectAtIndex:0] view] removeFromSuperview];
        [orderVC removeFromParentViewController];
        
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
