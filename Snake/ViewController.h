//
//  ViewController.h
//  Snake
//
//  Created by 鄭文 on 2018/12/31.
//  Copyright © 2018年 Lingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myView.h"
#import "Define.h"
@interface ViewController : UIViewController
{
    int i,j,k,l;
    Direction dir;
    NSMutableArray *arr;
    CGPoint p;
    NSString *str1;
    int m;
}
@property (nonatomic,strong)myView *myView;
@end

