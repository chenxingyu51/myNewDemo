//
//  ProgressView.h
//  bezier
//
//  Created by MAC on 2025/1/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView
//进度颜色
@property(nonatomic, retain) UIColor* progressTintColor ;
//轨道颜色
@property(nonatomic, retain) UIColor* trackTintColor ;
//轨道宽度
@property (nonatomic,assign) float lineWidth;
//中间图片
@property (nonatomic,strong) UIImage *centerImage;
//进度1
@property (nonatomic,assign) float progressValue;
//进度2
@property (nonatomic,assign) float progressValue2;
//提示标题
@property (nonatomic,strong) NSString *promptTitle;
//开启动画
@property (nonatomic,assign) BOOL animationing;

//隐藏消失
- (void)hide;

@end
