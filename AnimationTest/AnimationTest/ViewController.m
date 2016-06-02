//
//  ViewController.m
//  AnimationTest
//
//  Created by zuweizhong  on 16/6/1.
//  Copyright © 2016年 visoft. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()

@property(nonatomic,weak)CALayer *layer1;

@property(nonatomic,strong)UIImageView * imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    CALayer *layer = [CALayer new];
    layer.bounds = CGRectMake(0, 0, 200, 200);
    self.layer1 = layer;
    layer.position = CGPointMake(160, 250);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.borderColor = [UIColor blackColor].CGColor;
    layer.borderWidth = 2.0f;
    layer.opacity = 1.0f;
    [self.view.layer addSublayer:layer];

    [super viewDidLoad];
    /**
     * CALayer隐式动画
     */
//    [self animationTest1];
    /**
     * UIView动画
     */
//    [self animationTest2];
    /**
     * CATransition转场动画
     */
//    [self animationTest3];
    /**
     *  CAPropertyAnimation是CAAnimation的子类，也是个抽象类。要想创建动画，应该使用它的两个子类：CABasicAnimation和CAKeyframeAnimation
     */
    [self animationTest4];
    
    
    
    
    
    

//    [self pushTest];

}
-(void)animationTest4
{
    UIImageView *imageView = [[UIImageView alloc]init];
    
    imageView.frame = CGRectMake(100, 500, 50, 50);
    
    self.imageView = imageView;
    
    imageView.image = [UIImage imageNamed:@"小筛子iOS市场图2"];
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap1:)]];

    self.imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:imageView];


}
-(void)imageViewTap1:(UITapGestureRecognizer *)tap
{

    /*
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //控制动画运行的节奏
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    basic.fromValue = @(1);
    basic.toValue = @(2);
    basic.duration = 0.5f;
    [_imageView.layer addAnimation:basic forKey:NULL];
    
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    keyFrame.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    keyFrame.values = @[@(0.1),@(1.0),@(1.5)];
    
    keyFrame.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    
    keyFrame.calculationMode = kCAAnimationLinear;
    
    [_imageView.layer addAnimation:keyFrame forKey:NULL];
    */
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(_imageView.frame.origin.x + _imageView.frame.size.width/2, _imageView.frame.origin.y + _imageView.frame.size.height/2)];
    
    [path addLineToPoint:CGPointMake(_imageView.frame.origin.x + _imageView.frame.size.width/2,400)];
    
    [path addLineToPoint:CGPointMake(20, 400)];
    
    [path addLineToPoint:_imageView.center];
    
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframe.path = path.CGPath;
    keyframe.duration = 2.0f;;
    [_imageView.layer addAnimation:keyframe forKey:nil];


    


}
-(void)animationTest3
{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    imageView.frame = self.view.bounds;
    
    self.imageView = imageView;
    
    imageView.image = [UIImage imageNamed:@"小筛子iOS市场图2"];
    
    [self.view addSubview:imageView];

    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)]];
 

}
-(void)imageViewTap:(UITapGestureRecognizer *)tap
{
    /**
     *  CATransition的type属性
         1.#define定义的常量
         kCATransitionFade   交叉淡化过渡
         kCATransitionMoveIn 新视图移到旧视图上面
         kCATransitionPush   新视图把旧视图推出去
         kCATransitionReveal 将旧视图移开,显示下面的新视图
         
         2.用字符串表示
         pageCurl            向上翻一页
         pageUnCurl          向下翻一页
         rippleEffect        滴水效果
         suckEffect          收缩效果，如一块布被抽走
         cube                立方体效果
         oglFlip             上下翻转效果
     */
    CATransition *transition = [CATransition animation];
    
    [transition setStartProgress:0.2];
    
    [transition setEndProgress:0.8];
    
    [transition setDuration:1.0];
    
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [transition setType:kCATransitionReveal];
    
    [transition setSubtype:kCATransitionFromTop];
    
    [_imageView.layer addAnimation:transition forKey:@"transitionAni"];
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    ViewController2 *vc2 = [[ViewController2 alloc]init];

    [self.navigationController pushViewController:vc2 animated:NO];

}

-(void)animationTest2
{

    [UIView beginAnimations:@"animitionID" context:NULL];
    
    [UIView setAnimationDuration:2.0];
    
    [UIView setAnimationRepeatAutoreverses:YES];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    [UIView commitAnimations];
    
    


}
-(void)animationTest1
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [btn setTitle:@"隐式动画" forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(100, 400, 100, 40);
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];

}
-(void)btnClick1
{
    //设置变化动画过程是否显示，默认为YES不显示
    
    [CATransaction begin];
    
    [CATransaction setDisableActions:NO];    //  设置是否启动隐式动画
    
    _layer1.cornerRadius = (_layer1.cornerRadius == 0.0f) ? 30.0f : 0.0f; // 设置圆角
    
    _layer1.opacity = (_layer1.opacity == 1.0f) ? 0.5f : 1.0f;// 设置透明度
    
    [CATransaction commit];

}
-(void)pushTest
{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [btn setTitle:@"push" forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(100, 100, 100, 40);
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnClick
{
    ViewController2 *vc2 = [[ViewController2 alloc]init];
    
    vc2.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    [self.navigationController presentViewController:vc2 animated:YES completion:nil];
}

@end
