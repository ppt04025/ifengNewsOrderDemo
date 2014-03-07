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
    [_label release];
    [_moreChannelsLabel release];
    [_touchViewModel release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.multipleTouchEnabled = YES;
        self.userInteractionEnabled = YES;
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label = l;
        [l release];
        _sign = 0;
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [self.label setFrame:CGRectMake(1, 1, KButtonWidth - 2, KButtonHeight - 2)];
    [self.label setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0]];
    [self addSubview:self.label];
    
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
                [self animationAction];
            }
            else if ( _array == _viewArr22){
                [_viewArr22 removeObject:self];
                [_viewArr11 insertObject:self atIndex:_viewArr11.count];
                _array = _viewArr11;
                [self animationAction];
            }
        }
        
        
        else if (([self buttonInArrayArea1:_viewArr11 Point:point] || [self buttonInArrayArea2:_viewArr22 Point:point])&&!(point.x - _point.x > KTableStartPointX && point.x - _point.x < KTableStartPointX + KButtonWidth && point.y - _point.y > KTableStartPointY && point.y - _point.y < KTableStartPointY + KButtonHeight)){
            if (point.x < KTableStartPointX || point.y < KTableStartPointY) {
                [self setFrame:CGRectMake(_point2.x - _point.x, _point2.y - _point.y, self.frame.size.width, self.frame.size.height)];
            }
            else{
                [self setFrame:CGRectMake(KTableStartPointX + (a + KButtonWidth/2 - KTableStartPointX)/KButtonWidth*KButtonWidth, KTableStartPointY + (b + KButtonHeight/2 - KTableStartPointY)/KButtonHeight*KButtonHeight, self.frame.size.width, self.frame.size.height)];
            }
            
        }
        else{
            
            [self animationAction];
            
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
        [self setFrame:CGRectMake( point.x - _point.x, point.y - _point.y, self.frame.size.width, self.frame.size.height)];
        
        CGFloat newX = point.x - _point.x + KButtonWidth/2;
        CGFloat newY = point.y - _point.y + KButtonHeight/2;
        
        if (!CGRectContainsPoint([[_viewArr11 objectAtIndex:0] frame], CGPointMake(newX, newY)) ) {
            
            if ( _array == _viewArr22) {
                
                if ([self buttonInArrayArea1:_viewArr11 Point:point]) {
                    
                    int index = ((int)newX - KTableStartPointX)/KButtonWidth + (5 * (((int)newY - KTableStartPointY)/KButtonHeight));
                    [ _array removeObject:self];
                    [_viewArr11 insertObject:self atIndex:index];
                    _array = _viewArr11;
                    [self animationAction1a];
                    [self animationAction2];
                }
                else if (newY < KTableStartPointY + [self array2StartY] * KButtonHeight &&![self buttonInArrayArea1:_viewArr11 Point:point]){
                    
                    [ _array removeObject:self];
                    [_viewArr11 insertObject:self atIndex:_viewArr11.count];
                    _array = _viewArr11;
                    [self animationAction2];
                    
                }
                else if([self buttonInArrayArea2:_viewArr22 Point:point]){
                    unsigned long index = ((unsigned long )(newX) - KTableStartPointX)/KButtonWidth + (5 * (((int)(newY) - [self array2StartY] * KButtonHeight - KTableStartPointY)/KButtonHeight));
                    [ _array removeObject:self];
                    [_viewArr22 insertObject:self atIndex:index];
                    [self animationAction2a];
                    
                }
                else if(newY > KTableStartPointY + [self array2StartY] * KButtonHeight &&![self buttonInArrayArea2:_viewArr22 Point:point]){
                    [ _array removeObject:self];
                    [_viewArr22 insertObject:self atIndex:_viewArr22.count];
                    [self animationAction2a];
                    
                }
            }
            else if ( _array == _viewArr11) {
                if ([self buttonInArrayArea1:_viewArr11 Point:point]) {
                    int index = ((int)newX - KTableStartPointX)/KButtonWidth + (5 * (((int)(newY) - KTableStartPointY)/KButtonHeight));
                    [ _array removeObject:self];
                    [_viewArr11 insertObject:self atIndex:index];
                    _array = _viewArr11;
                    
                    [self animationAction1a];
                    [self animationAction2];
                }
                else if (newY < KTableStartPointY + [self array2StartY] * KButtonHeight &&![self buttonInArrayArea1:_viewArr11 Point:point]){
                    [ _array removeObject:self];
                    [_viewArr11 insertObject:self atIndex: _array.count];
                    [self animationAction1a];
                    [self animationAction2];
                }
                else if([self buttonInArrayArea2:_viewArr22 Point:point]){
                    unsigned long index = ((unsigned long)(newX) - KTableStartPointX)/KButtonWidth + (5 * (((int)(newY) - [self array2StartY] * KButtonHeight - KTableStartPointY)/KButtonHeight));
                    [ _array removeObject:self];
                    [_viewArr22 insertObject:self atIndex:index];
                    _array = _viewArr22;
                    [self animationAction2a];
                }
                else if(newY > KTableStartPointY + [self array2StartY] * KButtonHeight &&![self buttonInArrayArea2:_viewArr22 Point:point]){
                    [ _array removeObject:self];
                    [_viewArr22 insertObject:self atIndex:_viewArr22.count];
                    _array = _viewArr22;
                    [self animationAction2a];
                    
                }
            }
        }
    }
}
- (void)animationAction1{
    for (int i = 0; i < _viewArr11.count; i++) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
            [[_viewArr11 objectAtIndex:i] setFrame:CGRectMake(KTableStartPointX + (i%5) * KButtonWidth, KTableStartPointY + (i/5)* KButtonHeight, KButtonWidth, KButtonHeight)];
        } completion:^(BOOL finished){
                
        }];
    }
}
- (void)animationAction1a{
    for (int i = 0; i < _viewArr11.count; i++) {
        if ([_viewArr11 objectAtIndex:i] != self) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                [[_viewArr11 objectAtIndex:i] setFrame:CGRectMake(KTableStartPointX + (i%5) * KButtonWidth, KTableStartPointY + (i/5)* KButtonHeight, KButtonWidth, KButtonHeight)];
            } completion:^(BOOL finished){
                
            }];
        }
    }
    
}
- (void)animationAction2{
    for (int i = 0; i < _viewArr22.count; i++) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(KTableStartPointX + (i%5) * KButtonWidth, KTableStartPointY + [self array2StartY] * KButtonHeight + (i/5)* KButtonHeight, KButtonWidth, KButtonHeight)];
            
        } completion:^(BOOL finished){
            
        }];
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, KTableStartPointY + KButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
        
    } completion:^(BOOL finished){
        
    }];
}
- (void)animationAction2a{
    for (int i = 0; i < _viewArr22.count; i++) {
        if ([_viewArr22 objectAtIndex:i] != self) {
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                
                [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(KTableStartPointX + (i%5) * KButtonWidth, KTableStartPointY + [self array2StartY] * KButtonHeight + (i/5)* KButtonHeight, KButtonWidth, KButtonHeight)];
                
            } completion:^(BOOL finished){
            }];
        }
        
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, KTableStartPointY + KButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
        
    } completion:^(BOOL finished){
        
    }];
}
- (void)animationActionLabel{
    
}

