//
//  GenericView.m
//  UIKitCluster
//
//  Created by Dan Zinngrabe on 3/31/15.
//  Copyright (c) 2015 Dan Zinngrabe. All rights reserved.
//

#import "GenericView.h"
@import Darwin.libkern.OSAtomic;
@import ObjectiveC;

@interface GenericView (){
    @private
    dispatch_once_t initializationToken;
}
@property (nonatomic, readwrite, strong)      IBOutlet    UILabel *textLabel __attribute__((visibility("internal")));
@property (nonatomic, readwrite, strong)      IBOutlet    UIView  *containerView __attribute__((visibility("internal")));
@end

@implementation GenericView
@dynamic text;
@synthesize textLabel;
@synthesize containerView;

-(id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])){
        [self initalizeSubviews];
        OSMemoryBarrier();
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])){
        [self initalizeSubviews];
        OSMemoryBarrier();
    }
    return self;
}

- (void) initalizeSubviews {
    dispatch_once(&initializationToken, ^{
        NSArray     *nibItems   = nil;
        NSString    *nibName    = NSStringFromClass([self class]);
        UINib       *nib        = [UINib nibWithNibName:nibName bundle:[NSBundle bundleForClass:[self class]]];
        nibItems = [nib instantiateWithOwner:self options:nil];
        //Add the view loaded from the nib into self.
        [self setContainerView:[nibItems firstObject]];
        if ([self containerView] != nil){
            [[self containerView] setFrame:[self bounds]];
            [self addSubview:[self containerView] ];
        }
    });
}

#if TARGET_INTERFACE_BUILDER
- (void)prepareForInterfaceBuilder {
    [self initalizeSubviews];
}
#endif

- (void) setText:(NSString *)text {
    [[self textLabel] setText:[text copy]];
}

- (NSAttributedString *) text {
    return [[[self textLabel] text] copy];
}

 
#pragma mark Trampoline

const char * kTrampolineClassNameString = "GenericViewTrampoline";
const char * kClusterClassNameString    = "GenericView";

// Automatic Reference Counting
+ (id) allocWithZone:(struct _NSZone *) zone {
    id      result  = nil;
    Class   clusterClass        = NULL;
    Class   trampolineClass     = NULL;
    
    clusterClass = objc_lookUpClass(kClusterClassNameString);
    if(self == clusterClass){
        static dispatch_once_t  onceToken    = 0L;
        static id               trampoline   = NULL;
        
        trampolineClass = objc_lookUpClass(kTrampolineClassNameString);
        dispatch_once(&onceToken, ^{
            trampoline = [trampolineClass alloc];
        });
        result = trampoline;
    } else {
        result = [super allocWithZone:zone];
    }
    return result;
}


@end
