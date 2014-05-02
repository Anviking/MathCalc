//
//  BlurView.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-05-02.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "BlurView.h"

@implementation BlurView {
    UIToolbar *toolbar;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];

    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
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