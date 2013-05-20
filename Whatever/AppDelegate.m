//
//  AppDelegate.m
//  Whatever
//
//  Created by Flip Sasser on 3/7/13.
//  Copyright (c) 2013 Logline. All rights reserved.
//

#import "AppDelegate.h"

#import "StackableView.h"

#import "BlueView.h"
#import "GreenView.h"
#import "RedView.h"

@interface AppDelegate ()


- (void)addView:(NSView *)parentView ofColor:(NSString *)color;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

  BOOL build = NO;

  StackableView *stack;
  NSView *contentView = self.window.contentView;
  if (build) {
    stack = [[StackableView alloc] initWithFrame:NSZeroRect];
    [contentView addSubview:stack];

    NSDictionary *views = NSDictionaryOfVariableBindings(stack);
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[stack]-20-|" options:0 metrics:nil views:views];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[stack]-20-|" options:0 metrics:nil views:views];
    [contentView addConstraints:horizontalConstraints];
    [contentView addConstraints:verticalConstraints];
  } else {
    stack = self.stackableView;
  }

//  NSLog(@"Translates Auto Layout: %i", contentView.translatesAutoresizingMaskIntoConstraints);
//  NSLog(@"Constraints: %@", contentView.constraints);

  [self addView:stack ofColor:@"Red"];
  [self addView:stack ofColor:@"Blue"];
  [self addView:stack ofColor:@"Red"];
  [self addView:stack ofColor:@"Green"];
  
//  StackableView *stack1 = [[StackableView alloc] initWithFrame:NSZeroRect];
//  [self addView:stack1 ofColor:@"Red"];
//  [self addView:stack1 ofColor:@"Green"];
//  [stack addSubview:stack1];

//  StackableView *stack2 = [[StackableView alloc] initWithFrame:NSZeroRect];
//  [self addView:stack2 ofColor:@"Blue"];
//  [self addView:stack2 ofColor:@"Red"];
//  [stack addSubview:stack2];

//  StackableView *stack3 = [[StackableView alloc] initWithFrame:NSZeroRect];
//  [self addView:stack3 ofColor:@"Red"];
//  [self addView:stack3 ofColor:@"Blue"];
//  [self addView:stack3 ofColor:@"Red"];
//  [stack addSubview:stack3];
}

- (IBAction)addView:(id)sender {
  [self addView:self.stackableView ofColor:@"Blue"];
}

- (void)addView:(NSView *)parentView ofColor:(NSString *)color {
  Class viewClass = NSClassFromString([NSString stringWithFormat:@"%@View", color, nil]);
  int height = 50 + arc4random_uniform(100);
  NSView *childView = [[viewClass alloc] initWithFrame:NSMakeRect(0, 0, 0, height)];
  [parentView addSubview:childView];
  [childView release];
}

@end