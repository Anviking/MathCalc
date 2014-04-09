//
//  Pyramid.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-07.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Shape.h"

@interface Pyramid : Shape

@property (nonatomic, strong) NSNumber *base;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *baseArea;
@property (nonatomic, strong) NSNumber *lateralSurfaceArea;
@property (nonatomic, strong) NSNumber *surfaceArea;
@property (nonatomic, strong) NSNumber *volume;
@property (nonatomic, strong) NSNumber *slantHeight;
@property (nonatomic, strong) NSNumber *lateralEdge;
@property (nonatomic, strong) NSNumber *slantAngle;
@property (nonatomic, strong) NSNumber *lateralEdgeAngle;
@property (nonatomic, strong) NSNumber *vertexAngle;
@end
