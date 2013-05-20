//
//  StackableView.h
//  Logline
//
//  Created by Flip Sasser on 3/5/13.
//  Copyright (c) 2013 Parker Wallace Company. All rights reserved.
//

// StackableView allows you to add subviews to it, which are sized to be the width
// of the StackableView, which then expands itself as-needed for each subview added.

// It basically emulates an HTML document's ability to push the drawing origin down
// the page by each element that is drawn into it.

#import <Cocoa/Cocoa.h>

@interface StackableView : NSView

@end
