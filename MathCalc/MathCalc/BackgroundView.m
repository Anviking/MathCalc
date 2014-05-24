//
//  BackgroundView.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-14.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIColor *backgroundColor = [UIColor colorWithHue:0.4 saturation:0.6 brightness:0.8 alpha:1.0];
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = frame;
        gradientLayer.colors = @[(id)[backgroundColor CGColor],
                                 (id)[[UIColor colorWithWhite:1.0f alpha:1.0f] CGColor]];
        gradientLayer.locations = @[@0, @2.0f];
        [self.layer insertSublayer:gradientLayer atIndex:0];
        
        self.overlay = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.overlay];
    }
    return self;
}

static BackgroundView *defaultView;
+ (void)setDefaultView:(BackgroundView *)view
{
    defaultView = view;
}

+ (BackgroundView *)defaultView
{
    if (!defaultView) {
        defaultView = [[BackgroundView alloc] init];
    }
    return defaultView;
}

@end

@implementation UIViewController (BackgroundView)

- (UIColor *)backgroundViewOverlayColor
{
    return nil;
}

@end