//
//  Sphere.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-07.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Sphere.h"

@implementation Sphere

+ (NSArray *)attributes
{
    return @[ @"radius",
              @"diameter",
              @"circumference",
              @"area",
              @"volume" ];
}

- (NSArray *)formulaStrings {
    return @[ @"$diameter = 2 * $radius",
              @"$area = 4*pi * pow($radius, 2)",
              @"$volume = 4*pi*pow($radius, 3)/3",
              @"$circumference = $diameter * pi",
              @"$radius = $diameter / 2",
              @"$radius = sqrt($area / pi / 4)",
              @"$radius = pow((3*$volume/(4*pi)),(1/3))",
              @"$radius = ($circumference /pi) / 2" ];
}

@end
