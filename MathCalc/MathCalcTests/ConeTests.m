//
//  ConeTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-05-18.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "ShapeTests.h"
#import "Cone.h"

@interface ConeTests : ShapeTests

@end

@implementation ConeTests

- (void)testStandardShape
{
     Cone *cone = (Cone *)[self standardShape];
    
    XCTAssertEqualNumbers(cone.radius, @10);
    XCTAssertEqualNumbers(cone.height, @50);
}

- (void)testAllCombinations
{
    [self validateCombinationsWithDimensions:2];
}

- (void)testFormulas
{
    [self validateFormulas];
}

#pragma mark - Data

- (Class)shapeClass
{
    return [Cone class];
}

- (Shape *)standardShape
{
    Cone *cone = [Cone new];
    cone.radius = @10.0f;
    cone.height = @50.0f;
    
    [cone calculate];
    return cone;
}

@end
