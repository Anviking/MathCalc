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
    
    XCTAssertEqualNumbers(pyramid.base, @20);
    XCTAssertEqualNumbers(pyramid.baseArea, @400);
    XCTAssertEqualNumbers(pyramid.height, @10);
    XCTAssertEqualNumbers(pyramid.surfaceArea, @965.6854);
    XCTAssertEqualNumbers(pyramid.lateralSurfaceArea, @565.6854);
    XCTAssertEqualNumbers(pyramid.volume, @1333.3333);
    XCTAssertEqualNumbers(pyramid.slantHeight, @14.1421);
    XCTAssertEqualNumbers(pyramid.lateralEdge, @17.3205); // Validate this value
    XCTAssertEqualNumbers(pyramid.lateralEdgeAngle, @35.2644); // Validate
    XCTAssertEqualNumbers(pyramid.slantAngle, @45); // Validate
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
    return @[ @"slantAngle and lateralEdgeAngle",
              @"slantHeight and volume",
              @"volume and lateralEdge",
              @"base and baseArea",
              @"volume and lateralSurfaceArea",
              @"lateralSurfaceArea and lateralEdgeAngle" ];
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
