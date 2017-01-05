//
//  HMShapedButton.m
//  controlBtn
//
//  Created by 侯谢送 on 2016/12/25.
//  Copyright © 2016年 侯谢送. All rights reserved.
//

#import "HMShapedButton.h"

@implementation HMShapedButton

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.path = self.path.CGPath;
    self.layer.mask = shapLayer;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL res = [super pointInside:point withEvent:event];
    if (res)
    {
        if ([self.path containsPoint:point])
        {
            return YES;
        }
        return NO;
    }
    return NO;
}


@end
