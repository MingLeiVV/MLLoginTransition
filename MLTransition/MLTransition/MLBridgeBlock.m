//
//  MLBridgeBlock.m
//  MLTransition
//
//  Created by 磊 on 16/4/7.
//  Copyright © 2016年 磊. All rights reserved.
//

#import "MLBridgeBlock.h"
#import "UIView+Position.h"
#define navigationBar toController.navigationController.navigationBar
#define Duration 2
#define UIScreen_Width [UIScreen mainScreen].bounds.size.width
#define UIScreen_Height [UIScreen mainScreen].bounds.size.height
#define movePosition 300

UIViewControllerJumpType _jumpType; // 跳转类型
@implementation MLBridgeBlock
+ (animationType)mlGetAnimationWithType:(UIViewAnimationType)type jumpType:(UIViewControllerJumpType)jumpType completion:(completion)finish{
    _jumpType = jumpType;
    switch (type) {
        case UIViewAnimationTypeGradient:
            return [self Gradient:finish];
            break;
        case UIViewAnimationTypeFall:
            return [self Fall:finish];
            break;
        case UIViewAnimationTypeZoom:
            return [self Zoom:finish];
            break;
        case UIViewAnimationTypeScale:
            return [self Scale:finish];
            break;
        case UIViewAnimationTypeSlideOut:
            return [self SlideOut:finish];
            break;
        case UIViewAnimationTypeFlipPage:
            return [self FlipPage:finish];
            break;
        case UIViewAnimationTypeFlip:
            return [self Flip:finish];
            break;
        case UIViewAnimationTypeCubeFlip:
            return [self CubeFlip:finish];
            break;
        case UIViewAnimationTypeRipple:
            return [self Ripple:finish];
            break;
        case UIViewAnimationTypeStack:
            return [self Stack:finish];
            break;
            
    }
    return [self None:finish];
}
+ (void)transitionSeting:(UIViewController *)toController {
    if (_jumpType == UIViewControllerJumpTypePop) {
        CGRect tabBarF = toController.tabBarController.tabBar.frame;
        toController.tabBarController.tabBar.frame = CGRectMake(0, tabBarF.origin.y, tabBarF.size.width, tabBarF.size.height);
    }
}
+ (animationType)Gradient:(completion)finish{
    
    animationType gradient = ^(UIView *containerView,UIView *fromView,UIView *toView,UIViewController *toController){
        fromView.alpha = 1.0;
        toView.alpha = 0.0;
        navigationBar.alpha = 0.0;
        [UIView animateWithDuration:Duration animations:^{
            fromView.alpha = 0.0;
            toView.alpha = 1.0;
            navigationBar.alpha = 1.0;
        } completion:^(BOOL finished) {
            finish();
            [self animationFinish:fromView toView:toView];
        }];
        
    };
    return gradient;
}
+ (animationType)Zoom:(completion)finish {
    animationType zoom = ^(UIView *containerView,UIView *fromView,UIView *toView,UIViewController *toController){
        CABasicAnimation *windowSpecial   = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        fromView.alpha = 0.5;
        toView.alpha = 0.5;
        navigationBar.alpha = 0.0;
        windowSpecial.fromValue           = @(0.01);
        
        windowSpecial.toValue             = @(1);
        
        windowSpecial.duration = Duration - 1;
        
        windowSpecial.repeatCount         = 1;
        windowSpecial.removedOnCompletion = NO;
         [toView.layer addAnimation:windowSpecial forKey:windowSpecial.keyPath];
        [UIView animateWithDuration:Duration animations:^{
                fromView.alpha = 0.0;
                toView.alpha = 1.0;
                navigationBar.alpha = 1.0;
        } completion:^(BOOL finished) {
            finish();
            [self animationFinish:fromView toView:toView];
        }];
    };
    return zoom;
}
+ (animationType)Scale:(completion)finish {
    animationType scale =  ^(UIView *containerView,UIView *fromView,UIView *toView,UIViewController *toController){
            [self transitionSeting:toController];
        CABasicAnimation *windowSpecial   = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        fromView.alpha = 1.0;
        toView.alpha = 0.3;
        navigationBar.alpha = 0.0;
        windowSpecial.fromValue           = @(1);
        windowSpecial.toValue             = @(0.01);
        windowSpecial.duration = Duration - 1;
        windowSpecial.repeatCount         = 1;
        windowSpecial.removedOnCompletion = NO;
        
        [fromView.layer addAnimation:windowSpecial forKey:windowSpecial.keyPath];
        [UIView animateWithDuration:Duration animations:^{
            fromView.alpha = 0.0;
            toView.alpha = 1.0;
            navigationBar.alpha = 1.0;
        } completion:^(BOOL finished) {
            finish();
            [self animationFinish:fromView toView:toView];
        }];

    };
    
    return scale;
}
+ (animationType)Fall:(completion)finish {
    animationType fall = ^(UIView *containerView,UIView *fromView,UIView *toView,UIViewController *toController){
            [self transitionSeting:toController];
        CABasicAnimation *position   = [CABasicAnimation animationWithKeyPath:@"position.y"];
        fromView.alpha = 1.0;
        toView.alpha = 0.3;
        navigationBar.alpha = 0.0;
        position.fromValue           = @(-UIScreen_Height);
        position.toValue             = @(movePosition);
        position.duration = Duration;
        position.repeatCount         = 1;
        position.removedOnCompletion = NO;
        [toView.layer addAnimation:position forKey:position.keyPath];
        
        // 对导航条和tabBar条做相对应的处理
        [navigationBar.layer addAnimation:[self getNavigationBar:UIViewAnimationTypeFall] forKey:position.keyPath];
        
        [UIView animateWithDuration:Duration animations:^{
            toView.alpha = 1.0;
            navigationBar.alpha = 1.0;
        } completion:^(BOOL finished) {
            finish();
            [self animationFinish:fromView toView:toView];
        }];
    };
    return fall;
}
+ (animationType)SlideOut:(completion)finish {
    animationType slideOut = ^(UIView *containerView,UIView *fromView,UIView *toView,UIViewController *toController){
        [self transitionSeting:toController];
        CABasicAnimation *position   = [CABasicAnimation animationWithKeyPath:@"position.y"];
        fromView.alpha = 1.0;
        toView.alpha = 0.3;
        navigationBar.alpha = 0.0;
        position.fromValue           = @(movePosition);
        position.toValue             = @(-UIScreen_Height);
        position.duration = Duration;
        position.repeatCount         = 1;
        position.removedOnCompletion = NO;
        [fromView.layer addAnimation:position forKey:position.keyPath];
        // 对导航条和tabBar条做相对应的处理
        [navigationBar.layer addAnimation:[self getNavigationBar:UIViewAnimationTypeSlideOut] forKey:position.keyPath];
        
        [UIView animateWithDuration:Duration animations:^{
            fromView.alpha = 0.0;
            toView.alpha = 1.0;
            navigationBar.alpha = 1.0;
        } completion:^(BOOL finished) {
            finish();
            [self animationFinish:fromView toView:toView];
        }];
    };
    return slideOut;

}

