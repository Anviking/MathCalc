//
//  Circle.m
//  MathCalc
//
//  Created by Johannes Lund on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Circle.h"

@implementation Circle

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"Circle";
        self.minimumNumberOfAttributesRequired = 1;
    }
    return self;
}

+ (NSArray *)attributes
{
    return @[ @"radius",
              @"diameter",
              @"circumference",
              @"area" ];
}

- (NSArray *)formulaStrings {
    return @[ @"$diameter = 2 * $radius",
              @"$area = pi * pow($radius, 2)",
              @"$circumference = $diameter * pi",
              
              @"$radius = $diameter / 2",
              @"$radius = sqrt($area / pi)",
              @"$radius = ($circumference /pi) / 2"];
}

@end
