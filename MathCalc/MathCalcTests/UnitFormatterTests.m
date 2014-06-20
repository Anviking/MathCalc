//
//  UnitFormatterTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-20.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <XCTest/XCTest.h>
@import MathCore;

@interface UnitFormatterTests : XCTestCase

@end

@implementation UnitFormatterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDefaultFormatter {
    // This is an example of a functional test case.
    
    [LengthFormatter setDefaultFormatter:nil];
    [NSUserDefaults resetStandardUserDefaults];

    
    XCTAssertNil([LengthFormatter defaultFormatter], @"Default Formatter Should Be nil");
    XCTAssertEqualObjects([LengthFormatter numberFromString:@"10"], @10, @"Default formatter should be nil");
    XCTAssertEqualObjects([LengthFormatter stringFromNumber:@10], @"10", @"Default formatter should be nil");
    
    [LengthFormatter setDefaultFormatter:[LengthFormatter formatterWithUnit:@"cm"]];

}

- (void)testCentimeters {
    XCTAssertEqualObjects([LengthFormatter numberFromString:@"5+5"], @0.1, @"Centimeters");
    XCTAssertEqualObjects([LengthFormatter stringFromNumber:@0.1], @"10", @"Centimeters");
}


@end
