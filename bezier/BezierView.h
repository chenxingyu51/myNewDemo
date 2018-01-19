//
//  BezierView.h
//  bezier
//
//  Created by MAC on 2025/1/15.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BezierView : UIView
/**
  起始值  (0 ~ 1)
 */
@property (nonatomic,assign) CGFloat startValue;

/**
  线条宽
 */
@property (nonatomic,assign) CGFloat linewidth;

/**
  线条颜色
 */
@property (nonatomic,strong) UIColor *lineColor;

/**
  变化值
 */
@property (nonatomic,assign) CGFloat value;

- (void)startAniamtion;

- (void)endAnimation;

@end
