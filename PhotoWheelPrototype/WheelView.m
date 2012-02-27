//
//  WheelView.m
//  PhotoWheelPrototype
//
//  Created by Mark Nichols on 2/27/12.
//  Copyright (c) 2012 Mark H. Nichols. All rights reserved.
//

#import "WheelView.h"

@implementation WheelView

@synthesize dataSource = _dataSource;

- (void)setAngle:(CGFloat)angle
{
    // The following code is inspired by the carousel example at 
    // http://stackoverflow.com/questions/5243614/3d-carousel-effect-on-the-ipad
    
    CGPoint center = CGPointMake(CGRectGetMaxX([self bounds]),
                                 CGRectGetMaxY([self bounds])); 
    CGFloat radiusX = MIN([self bounds].size.width, [self bounds].size.height) * 0.35;
    CGFloat radiusY = radiusX;
    
    NSInteger cellCount = [[self dataSource] wheelViewNumberOfCells:self];
    float angleToAdd = 360.0f / cellCount;
    
    for (NSInteger index = 0; index < cellCount; index++) {
        WheelViewCell *cell = [[self dataSource] wheelView:self cellAtIndex:index];
        if ([cell superview] == nil) {
            [self addSubview:cell];
        }
            
        float angleInRadians = (angle + 180.0) * M_PI / 180.0f;
            
        // get a position based on the angle
        float xPosition = center.x + (radiusX * sinf(angleInRadians)) - (CGRectGetWidth([cell frame]) / 2);
        float yPosition = center.y + (radiusY * cosf(angleInRadians)) - (CGRectGetHeight([cell frame]) / 2);
        
        [cell setTransform:CGAffineTransformMakeTranslation(xPosition, yPosition)];
         
        // work out what the next angle is going to be
        angle += angleToAdd;
    }
    
}

- (void)layoutSubviews
{
    [self setAngle:0];
}

@end

@implementation WheelViewCell
@end