//
//  Circle.h
//  MathCalc
//
//  Created by Johannes Lund on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Shape.h"

@interface Circle : Shape

//Shape information
@property (nonatomic, strong) NSNumber *radius;
@property (nonatomic, strong) NSNumber *diameter;
@property (nonatomic, strong) NSNumber *circonference;
@property (nonatomic, strong) NSNumber *area;

@end
