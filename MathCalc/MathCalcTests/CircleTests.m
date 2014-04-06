//
//  CircleTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Circle.h"

@interface CircleTests : XCTestCase
@property (nonatomic, strong) NSNumberFormatter *formatter;
@end

@implementation CircleTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.formatter = [[NSNumberFormatter alloc] init];
    [self.formatter setMaximumFractionDigits:4];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCalculatingWithArea
{
    Circle *circle = [Circle new];
    circle.area = @10;
    
    [circle calculate];
    
    XCTAssertEqualObjects([self.formatter stringFromNumber:circle.area], @"10", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:circle.radius], @"1.7841", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:circle.diameter], @"3.5682", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:circle.circonference], @"11.21", @"");

    NSLog(@"Circle: %@",circle);
}

@end