//
//  AppDelegate.h
//  Whatever
//
//  Created by Flip Sasser on 3/7/13.
//  Copyright (c) 2013 Logline. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class StackableView;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet StackableView *stackableView;

- (IBAction)addView:(id)sender;

@end
