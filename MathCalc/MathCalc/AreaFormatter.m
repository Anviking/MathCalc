//
//  AreaFormatter.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-20.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "AreaFormatter.h"

@implementation AreaFormatter

+ (NSArray *)formatterUnits
{
    return @[ @"", @"m²", @"dm²", @"cm²", @"mm²", @"ft²"];
}

+ (NSDictionary *)formatterUnitFactors
{
    return @{ @"" : @1,
              @"m²" : @1,
              @"dm²" : @100,
              @"cm²" : @10000,
              @"mm²": @1000000,
              @"ft²" : @10.7639104};
}

@end
