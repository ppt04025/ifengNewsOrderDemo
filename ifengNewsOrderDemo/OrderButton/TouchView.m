//
//  TouchView.m
//  TouchDemo
//
//  Created by Zer0 on 13-8-11.
//  Copyright (c) 2013年 Zer0. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView
- (void)dealloc
{
    [self.label release];
    [self.moreChannelsLabel release];
    [self.touchViewModel release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.multipleTouchEnabled = YES;
        self.userInteractionEnabled = YES;
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        _sign = 0;
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [self.label setFrame:CGRectMake(1, 1, ButtonWidth - 2, ButtonHeight - 2)];
    [self.label setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0]];
    [self addSubview:self.label];
    [_label release];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = [touches anyObject];
    
    _point = [touch locationInView:self];
    _point2 = [touch locationInView:self.superview];
    
    [self.superview exchangeSubviewAtIndex:[self.superview.subviews indexOfObject:self] withSubviewAtIndex:[[self.superview subviews] count] - 1];
    
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    int a = point.x - _point.x;
    int b = point.y - _point.y;
    
    if (![self.label.text isEqualToString:@"头条"]) {
        [self.label setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0]];
        [self setImage:nil];
        
        if (_sign == 0) {
            if (_array == _viewArr11) {
                [_viewArr11 removeObject:self];
                [_viewArr22 insertObject:self atIndex:_viewArr22.count];
                _array = _viewArr22;
                for (int i = 0; i < _viewArr11.count; i++) {
                    
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                        
                        [[_viewArr11 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                    } completion:^(BOOL finished){
                        
                    }];
                }
                for (int i = 0; i < _viewArr22.count; i++) {
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                        
                        [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + [self array2StartY] * ButtonHeight + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                        
                    } completion:^(BOOL finished){
                        
                    }];
                }
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    
                    [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, TableStartPointY + ButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
                    
                } completion:^(BOOL finished){
                    
                }];
                
            }
            else if ( _array == _viewArr22){
                [_viewArr22 removeObject:self];
                [_viewArr11 insertObject:self atIndex:_viewArr11.count];
                _array = _viewArr11;
                for (int i = 0; i < _viewArr11.count; i++) {
                    
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                        
                        [[_viewArr11 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                    } completion:^(BOOL finished){
                        
                    }];
                    
                    
                    
                    
                }
                for (int i = 0; i < _viewArr22.count; i++) {
                    
                    
                    
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                        
                        [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + [self array2StartY] * ButtonHeight + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                        
                    } completion:^(BOOL finished){
                        
                    }];
                    
                    
                }
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    
                    [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, TableStartPointY + ButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
                    
                } completion:^(BOOL finished){
                    
                }];
                
            }
        }
        
        
        else if (([self buttonInArrayArea1:_viewArr11 Point:point] || [self buttonInArrayArea2:_viewArr22 Point:point])&&!(point.x - _point.x > TableStartPointX && point.x - _point.x < TableStartPointX + ButtonWidth && point.y - _point.y > TableStartPointY && point.y - _point.y < TableStartPointY + ButtonHeight)){
            if (point.x < TableStartPointX || point.y < TableStartPointY) {
                [self setFrame:CGRectMake(_point2.x - _point.x, _point2.y - _point.y, self.frame.size.width, self.frame.size.height)];
            }
            else{
                [self setFrame:CGRectMake(TableStartPointX + (a + ButtonWidth/2 - TableStartPointX)/ButtonWidth*ButtonWidth, TableStartPointY + (b + ButtonHeight/2 - TableStartPointY)/ButtonHeight*ButtonHeight, self.frame.size.width, self.frame.size.height)];
            }
            
        }
        else{
            
            
            
            for (int i = 0; i < _viewArr11.count; i++) {
                
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    
                    [[_viewArr11 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                } completion:^(BOOL finished){
                    
                }];
                
                
                
                
            }
            for (int i = 0; i < _viewArr22.count; i++) {
                
                
                
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    
                    [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + [self array2StartY] * ButtonHeight + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                    
                } completion:^(BOOL finished){
                    
                }];
                
                
            }
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, TableStartPointY + ButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
                
            } completion:^(BOOL finished){
                
            }];
            
        }
        _sign = 0;
    }
    [self.label setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0]];
    [self setImage:nil];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    _sign = 1;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    if (![self.label.text isEqualToString:@"头条"]) {
        [self.label setBackgroundColor:[UIColor clearColor]];
        [self setImage:[UIImage imageNamed:@"order_drag_move_bg.png"]];
        [self setFrame:CGRectMake( point.x - _point.x, point.y - _point.y , self.frame.size.width, self.frame.size.height)];
        
        if (!(point.x - _point.x + ButtonWidth/2 > TableStartPointX && point.x - _point.x + ButtonWidth/2  < TableStartPointX + ButtonWidth && point.y - _point.y + ButtonHeight/2> TableStartPointY && point.y - _point.y + ButtonHeight/2 < TableStartPointY + ButtonHeight)) {
            
            
            
            if ( _array == _viewArr22) {
                
                
                if ([self buttonInArrayArea1:_viewArr11 Point:point]) {
                    int index = ((int)(point.x - _point.x + ButtonWidth/2) - TableStartPointX)/ButtonWidth + (5 * (((int)(point.y - _point.y + ButtonHeight/2) - TableStartPointY)/ButtonHeight));
                    [ _array removeObject:self];
                    [_viewArr11 insertObject:self atIndex:index];
                    _array = _viewArr11;
                    for (int i = 0; i < _viewArr11.count; i++) {
                        if (i!=index) {
                            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                                
                                [[_viewArr11 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                            } completion:^(BOOL finished){
                                
                            }];
                            
                            
                            
                        }
                    }
                    for (int i = 0; i < _viewArr22.count; i++) {
                        
                        
                        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                            
                            [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + [self array2StartY] * ButtonHeight + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                            
                        } completion:^(BOOL finished){
                            
                        }];
                        
                        
                    }
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                        
                        [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, TableStartPointY + ButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
                        
                    } completion:^(BOOL finished){
                        
                    }];
                }
                else if ( (point.y - _point.y + ButtonHeight/2) < TableStartPointY + [self array2StartY] * ButtonHeight &&![self buttonInArrayArea1:_viewArr11 Point:point]){
                    
                    [ _array removeObject:self];
                    [_viewArr11 insertObject:self atIndex:_viewArr11.count];
                    _array = _viewArr11;
                    for (int i = 0; i < _viewArr22.count; i++) {
                        
                        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                            if ([_viewArr22 objectAtIndex:i] != self) {
                                
                                [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + [self array2StartY] * ButtonHeight + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                            }
                            
                        } completion:^(BOOL finished){
                            
                        }];
                    }
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                        
                        [_moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, TableStartPointY + ButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
                        
                    } completion:^(BOOL finished){
                        
                    }];
                    
                }
                else if([self buttonInArrayArea2:_viewArr22 Point:point]){
                    int index = ((int)(point.x - _point.x + ButtonWidth/2) - TableStartPointX)/ButtonWidth + (5 * (((int)(point.y - _point.y + ButtonHeight/2) - [self array2StartY] * ButtonHeight - TableStartPointY)/ButtonHeight));
                    [ _array removeObject:self];
                    [_viewArr22 insertObject:self atIndex:index];
                    for (int i = 0; i < _viewArr22.count; i++) {
                        if (i != index) {
                            
                            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                                
                                
                                [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + [self array2StartY] * ButtonHeight + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                                
                            } completion:^(BOOL finished){
                            }];
                        }
                        
                    }
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                        
                        [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, TableStartPointY + ButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
                        
                    } completion:^(BOOL finished){
                        
                    }];
                    
                }
                else if((point.y - _point.y + ButtonHeight/2) > TableStartPointY + [self array2StartY] * ButtonHeight &&![self buttonInArrayArea2:_viewArr22 Point:point]){
                    [ _array removeObject:self];
                    [_viewArr22 insertObject:self atIndex:_viewArr22.count];
                    for (int i = 0; i < _viewArr22.count; i++) {
                        if ([_viewArr22 objectAtIndex:i] != self) {
                            
                            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                                
                                [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + [self array2StartY] * ButtonHeight + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                                
                            } completion:^(BOOL finished){
                                
                            }];
                        }
                    }
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                        
                        [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, TableStartPointY + ButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
                        
                    } completion:^(BOOL finished){
                        
                    }];
                    
                }
            }
            else if ( _array == _viewArr11) {
                if ( _array == _viewArr11) {
                    if ([self buttonInArrayArea1:_viewArr11 Point:point]) {
                        int index = ((int)(point.x - _point.x + ButtonWidth/2) - TableStartPointX)/ButtonWidth + (5 * (((int)(point.y - _point.y + ButtonHeight/2) - TableStartPointY)/ButtonHeight));
                        [ _array removeObject:self];
                        [_viewArr11 insertObject:self atIndex:index];
                        _array = _viewArr11;
                        
                        for (int i = 0; i < _viewArr11.count; i++) {
                            if (i!=index) {
                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                                    
                                    [[_array objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                                    
                                } completion:^(BOOL finished){
                                    
                                }];
                            }
                        }
                        for (int i = 0; i < _viewArr22.count; i++) {
                            
                            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                                
                                
                                [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + [self array2StartY] * ButtonHeight + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                                
                            } completion:^(BOOL finished){
                                
                            }];
                        }
                        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                            
                            [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, TableStartPointY + ButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
                            
                        } completion:^(BOOL finished){
                            
                        }];
                    }
                    else if ((point.y - _point.y + ButtonHeight/2) < TableStartPointY + [self array2StartY] * ButtonHeight &&![self buttonInArrayArea1:_viewArr11 Point:point]){
                        [ _array removeObject:self];
                        [_viewArr11 insertObject:self atIndex: _array.count];
                        for (int i = 0; i < _viewArr11.count; i++) {
                            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                                if ([_viewArr11 objectAtIndex:i] != self) {
                                    
                                    [[_viewArr11 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + 0 * ButtonHeight + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                                }
                                
                            } completion:^(BOOL finished){
                                
                            }];
                        }
                        for (int i = 0; i < _viewArr22.count; i++) {
                            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                                
                                
                                [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + [self array2StartY] * ButtonHeight + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                                
                            } completion:^(BOOL finished){
                                
                            }];
                        }
                        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                            
                            [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, TableStartPointY + ButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
                            
                        } completion:^(BOOL finished){
                            
                        }];
                    }
                    else if([self buttonInArrayArea2:_viewArr22 Point:point]){
                        int index = ((int)(point.x - _point.x + ButtonWidth/2) - TableStartPointX)/ButtonWidth + (5 * (((int)(point.y - _point.y + ButtonHeight/2) - [self array2StartY] * ButtonHeight - TableStartPointY)/ButtonHeight));
                        [ _array removeObject:self];
                        [_viewArr22 insertObject:self atIndex:index];
                        _array = _viewArr22;
                        for (int i = 0; i < _viewArr22.count; i++) {
                            if (i != index) {
                                
                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                                    
                                    
                                    [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + [self array2StartY] * ButtonHeight + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                                    
                                } completion:^(BOOL finished){
                                }];
                            }
                            
                        }
                        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                            
                            [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, TableStartPointY + ButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
                            
                        } completion:^(BOOL finished){
                            
                        }];
                        
                    }
                    else if((point.y - _point.y + ButtonHeight/2) > TableStartPointY + [self array2StartY] * ButtonHeight &&![self buttonInArrayArea2:_viewArr22 Point:point]){
                        [ _array removeObject:self];
                        [_viewArr22 insertObject:self atIndex:_viewArr22.count];
                        _array = _viewArr22;
                        for (int i = 0; i < _viewArr22.count; i++) {
                            if ([_viewArr22 objectAtIndex:i] != self) {
                                
                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                                    
                                    [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(TableStartPointX + (i%5) * ButtonWidth, TableStartPointY + [self array2StartY] * ButtonHeight + (i/5)* ButtonHeight, ButtonWidth, ButtonHeight)];
                                    
                                } completion:^(BOOL finished){
                                    
                                }];
                            }
                        }
                        
                        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                            
                            [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, TableStartPointY + ButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
                            
                        } completion:^(BOOL finished){
                            
                        }];
                        
                        
                    }
                }
                
            }
            
        }
    }
}


