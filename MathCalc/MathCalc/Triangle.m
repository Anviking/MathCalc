//
//  Triangle.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-19.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Triangle.h"

@implementation Triangle

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"Triangle";
        self.minimumNumberOfAttributesRequired = 3;
    }
    return self;
}

- (NSString *)descriptionForAttribute:(NSString *)attribute
{
    NSArray *array = @[@"sideA", @"sideB", @"sideC", @"angleA", @"angleB", @"angleC" ];
    if ([array containsObject:attribute]) {
        return NSLocalizedString([attribute stringByAppendingString:@".description"], @"");
    }
    return nil;
}

+ (NSArray *)helpImageTitles
{
    return @[@"angles", @"sides"];
}

+ (NSArray *)groupedAttributes
{
    return @[ @[ @"sideA", @"sideB", @"sideC" ],
              @[ @"angleA", @"angleB", @"angleC" ],
              @[ @"area", @"perimeter"]];
}

- (NSDictionary *)formulaSubstitutions {
    return @{ @"a" : @"$sideA",
              @"b" : @"$sideB",
              @"c" : @"$sideC",
              @"A" : @"$angleA",
              @"B" : @"$angleB",
              @"C" : @"$angleC",
              @"P" : @"$perimeter",
              @"S" : @"$area" };
}

- (NSArray *)formulaStrings
{
    return @[ @"$perimeter = $sideA + $sideB + $sideC",
              @"$sideA = $perimeter - $sideB - $sideC",
              @"$sideB = $perimeter - $sideA - $sideC",
              @"$sideC = $perimeter - $sideA - $sideB",
              
              @"$angleA = 180 - $angleB - $angleC",
              @"$angleB = 180 - $angleA - $angleC",
              @"$angleC = 180 - $angleB - $angleA",
              
              @"$area = $sideB*$sideC*sin($angleA)/2",
              @"$area = $sideA*$sideB*sin($angleC)/2",
              @"$area = $sideC*$sideA*sin($angleB)/2",
              
              @"$sideA = $sideC sin($angleA) csc($angleC)",
              @"$sideB = $sideC sin($angleB) csc($angleC)",
              @"$sideC = $sideA sin($angleC) csc($angleA)",
              
              
              @"$angleA = acos((-pow($sideA,2)+pow($sideB,2)+pow($sideC,2))/(2 $sideB $sideC))",
              @"$angleB = acos((-pow($sideB,2)+pow($sideC,2)+pow($sideA,2))/(2 $sideC $sideA))",
              @"$angleC = acos((-pow($sideC,2)+pow($sideA,2)+pow($sideB,2))/(2 $sideA $sideB))",
              
              // SAS
              @"$sideA = sqrt(pow($sideB,2)+pow($sideC,2)-2*$sideB*$sideC*cos($angleA))",
              @"$sideB = sqrt(pow($sideC,2)+pow($sideA,2)-2*$sideC*$sideA*cos($angleB))",
              @"$sideC = sqrt(pow($sideA,2)+pow($sideB,2)-2*$sideA*$sideB*cos($angleC))",
              
              // ASA
              @"sideA = $sideC * sin($angleA) / sin($angleC)",
              @"sideB = $sideA * sin($angleB) / sin($angleA)",
              @"sideC = $sideB * sin($angleC) / sin($angleB)",
              
              @"$sideA = sqrt(-2 sqrt(pow($sideB,2) pow($sideC,2)-4 pow($area,2))+pow($sideB,2)+pow($sideC,2))",
              @"$sideB = sqrt(-2 sqrt(pow($sideC,2) pow($sideA,2)-4 pow($area,2))+pow($sideC,2)+pow($sideA,2))",
              @"$sideC = sqrt(-2 sqrt(pow($sideA,2) pow($sideB,2)-4 pow($area,2))+pow($sideA,2)+pow($sideB,2))",
              
              @"$sideA = sqrt(pow(csc($angleB),2) (pow($sideB,2) pow(sin($angleB),2)-sqrt(pow(sin($angleB),2) (pow($sideB,4) pow(sin($angleB),2)+8 pow($sideB,2) $area sin($angleB) cos($angleB)+16 pow($area,2) pow(cos($angleB),2)-16 pow($area,2)))+4 $area sin($angleB) cos($angleB)))/sqrt(2)",
              @"$sideA = sqrt(pow(csc($angleC),2) (pow($sideC,2) pow(sin($angleC),2)-sqrt(pow(sin($angleC),2) (pow($sideC,4) pow(sin($angleC),2)+8 pow($sideC,2) $area sin($angleC) cos($angleC)+16 pow($area,2) pow(cos($angleC),2)-16 pow($area,2)))+4 $area sin($angleC) cos($angleC)))/sqrt(2)",
              @"$sideC = sqrt(pow(csc($angleA),2) (pow($sideA,2) pow(sin($angleA),2)-sqrt(pow(sin($angleA),2) (pow($sideA,4) pow(sin($angleA),2)+8 pow($sideA,2) $area sin($angleA) cos($angleA)+16 pow($area,2) pow(cos($angleA),2)-16 pow($area,2)))+4 $area sin($angleA) cos($angleA)))/sqrt(2)",
              
              ];
}

/*
-(void)drawRect:(CGRect)rect
{
    rect = CGRectInset(rect, 5, 5);
    CGFloat a = self.sideA.floatValue;
    CGFloat b = self.sideA.floatValue;
    CGFloat c = self.sideA.floatValue;
    
    CGFloat angleA = self.angleA.floatValue;
    CGFloat angleB = 180-self.angleB.floatValue;
    CGFloat angleC = angleB + self.angleC.floatValue;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, self.bounds);

    if (a*b*c*angleA*angleB*angleC > 0) {
        
        CGPoint A = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxX(rect));
        CGPoint B = pointOffsetFromPoint(A, c, 0.0);
        CGPoint C = pointOffsetFromPoint(B, a, angleB);
        
        CGFloat width = MAX(B.x, C.x) - A.x;
        CGFloat height = A.y - C.y;
        CGFloat scale = rect.size.width / MAX(width, height);
        
        B = pointOffsetFromPoint(A, c * scale, 0.0);
        C = pointOffsetFromPoint(B, a * scale, angleB);
        CGPoint D = pointOffsetFromPoint(C, b * scale, angleC);
        
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, A.x, A.y);
        CGContextAddLineToPoint(ctx, B.x, B.y);
        CGContextAddLineToPoint(ctx, C.x, C.y);
        CGContextAddLineToPoint(ctx, D.x, D.y);
        //CGContextClosePath(ctx);
        
        CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
        CGContextSetLineWidth(ctx, 2.0);
        CGContextStrokePath(ctx);
    }
}
*/
CGPoint pointOffsetFromPoint(CGPoint point, CGFloat offset, CGFloat degrees)
{
    CGFloat radians = degrees * M_PI / 180.0;
    CGFloat deltaX = cosf(radians) * offset;
    CGFloat deltaY = -sinf(radians) * offset;
    return CGPointMake(point.x + deltaX, point.y + deltaY);
}

@end