+ (animationType)FlipPage:(completion)finish {
animationType FlipPage = ^(UIView *containerView,UIView *fromView,UIView *toView,UIViewController *toController){
    
    [containerView sendSubviewToBack:toView];
    fromView.alpha = 1.0;
    toView.alpha = 0.5;
    // 设置所有子layer点
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    // 初始化frame
    CGRect initialFrame = toController.view.frame;
    fromView.frame = initialFrame;
    toView.frame = initialFrame;
    // 对layer设置anchor point 并获得对应transfrom属性
    CATransform3D transfromRotate = [self flipPageSetting:fromView];
    
    [UIView animateWithDuration:Duration - 1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //旋转fromView 90度
        fromView.alpha = 0.0;
        toView.alpha = 1.0;
        fromView.layer.transform = transfromRotate;
    } completion:^(BOOL finished) {
        [self updateAnchorPointAndOffset:CGPointMake(0.5, 0.5) view:fromView];
        fromView.layer.transform = CATransform3DIdentity;
        finish();
        [self animationFinish:fromView toView:toView];
        
    }];
};
    return FlipPage;
}

+ (animationType)Flip:(completion)finish {
    animationType Flip = ^(UIView *containerView,UIView *fromView,UIView *toView,UIViewController *toController){
        
        [containerView sendSubviewToBack:toView];
        fromView.alpha = 1.0;
        toView.alpha = 0.5;
        [UIView animateWithDuration:Duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //旋转fromView 90度
            fromView.alpha = 0.0;
            toView.alpha = 1.0;
        } completion:^(BOOL finished) {
            finish();
            [self animationFinish:fromView toView:toView];
            
        }];
    };
    return Flip;
}

