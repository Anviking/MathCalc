//
//  Circle.m
//  MathCalc
//
//  Created by Johannes Lund on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Circle.h"

@implementation Circle

- (NSDictionary *)attributeVariables
{
    return @{ @"radius" : @"r",
              @"diameter" : @"d",
              @"circonference" : @"C",
              @"area" : @"A"};
}

- (NSArray *)primitiveAttributes
{
    return @[ @"radius" ];
}

- (NSArray *)formulaStrings
{
    return @[ @"$diameter = 2 * $radius",
              @"$area = pi * pow($radius, 2)",
              @"$circonference = $diameter * pi",
              
              @"$radius = $diameter / 2",
              @"$radius = sqrt($area / pi)",
              @"$radius = ($circonference /pi) / 2"];
}

@end
