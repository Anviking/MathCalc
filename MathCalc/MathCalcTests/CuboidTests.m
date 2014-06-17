//
//  CuboidTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-05-18.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "ShapeTests.h"
#import "Cuboid.h"

@interface CuboidTests : ShapeTests

@end

@implementation CuboidTests

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
    Cuboid *cuboid = (Cuboid *)[self standardShape];
    
    XCTAssertEqualNumbers(cuboid.width, @10);
    XCTAssertEqualNumbers(cuboid.height, @100);
    XCTAssertEqualNumbers(cuboid.length, @30);
    XCTAssertEqualNumbers(cuboid.volume, @30000);
    XCTAssertEqualNumbers(cuboid.surfaceArea, @8600);
}

- (void)testAllCombinations
{
    [self validateCombinationsWithDimensions:3];
}

- (void)testFormulas
{
    [self validateFormulas];
}

- (NSArray *)knownInvalidCombinations
{
    return @[ @"volume and surfaceArea and spaceDiagonal" ];
}

#pragma mark - Data

- (Class)shapeClass
{
    return [Cuboid class];
}

- (Shape *)standardShape
{
    Cuboid *cuboid = [Cuboid new];
    cuboid.width = @10.0f;
    cuboid.height = @100.0f;
    cuboid.length = @30.0f;
    
    [cuboid calculate];
    return cuboid;
}

@end
