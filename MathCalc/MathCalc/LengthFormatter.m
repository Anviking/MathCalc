//
//  LengthFormatter.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-20.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "LengthFormatter.h"

@implementation LengthFormatter

+ (NSArray *)formatterUnits
{
    return @[@"", @"m", @"dm", @"cm", @"mm"];
}

+ (NSDictionary *)formatterUnitFactors
{
    return @{ @"" : @1,
              @"m" : @1,
              @"dm" : @10,
              @"cm" : @100,
              @"mm": @1000 };
}

@end
