//
//  Cylinder.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-09.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Cylinder.h"

@implementation Cylinder

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"Cylinder";
        self.minimumNumberOfAttributesRequired = 2;
    }
    return self;
}

+ (NSArray *)groupedAttributes
{
    return @[ @[ @"height", @"radius", @"diameter", @"circumference" ],
              @[ @"baseArea", @"mantleArea", @"surfaceArea" ],
              @[ @"volume"]];
}

- (NSArray *)formulaStrings {
    return @[
             // Volume
             @"$volume = $baseArea * $height",
             @"$baseArea = $volume / $height",
             @"$height = $volume / $baseArea",
             
             // Base Area
             @"$baseArea = pi*$radius**2",
             @"$radius = sqrt($baseArea/pi)",
             
             // Circumference
             @"$circumference = $diameter * pi",
             @"$diameter = $circumference / pi",
             
             // Diameter
             @"$diameter = 2*$radius",
             @"$radius = $diameter / 2",
             
             // Mantle Area
             @"$mantleArea = $circumference * $height",
             @"$circumference = $mantleArea / $height",
             @"$height = $mantleArea / $circumference",
             
             // Total Area
             @"$surfaceArea = $mantleArea + $baseArea",
             @"$mantleArea = $surfaceArea - $baseArea",
             @"$baseArea = $surfaceArea - $mantleArea",
             
             @"$radius = (sqrt(pi) sqrt($surfaceArea+pi pow($height, 2))-pi $height)/pi",
             @"$height = pow($mantleArea, 2)/(4*pi*$volume)" ];
}


@end
