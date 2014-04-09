//
//  RightTriangle.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Shape.h"

@interface RightTriangle : Shape

@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *base;
@property (nonatomic, strong) NSNumber *area;
@property (nonatomic, strong) NSNumber *hypotenuse;
@property (nonatomic, strong) NSNumber *circumference;
@property (nonatomic, strong) NSNumber *angleA;
@property (nonatomic, strong) NSNumber *angleB;

@end