+ (animationType)CubeFlip:(completion)finish {
    animationType CubeFlip = ^(UIView *containerView,UIView *fromView,UIView *toView,UIViewController *toController){
        [fromView addSubview:toView];
        CATransition *transition = [CATransition animation];
        fromView.alpha = 1.0;
        toView.alpha = 0.5;
        transition.type = @"cube";
        transition.subtype = kCATransitionFromRight;
        if (_jumpType == UIViewControllerJumpTypeDismiss || _jumpType == UIViewControllerJumpTypePop) {
             transition.subtype = kCATransitionFromLeft;
        }
        transition.duration = Duration;
        [UIView animateWithDuration:Duration delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
            [fromView.layer addAnimation:transition forKey:nil];
            fromView.alpha = 0.7;
            toView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                fromView.alpha = 1.0;
            } completion:^(BOOL finished) {
                [containerView addSubview:toView];
                finish();
                [self animationFinish:fromView toView:toView];
            }];
            
        }];
        
    };
    return CubeFlip;
}

+ (animationType)Ripple:(completion)finish {
    animationType Ripple = ^(UIView *containerView,UIView *fromView,UIView *toView,UIViewController *toController){
        
        [containerView sendSubviewToBack:toView];
        fromView.alpha = 1.0;
        toView.alpha = 0.5;
        [UIView animateWithDuration:Duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //旋转fromView 90度
            fromView.alpha = 0.0;
            toView.alpha = 1.0;
        } completion:^(BOOL finished) {
            finish();
            [self animationFinish:fromView toView:toView];
            
        }];
    };
    return Ripple;
}

+ (animationType)Stack:(completion)finish {
    animationType Stack = ^(UIView *containerView,UIView *fromView,UIView *toView,UIViewController *toController){
        
        [containerView sendSubviewToBack:toView];
        fromView.alpha = 1.0;
        toView.alpha = 0.5;
        [UIView animateWithDuration:Duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //旋转fromView 90度
            fromView.alpha = 0.0;
            toView.alpha = 1.0;
        } completion:^(BOOL finished) {
            finish();
            [self animationFinish:fromView toView:toView];
            
        }];
    };
    return Stack;
}

+ (animationType)None:(completion)finish {
    animationType none = ^(UIView *containerView,UIView *fromView,UIView *toView,UIViewController *toController){
    };
    return none;
}
+ (CATransform3D)flipPageSetting:(UIView *)fromView {
    if (_jumpType == UIViewControllerJumpTypePresent || _jumpType == UIViewControllerJumpTypePush) {
        [self updateAnchorPointAndOffset:CGPointMake(0, 0.5) view:fromView];
        return CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    }else {
        [self updateAnchorPointAndOffset:CGPointMake(1.0, 0.5) view:fromView];
    }
        return CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
}
+ (void)animationFinish:(UIView *)fromView toView:(UIView *)toView {
    [fromView removeFromSuperview];
    [toView.layer removeAllAnimations];
    [fromView removeFromSuperview];
}
+ (void)updateAnchorPointAndOffset:(CGPoint)anchorPoint view:(UIView *)view{
    view.layer.anchorPoint = anchorPoint;
    view.layer.position    = CGPointMake([UIScreen mainScreen].bounds.size.width * anchorPoint.x, [UIScreen mainScreen].bounds.size.height * anchorPoint.y);
}
+ (CABasicAnimation *)getNavigationBar:(UIViewAnimationType)type {
    CABasicAnimation *position   = [CABasicAnimation animationWithKeyPath:@"position.y"];
    if (type == UIViewAnimationTypeFall) {
        position.fromValue           = @(-UIScreen_Height);
        position.toValue             = @(0);
    }else if (type == UIViewAnimationTypeSlideOut) {
        position.fromValue           = @(0);
        position.toValue             = @(-UIScreen_Height);
    }
    position.duration = Duration;
    position.repeatCount         = 1;
    position.removedOnCompletion = NO;
    return position;
}
@end
