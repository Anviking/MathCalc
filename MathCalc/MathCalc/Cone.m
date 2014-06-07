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
    return @[ @[ @"height", @"radius", @"diameter", @"side", @"circumference" ],
              @[ @"baseArea", @"mantleArea", @"surfaceArea" ],
              @[ @"volume"]];
}

- (NSArray *)formulaStrings {
    return @[ // Volume
             @"$volume = $baseArea * $height / 3",
             @"$baseArea = pi*$radius**2"];
}

@end
