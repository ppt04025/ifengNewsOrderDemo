//
//  TouchViewModel.h
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-27.
//  Copyright (c) 2014年 zer0. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TouchViewModel : NSObject<NSCoding>

@property (nonatomic,retain) NSString * title;
@property (nonatomic,retain) NSString * urlString;
- (id)initWithTitle:(NSString *)title urlString:(NSString *)urlString;
@end
