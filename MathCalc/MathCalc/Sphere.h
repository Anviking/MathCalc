//
//  Sphere.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-07.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Shape.h"

@interface Sphere : Shape

@property (nonatomic, strong) NSNumber *radius;
@property (nonatomic, strong) NSNumber *diameter;
@property (nonatomic, strong) NSNumber *circumference;
@property (nonatomic, strong) NSNumber *area;
@property (nonatomic, strong) NSNumber *volume;
@end
