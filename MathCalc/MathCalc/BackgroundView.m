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
        UIColor *backgroundColor = [UIColor colorWithHue:0.4 saturation:0.6 brightness:0.8 alpha:1.0];
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = frame;
        gradientLayer.colors = @[(id)[backgroundColor CGColor],
                                 (id)[[UIColor colorWithWhite:1.0f alpha:1.0f] CGColor]];
        gradientLayer.locations = @[@0, @2.0f];
        [self.layer insertSublayer:gradientLayer atIndex:0];
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
