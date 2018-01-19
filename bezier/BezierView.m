//
//  BezierView.m
//  bezier
//
//  Created by MAC on 2025/1/15.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "BezierView.h"

#define ANGLE(angle) (angle/180 * M_PI)

@interface BezierView()

@property (nonatomic,strong) CAShapeLayer *shape;

@end
@implementation BezierView

- (instancetype)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _shape = [CAShapeLayer layer];
        
        _shape.frame = self.bounds;
        
        //创建出贝塞尔曲线
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:self.bounds ];
        //划线类型  圆形
        _shape.path              = circlePath.CGPath;
        //填充颜色
        _shape.fillColor         = [UIColor clearColor].CGColor;
        //线段宽度
        _shape.lineWidth         = 1.f;
        //线颜色
        _shape.strokeColor       = [UIColor redColor].CGColor;
        
        _shape.strokeEnd         = 0.f;
        
        [self.layer addSublayer:_shape];
        
    }
    
    return self;
    
}

@synthesize startValue = _startValue;


-(void)setStartValue:(CGFloat)startValue{
    
    _startValue      = startValue;
    
    _shape.strokeEnd = startValue;
    
}

-(CGFloat)startValue{
    
    return _startValue;
    
}

@synthesize linewidth = _linewidth;


-(void)setLinewidth:(CGFloat)linewidth{
    
    _linewidth = linewidth;
    
    _shape.lineWidth = linewidth;
    
}

-(CGFloat)linewidth{
    
    return _linewidth;
    
}

@synthesize lineColor = _lineColor;


-(void)setLineColor:(UIColor *)lineColor{
    
    _lineColor = lineColor;
    
    _shape.strokeColor = lineColor.CGColor;
    
}

-(UIColor *)lineColor{
    
    return _lineColor;
    
}

@synthesize value = _value;


- (void)setValue:(CGFloat)value{
    
    _value = value;
    
    _shape.strokeEnd = value;
    
}

-(CGFloat)value{
    
    return _value;
    
}

- (void)startAniamtion{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    animation.fromValue = @0;
    
    animation.toValue = @1;
    
    animation.repeatCount = 1;
    
    animation.duration = 5.f;
    
    [_shape addAnimation:animation forKey:nil];
    
}




- (void)drawRect:(CGRect)rect {
    
//    //圆形
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 100) radius:50 startAngle:ANGLE(50) endAngle:M_PI clockwise:YES];
//
//    //设置颜色
//    [[UIColor redColor]setStroke];
//    //设置线宽
//    [bezierPath setLineWidth:2];
//    //绘制
//    [bezierPath stroke];
//
//
//    //椭圆
//    //2.椭圆
//    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(200, 150, 100, 200)];
//    [ovalPath setLineWidth:5];
//    [ovalPath stroke];
//
//
//    //二次曲线
//    UIBezierPath* aPath = [UIBezierPath bezierPath];
//
//    aPath.lineWidth = 5.0;//宽度
//    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
//    aPath.lineJoinStyle = kCGLineJoinMiter;  //终点处理
//    //起始点
//    [aPath moveToPoint:CGPointMake(20, 100)];
//    //添加两个控制点
//
//    //    curvepoint:终点   controlPoint:拐点
//    [aPath addQuadCurveToPoint:CGPointMake(200, 100) controlPoint:CGPointMake(170, 0)];
//    //划线
//    [aPath stroke];

    
//    UIBezierPath* bPath = [UIBezierPath bezierPath];
//
//    bPath.lineWidth = 5.0;
//    bPath.lineCapStyle = kCGLineCapRound;  //线条拐角
//    bPath.lineJoinStyle = kCGLineCapRound;  //终点处理
//
//    //起始点
//    [bPath moveToPoint:CGPointMake(20, 250)];
//
//    //添加两个控制点
//    [bPath addCurveToPoint:CGPointMake(350, 250) controlPoint1:CGPointMake(310, 200) controlPoint2:CGPointMake(210, 400)];
//
//    [bPath stroke];
//

//    [self layerKeyFrameAnimation];
    
}


