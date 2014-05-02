//
//  CircleTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShapeTests.h"
#import "Circle.h"

@interface CircleTests : ShapeTests
@end

@implementation CircleTests

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
    Circle *circle = (Circle *)[self standardShape];
    
    XCTAssertEqualObjects(@"10", [self.formatter stringFromNumber:@10], @"");
//    XCTAssertEqualObjects([circle.area floatValue], , @"");
    XCTAssertNotNil(self.formatter, @"self.formatter should not be nil");
    XCTAssertEqualObjects([self.formatter stringFromNumber:circle.area], [self.formatter stringFromNumber:@10], @"");
        XCTAssertEqualNumbers(@10, @10);
    XCTAssertEqualNumbers([circle area], @10);
    XCTAssertEqualNumbers(circle.radius, @1.7841);
    XCTAssertEqualNumbers(circle.diameter, @3.5682);
    XCTAssertEqualNumbers(circle.circumference, @11.21);
}

/*
- (void)testThis
{
    id a1 = @0;
    id a2 = @0;
    
    NSString *keyPath = @"circle.area".
    
    id a = [self.formatter stringFromNumber:a1];
    id b = [self.formatter stringFromNumber:a2];
    XCTAssertEqualObjects(a, b, @"Format");
}
 */

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
    return [Circle class];
}

- (Shape *)standardShape
{
    Circle *circle = [Circle new];
    circle.area = @10;
    
    [circle calculate];
    return circle;
}

@end
