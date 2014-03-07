//
//  TouchViewModel.m
//  ifengNewsOrderDemo
//
//  Created by zer0 on 14-2-27.
//  Copyright (c) 2014年 zer0. All rights reserved.
//

#import "TouchViewModel.h"

@implementation TouchViewModel
- (void)dealloc
{
    [_title release];
    [_urlString release];
    [super dealloc];
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.urlString forKey:@"urlString"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.urlString = [aDecoder decodeObjectForKey:@"urlString"];
    }
    return self;
}
- (id)initWithTitle:(NSString *)title urlString:(NSString *)urlString{
    if (self = [super init]) {
        self.title = title;
        self.urlString = urlString;
    }
    return self;
}

@end
