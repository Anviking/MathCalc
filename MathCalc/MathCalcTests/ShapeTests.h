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
@try { \
id b1 = (a1);\
id b2 = (a2);\
id a1value = [self.formatter stringFromNumber:b1]; \
id a2value = [self.formatter stringFromNumber:b2]; \
if ((a1value != a2value) && ![a1value isEqual:a2value]) { \
_XCTRegisterFailure(_XCTFailureDescription(_XCTAssertion_EqualObjects, 0, @#a1, @#a2, a1value, a2value),format); \
} \
} \
@catch (NSException *exception) { \
_XCTRegisterFailure(_XCTFailureDescription(_XCTAssertion_EqualObjects, 1, @#a1, @#a2, [exception reason]),format); \
} \
@catch (...) { \
_XCTRegisterFailure(_XCTFailureDescription(_XCTAssertion_EqualObjects, 2, @#a1, @#a2),format); \
} \
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
