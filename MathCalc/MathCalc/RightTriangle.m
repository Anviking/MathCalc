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

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"Right Triangle";
    }
    return self;
}

+ (NSArray *)attributes
{
    return @[ @"height",
              @"base",
              @"hypotenuse",
              @"circumference",
              @"area",
              @"angleA",
              @"angleB" ];
}

- (NSArray *)formulaStrings
{
    return @[ @"$hypotenuse = sqrt(pow($height,2)+pow($base,2))",
              @"$circumference = $height + $base + $hypotenuse",
              @"$area = $height * $base / 2",
              
              // Calculate angles from height, base and hypotenuse
              @"$angleA = asin($height / $hypotenuse)",
              @"$angleB = acos($height / $hypotenuse)",
              @"$angleA = acos($base / $hypotenuse)",
              @"$angleB = asin($base / $hypotenuse)",
              
              @"$angleA = 90 - $angleB",
              @"$angleB = 90 - $angleA",
              
              // Calculate base and height from angles, hypotenuse and base
              @"$height = $hypotenuse * sin($angleA)",
              @"$height = $hypotenuse * cos($angleB)",
              @"$height = $base * tan($angleA)",
              @"$height = $base / tan($angleB)",
              
              @"$base = $hypotenuse * cos($angleA)",
              @"$base = $hypotenuse * sin($angleB)",
              @"$base = $height * tan($angleB)",
              @"$base = $height / tan($angleA)",
              
              @"$height = $circumference / (tan($angleB)+sqrt( pow((1/cos($angleB)),2) ) + 1)",
              @"$height = sqrt(2*$area*tan($angleA))",
              
              @"$height = sqrt(pow($hypotenuse,2)-pow($base,2))",
              @"$height = 2 * $area / $base",
              @"$height = ($circumference($circumference - 2*$base))/(2($circumference - $base))",
              
              @"$base = 2 * $area / $height",
              @"$base = sqrt(pow($hypotenuse,2)-pow($height,2))",
              @"$base = ($circumference($circumference - 2*$height))/(2($circumference - $height))"];
}

@end
