//
//  BackgroundView.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-14.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundView : UIView

+ (BackgroundView *)defaultView;
+ (void)setDefaultView:(BackgroundView *)view;

@property (nonatomic, strong) UIView *overlay;
@end

@interface UIViewController (BackgroundView)

- (UIColor *)backgroundViewOverlayColor;

@end