//关键帧动画
-(void)layerKeyFrameAnimation
{
    //画一个path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-40, 100)];
    [path addLineToPoint:CGPointMake(360, 100)];
    [path addLineToPoint:CGPointMake(360, 200)];
    [path addLineToPoint:CGPointMake(-40, 200)];
    [path addLineToPoint:CGPointMake(-40, 300)];
    [path addLineToPoint:CGPointMake(360, 300)];
    
    //几个固定点
    NSValue *orginalValue = [NSValue valueWithCGPoint:self.layer.position];
    NSValue *value_1 = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    NSValue *value_2 = [NSValue valueWithCGPoint:CGPointMake(400, 300)];
    NSValue *value_3 = [NSValue valueWithCGPoint:CGPointMake(400, 400)];
    
    //变动的属性,keyPath后面跟的属性是CALayer的属性
    CAKeyframeAnimation *keyFA = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //value数组，放所有位置信息，如果设置path，此项会被忽略
    keyFA.values = @[orginalValue,value_1,value_2,value_3];
    //动画路径
    //    keyFA.path = path.CGPath;
    //该属性是一个数组，用以指定每个子路径(AB,BC,CD)的时间。如果你没有显式地对keyTimes进行设置，则系统会默认每条子路径的时间为：ti=duration/(帧数)，即每条子路径的duration相等
    keyFA.keyTimes = @[@(0.0),@(0.5),@(0.9),@(2)];
    //动画总时间
    keyFA.duration = 5.0f;
    //重复次数，小于0无限重复
    keyFA.repeatCount = 10;
    
    /*
     这个属性用以指定时间函数，类似于运动的加速度
     kCAMediaTimingFunctionLinear//线性
     kCAMediaTimingFunctionEaseIn//淡入
     kCAMediaTimingFunctionEaseOut//淡出
     kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
     kCAMediaTimingFunctionDefault//默认
     */
    keyFA.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    /*
     fillMode的作用就是决定当前对象过了非active时间段的行为. 比如动画开始之前,动画结束之后。如果是一个动画CAAnimation,则需要将其removedOnCompletion设置为NO,要不然fillMode不起作用.
     
     下面来讲各个fillMode的意义
     kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
     kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
     kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态
     kCAFillModeBoth 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.
     //添加动画
     */
    keyFA.fillMode = kCAFillModeForwards;
    
    /*
     在关键帧动画中还有一个非常重要的参数,那便是calculationMode,计算模式.该属性决定了物体在每个子路径下是跳着走还是匀速走，跟timeFunctions属性有点类似
     其主要针对的是每一帧的内容为一个座标点的情况,也就是对anchorPoint 和 position 进行的动画.当在平面座标系中有多个离散的点的时候,可以是离散的,也可以直线相连后进行插值计算,也可以使用圆滑的曲线将他们相连后进行插值计算. calculationMode目前提供如下几种模式
     
     kCAAnimationLinear calculationMode的默认值,表示当关键帧为座标点的时候,关键帧之间直接直线相连进行插值计算;
     kCAAnimationDiscrete 离散的,就是不进行插值计算,所有关键帧直接逐个进行显示;
     kCAAnimationPaced 使得动画均匀进行,而不是按keyTimes设置的或者按关键帧平分时间,此时keyTimes和timingFunctions无效;
     kCAAnimationCubic 对关键帧为座标点的关键帧进行圆滑曲线相连后插值计算,对于曲线的形状还可以通过tensionValues,continuityValues,biasValues来进行调整自定义,这里的数学原理是Kochanek–Bartels spline,这里的主要目的是使得运行的轨迹变得圆滑;
     kCAAnimationCubicPaced 看这个名字就知道和kCAAnimationCubic有一定联系,其实就是在kCAAnimationCubic的基础上使得动画运行变得均匀,就是系统时间内运动的距离相同,此时keyTimes以及timingFunctions也是无效的.
     */
    keyFA.calculationMode = kCAAnimationPaced;
    
    //旋转的模式,auto就是沿着切线方向动，autoReverse就是转180度沿着切线动
    keyFA.rotationMode = kCAAnimationRotateAuto;
    
    //结束后是否移除动画
    keyFA.removedOnCompletion = NO;
    
    //添加动画
    [self.layer addAnimation:keyFA forKey:@""];
    
}











// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


@end
