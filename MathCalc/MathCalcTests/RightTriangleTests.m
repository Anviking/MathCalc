//
//  RightTriangleTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RightTriangle.h"

@interface RightTriangleTests : XCTestCase
@property (nonatomic, strong) NSNumberFormatter *formatter;
@end

@implementation RightTriangleTests

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
    RightTriangle *triangle = [RightTriangle new];
    triangle.base = @3;
    triangle.height = @4;
    
    [triangle calculate];
    
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.height], @"4", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.base], @"3", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.hypotenuse], @"5", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.area], @"6", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.circonference], @"12", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.angleA], @"53.1301", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.angleB], @"36.8699", @"");
    
    NSLog(@"Triangle: %@",triangle);
}

- (void)testCalculatingWithAreaAndHeight
{
    RightTriangle *triangle = [RightTriangle new];
    triangle.height = @4;
    triangle.area = @6;

    
    [triangle calculate];
    
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.height], @"4", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.base], @"3", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.hypotenuse], @"5", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.area], @"6", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.circonference], @"12", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.angleA], @"53.1301", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.angleB], @"36.8699", @"");
    
    NSLog(@"Triangle: %@",triangle);
}

@end
