//
//  NSNumber+JLAdditions.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-12.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "NSNumber+JLAdditions.h"

@implementation NSNumber (JLAdditions)

static NSNumberFormatter *formatter;
static NSNumberFormatter *scientificFormatter;
+ (void)initialize
{
    formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:4];
    [formatter setMinimumIntegerDigits:1];
    
    scientificFormatter = [[NSNumberFormatter alloc] init];
    [scientificFormatter setNumberStyle:NSNumberFormatterScientificStyle];
    [scientificFormatter setMaximumFractionDigits:4];
    [scientificFormatter setMinimumIntegerDigits:1];
}

+ (NSNumberFormatter *)numberFormatter
{
    return formatter;
}

- (NSString *)string
{
    if (self.floatValue > 1000000) {
        return [scientificFormatter stringFromNumber:self];
    }
    return [formatter stringFromNumber:self];
}

@end
