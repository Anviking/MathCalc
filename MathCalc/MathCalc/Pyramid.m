//
//  Pyramid.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-07.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Pyramid.h"

@implementation Pyramid

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"Square Pyramid";
        self.minimumNumberOfAttributesRequired = 2;
    }
    return self;
}

+ (NSArray *)helpImageTitles
{
    return [self attributes];
}

+ (NSArray *)groupedAttributes
{
    return @[ @[ @"baseEdgeLength", @"height", @"slantHeight", @"lateralEdge", ],
              @[ @"baseArea", @"surfaceArea", @"lateralSurfaceArea" ],
              @[ @"volume" ],
              @[ @"slantAngle", @"lateralEdgeAngle" ]];
}

- (NSArray *)formulaStrings {
    return @[ @"$baseArea = $baseEdgeLength * $baseEdgeLength",
              @"$baseEdgeLength = sqrt($baseArea)",
              
              // Volume
              @"$volume = $baseArea * $height / 3",
              @"$baseArea = $volume / $height * 3",
              @"$height = $volume / $baseArea * 3",
              
              @"$lateralSurfaceArea = $baseEdgeLength * sqrt(pow($baseEdgeLength, 2) + 4*pow($height, 2))",
              @"$baseEdgeLength = sqrt(sqrt(pow($lateralSurfaceArea, 2)+4 pow($height, 4))-2 pow($height, 2))",
              @"$height = sqrt(pow($lateralSurfaceArea, 2)-pow($baseEdgeLength, 4))/(2*$baseEdgeLength)",
              
              @"$lateralSurfaceArea = $baseEdgeLength * $slantHeight * 2",
              @"$baseEdgeLength = $lateralSurfaceArea / (2 * $slantHeight)",
              @"$slantHeight = $lateralSurfaceArea / (2 * $baseEdgeLength)",
              
              // Surface Area
              @"$surfaceArea = $lateralSurfaceArea + $baseArea",
              @"$baseArea = $surfaceArea - $lateralSurfaceArea",
              @"$lateralSurfaceArea = $surfaceArea - $baseArea",
              
              // Slant Height
              @"$slantHeight = sqrt(pow($baseEdgeLength/2, 2)  +  pow($height, 2))",
              @"$baseEdgeLength = 2*sqrt(pow($slantHeight, 2)  -  pow($height, 2))",
              @"$height = sqrt(pow($slantHeight, 2)  -  pow($baseEdgeLength/2, 2))",
              
              // Lateral Edge
              @"$lateralEdge = sqrt(pow($baseEdgeLength/2, 2) + pow($slantHeight, 2))",
              @"$baseEdgeLength = 2 * sqrt(pow($lateralEdge, 2) - pow($slantHeight, 2))",
              @"$slantHeight = sqrt(pow($lateralEdge, 2) - pow($baseEdgeLength/2, 2))",
              
              @"$baseEdgeLength = sqrt(2)*sqrt(pow($lateralEdge, 2) - pow($height, 2))",
              
              // Slant Angle
              @"$slantAngle = asin($height/$slantHeight)",
              @"$slantAngle = acos($baseEdgeLength/2/$slantHeight)",
              
              @"$height = sin($slantAngle) * $slantHeight",
              @"$slantHeight = $height / sin($slantAngle)",
              @"$slantHeight = $baseEdgeLength / (2 * cos($slantAngle))",
              @"$baseEdgeLength = 2*cos($slantAngle) * $slantHeight",
              
              // Lateral Edge Angle
              @"$lateralEdgeAngle = asin($height/$lateralEdge)",
              @"$height = $lateralEdge *sin($lateralEdgeAngle)",
              @"$lateralEdge = $height/sin($lateralEdgeAngle)",
              
              @"$lateralEdgeAngle = acos(($baseEdgeLength/2*sqrt(2))/$lateralEdge)",
              @"$lateralEdge = $baseEdgeLength sec($lateralEdgeAngle) / sqrt(2)",
              @"$baseEdgeLength = sqrt(2) * $lateralEdge * cos($lateralEdgeAngle)",
              
              // Super Mindfuck
              
              @"$baseEdgeLength = sqrt(-(sqrt(2) sqrt(-pow($surfaceArea,2) pow(cos($lateralEdgeAngle),2) (cos(2 $lateralEdgeAngle)-3)))/(cos(2 $lateralEdgeAngle)-1)+($surfaceArea cos(2 $lateralEdgeAngle))/(cos(2 $lateralEdgeAngle)-1)+$surfaceArea/(cos(2 $lateralEdgeAngle)-1))/sqrt(2)",
              @"$height = (pow($surfaceArea,2)-sqrt($surfaceArea (pow($surfaceArea,3)-288 pow($volume,2))))/(24 $volume)",
              @"$baseEdgeLength = sqrt($lateralSurfaceArea)sqrt(cos($slantAngle))",
              @"$slantHeight = (1/2 sqrt(($surfaceArea sec($slantAngle))/(cos($slantAngle)+1)))",
              @"$height = -((pow((6),(1/3)) pow($volume,(4/3)) pow(cos($slantAngle),(4/3)))/pow((1-pow(cos($slantAngle),2)),(2/3))-(pow((6),(1/3)) pow($volume,(4/3)))/(pow(cos($slantAngle),(2/3)) pow((1-pow(cos($slantAngle),2)), (2/3))))/(2 $volume)",
              @"$height = (pow((3/2),(1/3)) pow($volume,(1/3)) pow(sin($lateralEdgeAngle),(2/3)))/pow((1- pow(sin($lateralEdgeAngle),2)),(1/3))",
              @"$baseEdgeLength = sqrt(-sqrt(-pow($surfaceArea,2)+4$surfaceArea pow($lateralEdge,2)+4 pow($lateralEdge,4))+$surfaceArea+2 pow($lateralEdge,2))/sqrt(2)",
              @"$baseEdgeLength = $surfaceArea/sqrt(2*$surfaceArea+4 pow($height,2))",
              @"$baseEdgeLength = sqrt($surfaceArea+pow($slantHeight,2))-$slantHeight",
              @"$height = sqrt(2) sin($lateralEdgeAngle) sqrt(pow($slantHeight,2)/(pow(sin($lateralEdgeAngle),2)+1))",
              @"$baseEdgeLength = sqrt(2 pow($lateralEdge,2)-sqrt(4 pow($lateralEdge,4)-pow($lateralSurfaceArea,2)))",
              
              @"$slantHeight = $lateralEdge/sqrt(pow(cos($slantAngle),2)+1)"
              
              /* FUCK ->
              @"$height = -((1-sqrt(3)) pow(abs(sqrt(3) sqrt(abs(243 pow($volume,2)-64 pow($slantHeight,6)))-27 $volume),(1/3)))/(4 pow(3,(2/3)))-((1+ sqrt(3)) pow($slantHeight,2))/(pow(3,(1/3)) pow(abs(sqrt(3) sqrt(abs(243 pow($volume,2)-64 pow($slantHeight,6)))-27 $volume),(1/3)))",
              @"$height = -((1+sqrt(3)) pow(abs(sqrt(3) sqrt(abs(243 pow($volume,2)-64 pow($slantHeight,6)))-27 $volume),(1/3)))/(4 pow(3,(2/3)))-((1- sqrt(3)) pow($slantHeight,2))/(pow(3,(1/3)) pow(abs(sqrt(3) sqrt(abs(243 pow($volume,2)-64 pow($slantHeight,6)))-27 $volume),(1/3)))",
              @"$height = 0.6*(pow(abs(sqrt(3) sqrt(abs(243 pow($volume,2)-64 pow($slantHeight,6)))-27 $volume),(1/3)))/(2 pow(3,(2/3)))+(2*pow($slantHeight,2))/(pow(3,(1/3)) pow(abs(sqrt(3) sqrt(abs(243 pow($volume,2)-64 pow($slantHeight,6)))-27 $volume),(1/3)))" */ ];
}

@end
