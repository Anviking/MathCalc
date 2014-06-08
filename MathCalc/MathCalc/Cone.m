//
//  Cone.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-05-18.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Cone.h"

@implementation Cone

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"Cone";
    }
    return self;
}

+ (NSArray *)groupedAttributes
{
    return @[ @[ @"height", @"radius", @"diameter", @"side", @"circumference" ],
              @[ @"baseArea", @"mantleArea", @"surfaceArea" ],
              @[ @"volume"]];
}

- (NSArray *)formulaStrings {
    return @[
             // Volume
             @"$volume = $baseArea * $height / 3",
             @"$baseArea = 3 * $volume / $height",
             @"$height = 3 * $volume / $baseArea",
             
             // Base Area
             @"$baseArea = pi*$radius**2",
             @"$radius = sqrt($baseArea/pi)",
             
             // Circumference
             @"$circumference = $diameter * pi",
             @"$diameter = $circumference / pi",
             
             // Diameter
             @"$diameter = 2*$radius",
             @"$radius = $diameter / 2",
             
             // Side
             @"$side = sqrt(pow($height,2) + pow($radius,2))",
             @"$height = sqrt(pow($side,2) - pow($radius,2))",
             @"$radius = sqrt(pow($side,2) - pow($height,2))",
             
             // Mantle Area
             @"$mantleArea = $radius * $side * pi",
             @"$radius = $mantleArea / ($side * pi)",
             @"$side = $mantleArea / ($radius * pi)",
             
             // Total Area
             @"$surfaceArea = $mantleArea + $baseArea",
             @"$mantleArea = $surfaceArea - $baseArea",
             @"$baseArea = $surfaceArea - $mantleArea"
             ];
}

@end
