//
//  ViewController.m
//  Snake
//
//  Created by 鄭文 on 2018/12/31.
//  Copyright © 2018年 Lingo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int size;
    int width;
    int height;
}
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_startBtn addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchDown];
}

- (void)startGame {
    
    [self setGameReset:NO];
    
    // p 為蛇開始點
    arr = [NSMutableArray new];
    p.x = 1; p.y = 1;
    str1 = NSStringFromCGPoint(p);
    [arr addObject:str1];
    
    // 設定寬及高
    width = self.view.frame.size.width / BOCK_WIDTH1 - 2;
    height = self.view.frame.size.height / BOCK_WIDTH1 - 2;
    
    // 設定蛇可活動的大小
    size = width*height;
    
    // 1073 = 37 * 29
    [self resetFoodPoint];
    
    self.myView = [[myView alloc]initWithFrame:CGRectMake(0, 0, (width+2)*BOCK_WIDTH1, (height+2)*BOCK_WIDTH1)];
    [self.myView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.myView];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerFunc:) userInfo:nil repeats:YES];
    
    // 設定初始方向
    dir = Right;
    
    // 將手勢加上
    [self addSwipe];
    
}

- (void)timerFunc:(NSTimer*)timer{
    
    CGPoint headPoint = CGPointFromString([arr firstObject]);
    i = headPoint.x;
    j = headPoint.y;
    
    switch (dir) {
        case Up:
            j--;
            break;
        case Down:
            j++;
            break;
        case Right:
            i++;
            break;
        case Left:
            i--;
            break;
        default:
            break;
    }
    p.x = i; p.y = j;
    NSString *point = NSStringFromCGPoint(p);
    
    [arr insertObject:point atIndex:0];
    
    if (i==k && j==l) {
        [self resetFoodPoint];
    } else {
        [arr removeLastObject];
    }

    [self.myView setFoodx:k y:l body:arr];
    
    // 若碰到牆就結束
    if (i<1 || i>width || j<1 || j>height) {
        [timer setFireDate:[NSDate distantFuture]];
        [self gameOver];
    }
    
    // 若頭碰到身體就結束
    CGPoint h;
    for (NSString *tmp in arr) {
        if ([tmp isEqual:[arr firstObject]]) {
            continue;
        }
        h = CGPointFromString(tmp);
        if (p.x==h.x && p.y==h.y) {
            [timer setFireDate:[NSDate distantFuture]];
            [self gameOver];
        }
    }
    [self.myView setNeedsDisplay];
    
}

- (void)swipeHandler:(UISwipeGestureRecognizer*)recognizer{
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            dir = Right;
            break;
        case UISwipeGestureRecognizerDirectionDown:
            dir = Down;
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            dir = Left;
            break;
        case UISwipeGestureRecognizerDirectionUp:
            dir = Up;
            break;
        default:
            break;
    }
}

- (void)gameOver{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"GG" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setGameReset:YES];
    }];
    [alert addAction:act];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setGameReset:(Boolean)isReset {
    _startBtn.hidden = !isReset;
    _startBtn.enabled = isReset;
    
    if (isReset) {
        [_myView removeFromSuperview];
    }
}

- (void)resetFoodPoint {
    m = arc4random()%size;
    k = (m%width+1); l = (m%height+1);
}

- (void)addSwipe {
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeHandler:)];
    [swip setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.myView addGestureRecognizer:swip];
    
    swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeHandler:)];
    [swip setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.myView addGestureRecognizer:swip];
    
    swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeHandler:)];
    [swip setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.myView addGestureRecognizer:swip];
    
    swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeHandler:)];
    [swip setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.myView addGestureRecognizer:swip];
}
@end
