//
//  TouchViewModel.h
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-27.
//  Copyright (c) 2014年 zer0. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TouchViewModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * urlString;
- (id)initWithTitle:(NSString *)title urlString:(NSString *)urlString;
@end
