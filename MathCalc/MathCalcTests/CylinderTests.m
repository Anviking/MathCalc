//
//  CylinderTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-09.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "ShapeTests.h"

@interface CylinderTests : ShapeTests

@end

@implementation CylinderTests

- (void)testStandardShape
{
    Cylinder *cylinder = (Cylinder *)[self standardShape];
    
    XCTAssertEqualNumbers(cylinder.radius, @10);
    XCTAssertEqualNumbers(cylinder.height, @50);
    XCTAssertEqualNumbers(cylinder.volume, @15707.9633);
    XCTAssertEqualNumbers(cylinder.surfaceArea, @3455.7519);
}

- (void)testAllCombinations
{
    [self validateCombinationsWithDimensions:2];
}

- (void)testFormulas
{
    [self validateFormulas];
}

- (NSArray *)knownInvalidCombinations
{
    return @[ @"diameter and baseArea",
              @"circumference and baseArea",
              @"diameter and radius",
              @"surfaceArea and height",
              @"volume and surfaceArea",
              @"circumference and radius",
              @"baseArea and radius",
              @"diameter and circumference"];
}

#pragma mark - Data

- (Class)shapeClass
{
    return [Cylinder class];
}

- (Shape *)standardShape
{
    Cylinder *cylinder = [Cylinder new];
    cylinder.radius = @10.0f;
    cylinder.height = @50.0f;
    
    [cylinder calculate];
    return cylinder;
}

@end