- (BOOL)buttonInArrayArea1:(NSMutableArray *)arr Point:(CGPoint)point{
    int a =  arr.count%5;
    int b =  arr.count/5;
    if ((point.x - _point.x + ButtonWidth/2 > TableStartPointX && point.x - _point.x + ButtonWidth/2 < TableStartPointX + 5 * ButtonWidth && point.y - _point.y + ButtonHeight/2 > TableStartPointY && point.y - _point.y + ButtonHeight/2 < TableStartPointY + b * ButtonHeight) || (point.x - _point.x + ButtonWidth/2 > TableStartPointX && point.x - _point.x + ButtonWidth/2 < TableStartPointX + a * ButtonWidth && point.y - _point.y + ButtonHeight/2 > TableStartPointY + b * ButtonHeight && point.y - _point.y + ButtonHeight/2 < TableStartPointY + (b+1) * ButtonHeight) ) {
        return YES;
    }
    return NO;
}
- (BOOL)buttonInArrayArea2:(NSMutableArray *)arr Point:(CGPoint)point{
    int a =  arr.count%5;
    int b =  arr.count/5;
    if ((point.x - _point.x + ButtonWidth/2 > TableStartPointX && point.x - _point.x + ButtonWidth/2 < TableStartPointX + 5 * ButtonWidth && point.y - _point.y + ButtonHeight/2 > TableStartPointY + [self array2StartY] * ButtonHeight && point.y - _point.y + ButtonHeight/2 < TableStartPointY + (b + [self array2StartY]) * ButtonHeight) || (point.x - _point.x + ButtonWidth/2 > TableStartPointX && point.x - _point.x + ButtonWidth/2 < TableStartPointX + a * ButtonWidth && point.y - _point.y + ButtonHeight/2 > TableStartPointY + (b + [self array2StartY]) * ButtonHeight && point.y - _point.y + ButtonHeight/2 < TableStartPointY + (b+[self array2StartY]+1) * ButtonHeight) ) {
        return YES;
    }
    return NO;
}
- (int)array2StartY{
    int y = 0;
    
    y = _viewArr11.count/5 + 2;
    if (_viewArr11.count%5 == 0) {
        y -= 1;
    }
    return y;
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
