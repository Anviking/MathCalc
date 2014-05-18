//
//  Cuboid.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-05-18.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Shape.h"

@interface Cuboid : Shape

@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *length;
@property (nonatomic, strong) NSNumber *spaceDiagonal;
@property (nonatomic, strong) NSNumber *volume;
@property (nonatomic, strong) NSNumber *surfaceArea;

@end
