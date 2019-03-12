//
//  myView.h
//  Snake
//
//  Created by 鄭文 on 2018/12/31.
//  Copyright © 2018年 Lingo. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface myView : UIView{
    int l,m;
    NSArray *arr;
    CGPoint p1;
}


- (void)drawingRect:(CGContextRef)context;
- (void)drawFlash:(CGContextRef)context;
-(void)setFoodx:(int)a y:(int)b body:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
