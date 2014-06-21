//
//  VolumeFormatter.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-20.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "VolumeFormatter.h"

@implementation VolumeFormatter

+ (NSArray *)formatterUnits
{
    return @[ @"", @"m³", @"dm³", @"cm³", @"mm³", @"ft³", @"US Gallons"];
}

+ (NSDictionary *)formatterUnitFactors
{
    return @{ @"" : @1,
              @"m³" : @1,
              @"dm³" : @1000,
              @"cm³" : @1000000,
              @"mm³": @1000000000,
              @"ft³" : @35.3146667,
              @"US Gallons" : @264.172052};
}

@end
