//
//  Cylinder.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-09.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <MathCore/MathCore.h>

@interface Cylinder : Shape

@property (nonatomic, strong) NSNumber *radius;
@property (nonatomic, strong) NSNumber *circumference;
@property (nonatomic, strong) NSNumber *diameter;
@property (nonatomic, strong) NSNumber *baseArea;
@property (nonatomic, strong) NSNumber *mantleArea;
@property (nonatomic, strong) NSNumber *surfaceArea;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *volume;

@end
