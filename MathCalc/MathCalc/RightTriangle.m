//
//  RightTriangle.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "RightTriangle.h"

#define ALPHA @"α"
#define BETA @"β"

@implementation RightTriangle

- (NSDictionary *)attributeVariables
{
    return @{ @"height" : @"h",
              @"base" : @"b",
              @"hypotenuse" : @"s",
              @"circonference" : @"C",
              @"area" : @"A",
              @"angleA" : ALPHA,
              @"angleB" : BETA };
}

- (NSArray *)formulaStrings
{
    return @[ @"$hypotenuse = sqrt(pow($height,2)+pow($base,2))",
              @"$circonference = $height + $base + $hypotenuse",
              @"$area = $height * $base / 2",
              @"$angleA = asin($height / $hypotenuse)",
              @"$angleB = asin($base / $hypotenuse)",
              
              @"$height = sqrt(pow($hypotenuse,2)-pow($base,2))",
              @"$height = 2 * $area / $base",
              @"$height = 2 * $area / $base",
              @"$base = 2 * $area / $height"];
}

@end
