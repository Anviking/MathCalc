//
//  JLDelegateProxy.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-12.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLDelegateProxy : NSProxy

@property (readonly, weak, nonatomic) id delegate;

- (id)initWithDelegate:(id)delegate;

@end