- (void)animationAction{
    for (int i = 0; i < _viewArr11.count; i++) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            [[_viewArr11 objectAtIndex:i] setFrame:CGRectMake(KTableStartPointX + (i%5) * KButtonWidth, KTableStartPointY + (i/5)* KButtonHeight, KButtonWidth, KButtonHeight)];
        } completion:^(BOOL finished){
            
        }];
    }
    for (int i = 0; i < _viewArr22.count; i++) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            [[_viewArr22 objectAtIndex:i] setFrame:CGRectMake(KTableStartPointX + (i%5) * KButtonWidth, KTableStartPointY + [self array2StartY] * KButtonHeight + (i/5)* KButtonHeight, KButtonWidth, KButtonHeight)];
            
        } completion:^(BOOL finished){
            
        }];
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [self.moreChannelsLabel setFrame:CGRectMake(self.moreChannelsLabel.frame.origin.x, KTableStartPointY + KButtonHeight * ([self array2StartY] - 1) + 22, self.moreChannelsLabel.frame.size.width, self.moreChannelsLabel.frame.size.height)];
        
    } completion:^(BOOL finished){
        
    }];
    
}

- (BOOL)buttonInArrayArea1:(NSMutableArray *)arr Point:(CGPoint)point{
    CGFloat newX = point.x - _point.x + KButtonWidth/2;
    CGFloat newY = point.y - _point.y + KButtonHeight/2;
    int a =  arr.count%5;
    unsigned long b =  arr.count/5;
    if ((newX > KTableStartPointX && newX < KTableStartPointX + 5 * KButtonWidth && newY > KTableStartPointY && newY < KTableStartPointY + b * KButtonHeight) || (newX > KTableStartPointX && newX < KTableStartPointX + a * KButtonWidth && newY > KTableStartPointY + b * KButtonHeight && newY < KTableStartPointY + (b+1) * KButtonHeight) ) {
        return YES;
    }
    return NO;
}
- (BOOL)buttonInArrayArea2:(NSMutableArray *)arr Point:(CGPoint)point{
    CGFloat newX = point.x - _point.x + KButtonWidth/2;
    CGFloat newY = point.y - _point.y + KButtonHeight/2;
    int a =  arr.count%5;
    unsigned long b =  arr.count/5;
    if ((newX > KTableStartPointX && newX < KTableStartPointX + 5 * KButtonWidth && newY > KTableStartPointY + [self array2StartY] * KButtonHeight && newY < KTableStartPointY + (b + [self array2StartY]) * KButtonHeight) || (newX > KTableStartPointX && newX < KTableStartPointX + a * KButtonWidth && newY > KTableStartPointY + (b + [self array2StartY]) * KButtonHeight && newY < KTableStartPointY + (b+[self array2StartY]+1) * KButtonHeight) ) {
        return YES;
    }
    return NO;
}
- (unsigned long)array2StartY{
    unsigned long y = 0;
    
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
