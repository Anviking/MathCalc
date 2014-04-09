//
//  SphereTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-07.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "ShapeTests.h"
#import "Sphere.h"

@interface SphereTests : ShapeTests

@end

@implementation SphereTests

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

- (void)testStandardShape
{
    Sphere *sphere = (Sphere *)[self standardShape];
    
    XCTAssertEqualObjects([self.formatter stringFromNumber:sphere.area], @"1256.6371", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:sphere.radius], @"10", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:sphere.diameter], @"20", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:sphere.circumference], @"62.8319", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:sphere.volume], @"4188.7902", @"");
}

- (void)testAllCombinations
{
    [self validateCombinationsWithDimensions:1];
}

- (void)testFormulas
{
    [self validateFormulas];
}

#pragma mark - Data

- (Class)shapeClass
{
    return [Sphere class];
}

- (Shape *)standardShape
{
    Sphere *sphere = [Sphere new];
    sphere.radius = @10;
    
    [sphere calculate];
    return sphere;
}

@end
