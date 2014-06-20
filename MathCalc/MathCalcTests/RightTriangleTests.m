//
//  RightTriangleTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShapeTests.h"
#import "RightTriangle.h"

@interface RightTriangleTests : ShapeTests
@end

@implementation RightTriangleTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStandardTriangle
{
    RightTriangle *triangle = (RightTriangle *)[self standardShape];
    
    XCTAssertEqualNumbers(triangle.height, @4);
    XCTAssertEqualNumbers(triangle.base, @3);
    XCTAssertEqualNumbers(triangle.hypotenuse, @5);
    XCTAssertEqualNumbers(triangle.area, @6);
    XCTAssertEqualNumbers(triangle.circumference, @12);
    XCTAssertEqualNumbers(triangle.angleA, @53.1301);
    XCTAssertEqualNumbers(triangle.angleB, @36.8699);
}

- (void)testAllCombinations
{
    [self validateCombinations];
}

- (void)testFormulas
{
    [self validateFormulas];
}

- (NSArray *)knownInvalidCombinations
{
    return @[ @"angleA and angleB",
              @"circumference and hypotenuse",
              @"circumference and area",
              @"area and hypotenuse"];
}

#pragma mark - Data

- (RightTriangle *)standardShape
{
    RightTriangle *triangle = [RightTriangle new];
    triangle.height = @4;
    triangle.area = @6;
    
    [triangle calculate];
    
    return triangle;
}

- (Class)shapeClass
{
    return [RightTriangle class];
}

@end
