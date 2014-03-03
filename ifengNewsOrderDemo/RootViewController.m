//
//  RootViewController.m
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-26.
//  Copyright (c) 2014年 zer0. All rights reserved.
//

#import "RootViewController.h"
#import "OrderButton.h"

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
    
    OrderButton * orderButton = [OrderButton orderButtonWithViewController:self];
    [self.view addSubview:orderButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
