//
//  GreenView.m
//  Whatever
//
//  Created by Flip Sasser on 3/7/13.
//  Copyright (c) 2013 Logline. All rights reserved.
//

#import "GreenView.h"

@implementation GreenView

- (void)drawRect:(NSRect)dirtyRect {
  [[NSColor greenColor] setFill];
  NSRectFill(dirtyRect);
}

@end
