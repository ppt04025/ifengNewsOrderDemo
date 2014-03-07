//
//  OrderViewController.m
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-27.
//  Copyright (c) 2014年 zer0. All rights reserved.
//

#import "OrderViewController.h"
#import "TouchViewModel.h"
#import "TouchView.h"


@interface OrderViewController ()

@end

@implementation OrderViewController

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
    
    NSString * string = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [string stringByAppendingString:@"/modelArray0.swh"];
    NSString * filePath1 = [string stringByAppendingString:@"/modelArray1.swh"];
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray * channelListArr = self.titleArr;
        NSArray * channelUrlStringListArr = self.urlStringArr;
        NSMutableArray * mutArr = [NSMutableArray array];
        for (int i = 0; i < [channelListArr count]; i++) {
            NSString * title = [channelListArr objectAtIndex:i];
            NSString * urlString = [channelUrlStringListArr objectAtIndex:i];
            TouchViewModel * touchViewModel = [[TouchViewModel alloc] initWithTitle:title urlString:urlString];
            [mutArr addObject:touchViewModel];
            [touchViewModel release];
            if (i == KDefaultCountOfUpsideList - 1) {
                NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mutArr];
                [data writeToFile:filePath atomically:YES];
                [mutArr removeAllObjects];
            }
            else if(i == [channelListArr count] - 1){
                NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mutArr];
                [data writeToFile:filePath1 atomically:YES];
            }
            
        }
    }
    
    _modelArr1 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSArray * modelArr2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath1];
    _viewArr1 = [[NSMutableArray alloc] init];
    _viewArr2 = [[NSMutableArray alloc] init];
    
    
    
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 25, 100, 40)];
    _titleLabel.text = @"我的订阅";
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setTextColor:[UIColor colorWithRed:187/255.0 green:1/255.0 blue:1/255.0 alpha:1.0]];
    [self.view addSubview:_titleLabel];
    
    
    
    _titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(110, KTableStartPointY + KButtonHeight * ([self array2StartY] - 1) + 22, 100, 20)];
    _titleLabel2.text = @"更多频道";
    [_titleLabel2 setFont:[UIFont systemFontOfSize:10]];
    [_titleLabel2 setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel2 setTextColor:[UIColor grayColor]];
    [self.view addSubview:_titleLabel2];
    
    
    for (int i = 0; i < _modelArr1.count; i++) {
        TouchView * touchView = [[TouchView alloc] initWithFrame:CGRectMake(KTableStartPointX + KButtonWidth * (i%5), KTableStartPointY + KButtonHeight * (i/5), KButtonWidth, KButtonHeight)];
        [touchView setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
        
        [_viewArr1 addObject:touchView];
        [touchView release];
        touchView->_array = _viewArr1;
        if (i == 0) {
            [touchView.label setTextColor:[UIColor colorWithRed:187/255.0 green:1/255.0 blue:1/255.0 alpha:1.0]];
        }
        else{
            
            [touchView.label setTextColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0]];
        }
        touchView.label.text = [[_modelArr1 objectAtIndex:i] title];
        [touchView.label setTextAlignment:NSTextAlignmentCenter];
        [touchView setMoreChannelsLabel:_titleLabel2];
        touchView->_viewArr11 = _viewArr1;
        touchView->_viewArr22 = _viewArr2;
        [touchView setTouchViewModel:[_modelArr1 objectAtIndex:i]];
        
        [self.view addSubview:touchView];
    }
    
    for (int i = 0; i < modelArr2.count; i++) {
        TouchView * touchView = [[TouchView alloc] initWithFrame:CGRectMake(KTableStartPointX + KButtonWidth * (i%5), KTableStartPointY + [self array2StartY] * KButtonHeight + KButtonHeight * (i/5), KButtonWidth, KButtonHeight)];
        
        [touchView setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
        
        [_viewArr2 addObject:touchView];
        touchView->_array = _viewArr2;
        
        touchView.label.text = [[modelArr2 objectAtIndex:i] title];
        [touchView.label setTextColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0]];
        [touchView.label setTextAlignment:NSTextAlignmentCenter];
        [touchView setMoreChannelsLabel:_titleLabel2];
        touchView->_viewArr11 = _viewArr1;
        touchView->_viewArr22 = _viewArr2;
        [touchView setTouchViewModel:[modelArr2 objectAtIndex:i]];
        
        [self.view addSubview:touchView];
        
        [touchView release];
        
    }
    
    

    

    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setFrame:CGRectMake(self.view.bounds.size.width - 56, self.view.bounds.size.height - 44, 56, 44)];
    [self.backButton setImage:[UIImage imageNamed:@"order_back.png"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"order_back_select.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.backButton];
}

- (void)dealloc{
    [_backButton release];
    [_titleArr release];
    [_urlStringArr release];
    [_titleLabel2 release];
    [_titleLabel release];
    [_viewArr1 release];
    [_viewArr2 release];
    [super dealloc];
}


- (unsigned long )array2StartY{
    unsigned long y = 0;

    y = _modelArr1.count/5 + 2;
    if (_modelArr1.count%5 == 0) {
        y -= 1;
    }
    return y;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
