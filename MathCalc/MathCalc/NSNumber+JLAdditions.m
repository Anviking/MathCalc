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
+ (void)initialize
{
    formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:4];
}

+ (NSNumberFormatter *)numberFormatter
{
    return formatter;
}

- (NSString *)string
{
    return [formatter stringFromNumber:self];
}

@end
