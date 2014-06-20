//
//  AngleFormatter.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-20.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "AngleFormatter.h"

@implementation AngleFormatter

+ (NSArray *)formatterUnits
{
    return @[ @"°", @"rad"];
}

+ (NSDictionary *)formatterUnitFactors
{
    return @{ @"°" : @1,
              @"rad" : @(M_PI / 180 ) };
}

@end
