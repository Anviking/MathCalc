//
//  ShapeTests.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-07.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Shape.h"

@interface ShapeTests : XCTestCase

- (Shape *)standardShape;
- (Class)shapeClass;

- (void)validateCombinationsWithDimensions:(NSInteger)dimensions;
- (void)validateFormulas;

- (NSArray *)knownInvalidCombinations;

@property (nonatomic, strong) NSNumberFormatter *formatter;
@property (nonatomic, strong) NSDictionary *standardValues;

@end
