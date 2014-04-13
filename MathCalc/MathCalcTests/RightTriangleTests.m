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
    RightTriangle *triangle = [RightTriangle new];
    triangle.base = @3;
    triangle.height = @4;
    
    [triangle defineAttribute:@"base"];
    [triangle defineAttribute:@"height"];
    
    [triangle calculate];
    
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.height], @"4", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.base], @"3", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.hypotenuse], @"5", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.area], @"6", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.circumference], @"12", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.angleA], @"53.1301", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.angleB], @"36.8699", @"");
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
