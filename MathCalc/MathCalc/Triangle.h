//
//  Triangle.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-19.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Shape.h"

@interface Triangle : Shape

@property (nonatomic, strong) NSNumber *sideA;
@property (nonatomic, strong) NSNumber *sideB;
@property (nonatomic, strong) NSNumber *sideC;

@property (nonatomic, strong) NSNumber *angleA;
@property (nonatomic, strong) NSNumber *angleB;
@property (nonatomic, strong) NSNumber *angleC;

@property (nonatomic, strong) NSNumber *area;
@property (nonatomic, strong) NSNumber *perimeter;

@end
