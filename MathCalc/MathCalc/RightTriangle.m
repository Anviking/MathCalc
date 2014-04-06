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

- (NSArray *)primitiveAttributes
{
    return @[ @"height", @"base" ];
}

- (NSArray *)primitiveFormulaStings
{
    return @[ @"$h = sqrt(pow($s,2)-pow($b,2))",
              @"$h = 2 * $A / $b"
              @"$h = 2 * $A / $b",
              @"$b = 2 * $A / $h"];
}

- (NSArray *)formulaStrings
{
    return @[ @"$s = sqrt(pow($h,2)+pow($b,2))",
              @"$C = $h + $b + $s",
              @"$A = $h * $b / 2",
              @"$α = asin($h/$s)",
              @"$β = asin($b/$s)"];
}

@end
