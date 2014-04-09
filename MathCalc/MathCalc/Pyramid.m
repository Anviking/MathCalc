//
//  Pyramid.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-07.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Pyramid.h"

@implementation Pyramid

+ (NSArray *)attributes
{
    return @[ @"base",
              @"height",
              @"baseArea",
              @"surfaceArea",
              @"lateralSurfaceArea",
              @"volume",
              @"slantHeight",
              @"lateralEdge",
              @"slantAngle",
              @"lateralEdgeAngle",
              @"vertexAngle" ];
}

- (NSArray *)formulaStrings {
    return @[ @"$baseArea = $base * $base",
              @"$volume = $baseArea * $height / 3",
              @"$lateralSurfaceArea = $base * sqrt(pow($base, 2) + 4*pow($height, 2))",
              @"$surfaceArea = $lateralSurfaceArea + $baseArea",
              @"$slantHeight = sqrt(pow($base, 2)/4  +  pow($height, 2))",
              @"$lateralEdge = sqrt(pow($base, 2)/4  +  pow($slantHeight, 2))"];
}

@end
