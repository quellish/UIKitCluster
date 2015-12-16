//
//  GenericViewTrampoline.m
//  UIKitCluster
//
//  Created by Dan Zinngrabe on 3/31/15.
//  Copyright (c) 2015 Dan Zinngrabe. All rights reserved.
//

#import "GenericViewTrampoline.h"
#import "SpecificView.h"

@implementation GenericViewTrampoline

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (id) initWithFrame:(CGRect)frame {
    return (id)[[SpecificView alloc] initWithFrame:frame];
}
#pragma clang diagnostic pop

- (Class) class {
    return [SpecificView class];
}

- (id) awakeAfterUsingCoder:(NSCoder *)aDecoder {
    return (id)[[SpecificView alloc] initWithCoder:aDecoder];
}

@end
