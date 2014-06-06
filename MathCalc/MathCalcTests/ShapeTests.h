//
//  ShapeTests.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-07.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Shape.h"

#define XCTAssertEqualNumbers(a1, a2, format...) \
({ \
id b1 = (a1);\
id b2 = (a2);\
id a1value = [self.formatter stringFromNumber:b1]; \
id a2value = [self.formatter stringFromNumber:b2]; \
XCTAssertEqualObjects(a1value, a2value, format); \
})



@interface ShapeTests : XCTestCase

- (Shape *)standardShape;
- (Class)shapeClass;

- (void)validateCombinationsWithDimensions:(NSInteger)dimensions;
- (void)validateFormulas;

- (NSArray *)knownInvalidCombinations;

@property (nonatomic, strong) NSNumberFormatter *formatter;
@property (nonatomic, strong) NSDictionary *standardValues;

@end
