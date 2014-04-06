//
//  Circle.m
//  MathCalc
//
//  Created by Johannes Lund on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Circle.h"

@implementation Circle
@synthesize primitiveFormulas = _primitiveFormulas;

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

- (NSArray *)primitiveFormulaStings
{
    return @[ @"$r = $d / 2",
              @"$r = sqrt($A / pi)",
              @"$r = ($C/pi)/2"];
}

- (NSArray *)formulaStrings
{
    return @[ @"$d = 2 * $r",
              @"$A = pi * pow($r, 2)",
              @"$C = $d * pi"];
}

@end
