//
//  StackableView.m
//  Logline
//
//  Created by Flip Sasser on 3/5/13.
//  Copyright (c) 2013 Parker Wallace Company. All rights reserved.
//

#import "StackableView.h"

@interface StackableView ()

@property NSLayoutConstraint *endConstraint;

- (BOOL)setHeightConstraintForSubview:(NSView *)view;
- (void)removeEndConstraint;
- (void)resetEndConstraint:(NSView *)removedView;

@end

@implementation StackableView

@synthesize endConstraint;

# pragma mark Drawing
- (void)addSubview:(NSView *)view {
  view.translatesAutoresizingMaskIntoConstraints = NO;
  [super addSubview:view];
  
  // Expand the subview width to the superview width
  NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
  [self addConstraint:widthConstraint];

  // Anchor to the appropriate vertical position: either the top of this view
  // (first child) or the bottom of the previous view (subsequent children)
  NSLayoutConstraint *topConstraint;
  if (self.subviews.count == 1) {
    // Anchor the first subview to the top of this view
    topConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
  } else {
    // Anchor subsequent subviews to the bottom of the next-youngest sibling
    NSView *previousView = [self.subviews objectAtIndex:self.subviews.count - 2];
    topConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
  }
  [self addConstraint:topConstraint];

  // Observe subview size changes to redraw its constraints
  [view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionInitial context:nil];
}

- (void)drawRect:(NSRect)dirtyRect {
  [[NSColor yellowColor] setFill];
  NSRectFill(dirtyRect);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if ([self setHeightConstraintForSubview:object]) {
    [self resetEndConstraint:nil];
  }
}

- (void)willRemoveSubview:(NSView *)view {
  [view removeObserver:self forKeyPath:@"frame"];
  [self resetEndConstraint:view];
}

# pragma mark Utilities
- (void)removeEndConstraint {
//  if (self.endConstraint) {
//    [self removeConstraint:self.endConstraint];
//    self.endConstraint = nil;
//  }

  if (self.superview) {
    // Also, since our endConstraint is no longer valid, our superview's height constraint is also invalid
    // So remove it!
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
      if (constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeHeight) {
//        [self.superview removeConstraint:constraint];
      }
    }
  }
}

- (void)resetEndConstraint:(NSView *)removedView {
  [self removeEndConstraint];

  // If we're not removing a view (e.g. we care only so long as there's one subview),
  // or if we're removing one and there will be at least one left, figure out which
  // remaining view will be at the end so we can anchor the bottom edge to *it*
  if (!removedView || self.subviews.count > 1) {
    NSView *lastView = [self.subviews lastObject];
    long lastIndex = self.subviews.count - 1;
    while (lastView == removedView && lastIndex > 0) {
      lastIndex -= 1;
      lastView = [self.subviews objectAtIndex:lastIndex];
    }
    
    NSLog(@"Anchoring to %@", lastView);

    self.endConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:lastView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraint:self.endConstraint];
  }

  // Set the frame size to whatever it thinks it should be at this point
  [self setFrameSize:self.fittingSize];
}

- (BOOL)setHeightConstraintForSubview:(NSView *)view {
  CGFloat height = view.frame.size.height;
  
  // Remove previous height constraint on this view
  for (NSLayoutConstraint *constraint in self.constraints) {
    // Find any height constraints already applied to the item
    if (constraint.firstItem == view && constraint.firstAttribute == NSLayoutAttributeHeight) {
      if (constraint.constant != height) {
        // Remove the old constraint if the height is different
        [self removeConstraint:constraint];
        break;
      } else {
        // Exit since we don't need a new constraint and don't want to mess w/layout
        return NO;
      }
    }
  }

  // Remove the old end constraint to prevent issues w/the new height
  [self removeEndConstraint];

  // Set the height constraint to the view's current frame height
  NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:height];
  [self addConstraint:heightConstraint];
  return YES;
}

# pragma mark Teardown
- (void)dealloc {
  for (NSView *view in self.subviews) {
    [view removeObserver:self forKeyPath:@"frame"];
  }
  [super dealloc];
}
@end
