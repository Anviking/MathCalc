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
    return @[ @[ @"height", @"radius", @"diameter", @"slantHeight", @"circumference" ],
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
             @"$baseArea = pi*pow($radius, 2)",
             @"$radius = sqrt($baseArea/pi)",
             
             // Circumference
             @"$circumference = $diameter * pi",
             @"$diameter = $circumference / pi",
             
             // Diameter
             @"$diameter = 2*$radius",
             @"$radius = $diameter / 2",
             
             // slantHeight
             @"$slantHeight = sqrt(pow($height,2) + pow($radius,2))",
             @"$height = sqrt(pow($slantHeight,2) - pow($radius,2))",
             @"$radius = sqrt(pow($slantHeight,2) - pow($height,2))",
             
             // Mantle Area
             @"$mantleArea = $radius * $slantHeight * pi",
             @"$radius = $mantleArea / ($slantHeight * pi)",
             @"$slantHeight = $mantleArea / ($radius * pi)",
             
             @"$radius = (sqrt(sqrt(4*pow($mantleArea, 2)+pow(pi,2)*pow($height, 4))/pi-pow($height, 2))) / sqrt(2)",
             @"$radius = $surfaceArea/(sqrt(pi) sqrt(2*$surfaceArea+pi*pow($height, 2)))",
             @"$radius = -(pi*$slantHeight-sqrt(pi)*sqrt(4*$surfaceArea+pi*pow($slantHeight, 2)))/(2*pi)",
 
             // Total Area
             @"$surfaceArea = $mantleArea + $baseArea",
             @"$mantleArea = $surfaceArea - $baseArea",
             @"$baseArea = $surfaceArea - $mantleArea"
             ];
}

@end
