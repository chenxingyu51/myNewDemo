
//
//  ProgressView.m
//  bezier
//
//  Created by MAC on 2025/1/16.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView()

@property (nonatomic,strong) CAShapeLayer *trackLayer;

@property (nonatomic,strong) CAShapeLayer *progressLayer;

@property (nonatomic,strong) CAShapeLayer *progressLayer2;
/**
 绘制对号
 */
@property (strong,nonatomic) CAShapeLayer *duihaoLayer;
/**
 btn
 */
@property (strong,nonatomic)UIButton      *btn;

@end

@implementation ProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化
         self.backgroundColor=[UIColor clearColor];
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //轨道线
    _trackLayer             = [CAShapeLayer layer];
    _trackLayer.frame       = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //设置线宽
    _trackLayer.lineWidth   = _lineWidth;
    //线颜色
    _trackLayer.strokeColor = _trackTintColor.CGColor;
    //填充颜色
    _trackLayer.fillColor   = self.backgroundColor.CGColor;
    //画线类型
    _trackLayer.lineCap     = kCALineCapButt;
    //添加到视图上
    [self.layer addSublayer:_trackLayer];
    
    //进度线
    _progressLayer             = [CAShapeLayer layer];
    _progressLayer.frame       = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _progressLayer.lineWidth   =_lineWidth;
    _progressLayer.strokeColor = _progressTintColor.CGColor;
    _progressLayer.fillColor   = self.backgroundColor.CGColor;
    _progressLayer.lineCap     = kCALineCapRound;
    [self.layer addSublayer:_progressLayer];
    
    //进度线2
    _progressLayer2             = [CAShapeLayer layer];
    _progressLayer2.frame       = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _progressLayer2.lineWidth   =_lineWidth;
//    _progressLayer2.strokeColor =_progressTintColor.CGColor;
    _progressLayer2.fillColor   = self.backgroundColor.CGColor;
    _progressLayer2.strokeColor = [UIColor cyanColor].CGColor;
    _progressLayer2.lineCap     = kCALineCapRound;
//    [self.layer addSublayer:_progressLayer2];
    
    
    

    //设置图片
    if (_centerImage!=nil) {
        UIImageView *centerImgView = [[UIImageView alloc]initWithImage:_centerImage];
        centerImgView.frame = CGRectMake(_lineWidth, _lineWidth, self.frame.size.width-2*_lineWidth, self.frame.size.height-_lineWidth*2);
        //        centerImgView.center=self.center;
        centerImgView.layer.cornerRadius = (self.frame.size.width+_lineWidth)/2;
        centerImgView.clipsToBounds      = YES;
        [self.layer addSublayer:centerImgView.layer];
    }
    
    [self start];
}


- (void)drawBackgroundCircle:(BOOL) animationing {
    
    //贝塞尔曲线 0度是在十字右边方向   －M_PI/2相当于在十字上边方向
    CGFloat startAngle = - ((float)M_PI / 2); // 90 Degrees
    
    //从startangle 到endangle  弧度线长度
    CGFloat endAngle   = (2 * (float)M_PI) + - ((float)M_PI / 8);
    
    //圆中心
    CGPoint center     = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    //半径
    CGFloat radius     = (self.bounds.size.width - _lineWidth)/2;
    
//    CGFloat radius2    = radius - 5;
    
    //初始化 贝塞尔曲线
    UIBezierPath *processPath = [UIBezierPath bezierPath];

    UIBezierPath *trackPath   = [UIBezierPath bezierPath];
//
//  UIBezierPath *processPath2 = [UIBezierPath bezierPath];
    


    endAngle = M_PI - M_PI /8;

    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    [trackPath addArcWithCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    
//    [processPath2 addArcWithCenter:center radius:radius2 startAngle:startAngle endAngle:M_PI clockwise:YES];
    
//    layer 图线路径
    _progressLayer .path  = processPath.CGPath;
    _trackLayer.path      = trackPath.CGPath;


//    _progressLayer2.path  = processPath2.CGPath;

    
}


- (void)start
{
    [self drawBackgroundCircle:_animationing];
    
    if (_animationing) {

        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //添加运动参数
        rotationAnimation.toValue     = [NSNumber numberWithFloat:M_PI * 2.0];
        //配置动画时间
        rotationAnimation.duration    = .5;
        rotationAnimation.cumulative  = YES;
        //是否重复
        rotationAnimation.repeatCount = HUGE_VALF;
        //添加layer动画
        [_progressLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        rotationAnimation.toValue     = [NSNumber numberWithFloat:-M_PI * 2.0];
        [_progressLayer2 addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
    
}

- (void)hide
{
    [UIView animateWithDuration:.25 animations:^{
        
        [self.progressLayer2 removeFromSuperlayer];
        [self.progressLayer removeFromSuperlayer];
        [self.trackLayer removeFromSuperlayer];
        
    }];
   
    [self btn];

}

- (void)shakeToShow:(UIView*)aView{
    
    //改变frame animation 动画
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration     = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    
    [aView.layer addAnimation:animation forKey:nil];
    
    
}

- (UIButton *)btn {
    
    if (!_btn) {
        
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        _btn.backgroundColor    = [UIColor blueColor];
        _btn.layer.cornerRadius = 35;
        [self addSubview:_btn];
        _btn.titleLabel.font    = [UIFont boldSystemFontOfSize:14];
        [self shakeToShow:_btn];
        
        //layer 对号
        _duihaoLayer             = [CAShapeLayer layer];
        _duihaoLayer.frame       = CGRectMake(0, 0, 50, 50);
        _duihaoLayer.lineWidth   =_lineWidth;
        _duihaoLayer.fillColor   = _btn.backgroundColor.CGColor;
        _duihaoLayer.strokeColor = [UIColor whiteColor].CGColor;
        _duihaoLayer.lineCap     = kCALineCapRound;
        [self.btn.layer addSublayer:self.duihaoLayer];
        
        //绘制对号
        UIBezierPath *duihaoBezier  = [UIBezierPath bezierPath];
        
        [duihaoBezier moveToPoint:CGPointMake(20, 30)];
        
        CGPoint p1 = CGPointMake(30, 40);
        
        [duihaoBezier addLineToPoint:p1];
        
        CGPoint p2 = CGPointMake(50,20);
        
        [duihaoBezier addLineToPoint:p2];
        
        self.duihaoLayer.path = duihaoBezier.CGPath;
        
        [self duihaoLayerAnimation];
        
        
    }
    
    return _btn;
}


- (void)duihaoLayerAnimation {
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 1.5;
    [self.duihaoLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 
 
 
 
 //---------------------------------------
 // Make end angle to 90% of the progress   360度 * 0.1  ->  1/10 占据比例
 //---------------------------------------
 
 
 
 
 
 
 //    if (!animationing) {
 //        endAngle = (_progressValue * 2*(float)M_PI) + startAngle;
 //    }
 //    else
 //    {
 ////        endAngle = (0.1 * 2*(float)M_PI) + startAngle;
 //    }
 
*/

@end
