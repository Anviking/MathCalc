//
//  PyramidTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-07.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "ShapeTests.h"
#import "Pyramid.h"

@interface PyramidTests : ShapeTests

@end

@implementation PyramidTests

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
    Pyramid *pyramid = (Pyramid *)[self standardShape];
    
    XCTAssertEqualObjects([self.formatter stringFromNumber:pyramid.base], @"20", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:pyramid.baseArea], @"400", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:pyramid.height], @"10", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:pyramid.surfaceArea], @"965.6854", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:pyramid.lateralSurfaceArea], @"565.6854", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:pyramid.volume], @"1333.3333", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:pyramid.slantHeight], @"14.1421", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:pyramid.lateralEdge], @"17.3205", @""); // Validate this value
    XCTAssertEqualObjects([self.formatter stringFromNumber:pyramid.lateralEdgeAngle], @"11.21", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:pyramid.slantAngle], @"11.21", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:pyramid.vertexAngle], @"11.21", @"");
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
    return [Pyramid class];
}

- (Shape *)standardShape
{
    Pyramid *pyramid = [Pyramid new];
    pyramid.height = @10;
    pyramid.base = @20;
    
    [pyramid calculate];
    return pyramid;
}

@end
