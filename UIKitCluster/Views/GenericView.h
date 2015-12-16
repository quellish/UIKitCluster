//
//  GenericView.h
//  UIKitCluster
//
//  Created by Dan Zinngrabe on 3/31/15.
//  Copyright (c) 2015 Dan Zinngrabe. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface GenericView : UIView
@property (nonatomic, readwrite, copy)  IBInspectable   NSString    *text;

@end
