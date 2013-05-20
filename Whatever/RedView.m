//
//  RedView.m
//  Whatever
//
//  Created by Flip Sasser on 3/7/13.
//  Copyright (c) 2013 Logline. All rights reserved.
//

#import "RedView.h"

@implementation RedView

- (void)mouseUp:(NSEvent *)theEvent {
  [self removeFromSuperview];
}

- (void)drawRect:(NSRect)dirtyRect {
  [[NSColor redColor] setFill];
  NSRectFill(dirtyRect);
}

@end
