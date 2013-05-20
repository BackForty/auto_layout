//
//  BlueView.m
//  Whatever
//
//  Created by Flip Sasser on 3/7/13.
//  Copyright (c) 2013 Logline. All rights reserved.
//

#import "BlueView.h"

@implementation BlueView

- (void)mouseUp:(NSEvent *)theEvent {
  int newHeight = self.bounds.size.height;
  while (newHeight == self.bounds.size.height) {
    newHeight = 50 + arc4random_uniform(100);
  }
  CGRect rect = self.frame;
  rect.size.height = newHeight;
  [self setFrame:rect];
}

- (void)drawRect:(NSRect)dirtyRect {
  [[NSColor blueColor] setFill];
  NSRectFill(dirtyRect);
}

@end
