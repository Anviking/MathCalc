//
//  Pyramid.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-07.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Pyramid.h"

@implementation Pyramid

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"Pyramid";
    }
    return self;
}

+ (NSArray *)groupedAttributes
{
    return @[ @[ @"base", @"height", @"slantHeight", @"lateralEdge", ],
              @[ @"baseArea", @"surfaceArea", @"lateralSurfaceArea" ],
              @[ @"volume" ],
              @[ @"slantAngle", @"lateralEdgeAngle" ]];
}

- (NSArray *)formulaStrings {
    return @[ @"$baseArea = $base * $base",
              @"$base = sqrt($baseArea)",
              
              // Volume
              @"$volume = $baseArea * $height / 3",
              @"$baseArea = $volume / $height * 3",
              @"$height = $volume / $baseArea * 3",
              
              @"$lateralSurfaceArea = $base * sqrt(pow($base, 2) + 4*pow($height, 2))",
              @"$base = sqrt(sqrt(pow($lateralSurfaceArea, 2)+4 pow($height, 4))-2 pow($height, 2))",
              @"$height = sqrt(pow($lateralSurfaceArea, 2)-pow($base, 4))/(2*$base)",
              
              // Surface Area
              @"$surfaceArea = $lateralSurfaceArea + $baseArea",
              @"$baseArea = $surfaceArea - $lateralSurfaceArea",
              @"$lateralSurfaceArea = $surfaceArea - $baseArea",
              
              // Slant Height
              @"$slantHeight = sqrt(pow($base/2, 2)  +  pow($height, 2))",
              @"$base = 2*sqrt(pow($slantHeight, 2)  -  pow($height, 2))",
              @"$height = sqrt(pow($slantHeight, 2)  -  pow($base/2, 2))",
              
              // Lateral Edge
              @"$lateralEdge = sqrt(pow($base/2, 2) + pow($slantHeight, 2))",
              @"$base = 2 * sqrt(pow($lateralEdge, 2) - pow($slantHeight, 2))",
              @"$slantHeight = sqrt(pow($lateralEdge, 2) - pow($base/2, 2))",
              
              @"$base = sqrt(2)*sqrt(pow($lateralEdge, 2) - pow($height, 2))",
              
              // Slant Angle
              @"$slantAngle = asin($height/$slantHeight)",
              @"$slantAngle = acos($base/2/$slantHeight)",
              
              @"$height = sin($slantAngle) * $slantHeight",
              @"$slantHeight = $height / sin($slantAngle)",
              @"$slantHeight = $base / (2 * cos($slantAngle))",
              @"$base = 2*cos($slantAngle) * $slantHeight",
              
              // Lateral Edge Angle
              @"$lateralEdgeAngle = asin($height/$lateralEdge)",
              @"$lateralEdgeAngle = acos(($base/2*sqrt(2))/$lateralEdge)",
              
              ];
}

@end
