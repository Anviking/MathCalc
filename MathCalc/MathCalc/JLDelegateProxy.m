//
//  JLDelegateProxy.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-12.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "JLDelegateProxy.h"

@implementation JLDelegateProxy

- (id)initWithDelegate:(id)delegate
{
    if(self) {
        if(!delegate) {
            NSException *exception = [NSException exceptionWithName:@"InvalidArgumentException" reason:@"Cannot create an SDDelegateProxy of a nil-delegate." userInfo:nil];
            @throw exception;
        }
        _delegate = delegate;
    }
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    // Let's ask the delegate
    return [self.delegate respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    // Just ask the delegate
    return [self.delegate methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    // Only attempt to forward the invocation if the delegate has implemented the method
    if([self.delegate respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.delegate];
    }
}

@end
