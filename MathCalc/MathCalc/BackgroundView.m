//
//  BackgroundView.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-14.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView {
    UIToolbar *toolbar;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = frame;
        gradientLayer.colors = @[(id)[[UIColor colorWithRed:46.0/255.0 green:120.0/255.0 blue:208.0/255 alpha:1] CGColor],
                                 (id)[[UIColor colorWithWhite:1.0f alpha:1.0f] CGColor]];
        gradientLayer.locations = @[@0, @6.0f];
        [self.layer insertSublayer:gradientLayer atIndex:0];
        
        
        // Set up the shape of the circle
        int radius = 100;
        CAShapeLayer *circle = [CAShapeLayer layer];
        // Make a circular shape
        circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                                 cornerRadius:radius].CGPath;
        // Center the shape in self.view
        circle.position = CGPointMake(CGRectGetMidX(frame)-radius,
                                      CGRectGetMidY(frame)-radius);
        
        // Configure the apperence of the circle
        circle.fillColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
        
        // Add to parent layer
        [self.layer addSublayer:circle];

        [self setup];

    }
    return self;
}

- (void)setup {
    // If we don't clip to bounds the toolbar draws a thin shadow on top
    [self setClipsToBounds:YES];
    
    if (!toolbar) {
        toolbar = [[UIToolbar alloc] initWithFrame:[self bounds]];
        [toolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [toolbar setBarStyle:UIBarStyleBlack];
        [self addSubview:toolbar];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[toolbar]|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:NSDictionaryOfVariableBindings(toolbar)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[toolbar]|"
                                                                     options:0
                                                                     metrics:0
                                                                       views:NSDictionaryOfVariableBindings(toolbar)]];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

@end
