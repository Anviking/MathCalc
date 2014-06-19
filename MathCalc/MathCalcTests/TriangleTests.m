//
//  TriangleTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-19.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "ShapeTests.h"

@interface TriangleTests : ShapeTests

@end

@implementation TriangleTests

- (void)testStandardShape
{
    Triangle *triangle = (Triangle *)[self standardShape];
    
    XCTAssertEqualNumbers(triangle.sideA, @30);
    XCTAssertEqualNumbers(triangle.sideB, @80);
    XCTAssertEqualNumbers(triangle.sideC, @60);
    XCTAssertEqualNumbers(triangle.area, @764.4442);
    XCTAssertEqualNumbers(triangle.perimeter, @170);
    XCTAssertEqualNumbers(triangle.angleA, @18.5733);
    XCTAssertEqualNumbers(triangle.angleB, @121.8554);
    XCTAssertEqualNumbers(triangle.angleC, @39.5712);
}

- (void)testAllCombinations
{
    [self validateCombinationsWithDimensions:3];
}

- (void)testFormulas
{
    [self validateFormulas];
}

#pragma mark - Data

- (Class)shapeClass
{
    return [Triangle class];
}

- (Shape *)standardShape
{
    Triangle *triangle = [Triangle new];
    triangle.sideA = @30.0f;
    triangle.sideB = @80.0f;
    triangle.sideC = @60.0f;
    
    [triangle calculate];
    
    return triangle;
}
@end
