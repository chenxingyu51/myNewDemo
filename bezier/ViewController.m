//
//  ViewController.m
//  bezier
//
//  Created by MAC on 2025/1/15.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "BezierView.h"
#import "ProgressView.h"
@interface ViewController ()
/**
 
 */
@property (strong,nonatomic)ProgressView *progress;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置视图大小
    _progress = [[ProgressView alloc]initWithFrame:CGRectMake(100, 100, 70, 70)];
    //设置轨道颜色
    _progress.trackTintColor    = [UIColor whiteColor];
    //设置进度条颜色
    _progress.progressTintColor = [UIColor redColor];
    //设置轨道宽度
    _progress.lineWidth      = 5.0;
    //设置进度1
    _progress.progressValue  = 0.7;
    //设置是否转到 YES进度不用设置
    _progress.animationing   = YES;
    //添加视图
    [self.view addSubview:_progress];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.progress hide];
    //延迟销毁
    [self performSelector:@selector(hidProgress) withObject:self afterDelay:2];

}

- (void)hidProgress {
    
    [UIView animateWithDuration:.25 animations:^{
        [self.progress removeFromSuperview];
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
