//
//  myView.m
//  Snake
//
//  Created by 鄭文 on 2018/12/31.
//  Copyright © 2018年 Lingo. All rights reserved.
//

#import "myView.h"
#import "Define.h"


@implementation myView
{
    int _width;
    int _height;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _width = frame.size.width;
        _height = frame.size.height;
    }
    return self;
}


- (void)drawingRect:(CGContextRef)context{
    
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    for (int i = 0; i < _height ; i+= BOCK_WIDTH1) {
        CGRect rect = CGRectMake(0, i, BOCK_WIDTH2, BOCK_WIDTH2);
        CGContextAddRect(context, rect);
    }
    for (int i = 0; i < _height ; i+= BOCK_WIDTH1) {
        CGRect rect = CGRectMake(_width-BOCK_WIDTH1, i, BOCK_WIDTH2, BOCK_WIDTH2);
        CGContextAddRect(context, rect);
    }
    for (int i = 0; i < _width ; i+= BOCK_WIDTH1) {
        CGRect rect = CGRectMake(i, 0, BOCK_WIDTH2, BOCK_WIDTH2);
        CGContextAddRect(context, rect);
    }
    for (int i = 0; i < _width ; i+= BOCK_WIDTH1) {
        CGRect rect = CGRectMake(i, _height-BOCK_WIDTH1, BOCK_WIDTH2, BOCK_WIDTH2);
        CGContextAddRect(context, rect);
    }
    //CGRect rect = CGRectMake(l, m, BOCK_WIDTH2, BOCK_WIDTH2);
    //CGContextAddRect(context, rect);
    //CGContextFillPath(context);
}

- (void)drawFlash:(CGContextRef)context{
    // 加上要吃的目標
    CGContextSetRGBFillColor(context, 1.0, 0, 0, 1.0);
    CGRect rect1 = CGRectMake(l*BOCK_WIDTH1, m*BOCK_WIDTH1, BOCK_WIDTH2, BOCK_WIDTH2);
    CGContextAddRect(context, rect1);
    
    // 加上身體
    CGContextSetRGBFillColor(context, 1.0, 0, 0, 1.0);
    for (NSString*str in arr) {
        p1 = CGPointFromString(str);
        int locaX = p1.x*BOCK_WIDTH1;
        int locaY = p1.y*BOCK_WIDTH1;
        CGRect rect2 = CGRectMake(locaX, locaY, BOCK_WIDTH2, BOCK_WIDTH2);
        CGContextAddRect(context, rect2);
    }
    CGContextFillPath(context);
}

- (void)setFoodx:(int)a y:(int)b body:(NSMutableArray *)array{
    l = a;
    m = b;
    arr = [NSArray arrayWithArray:array];
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawingRect:context];
    [self drawFlash:context];
}

@end
