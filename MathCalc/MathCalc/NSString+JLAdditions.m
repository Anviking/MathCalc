//
//  NSString+JLAdditions.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-07-11.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "NSString+JLAdditions.h"

@implementation NSString (JLAdditions)

- (BOOL)containsString:(NSString *)string {
    return [self rangeOfString:string].location != NSNotFound;
}

@end
