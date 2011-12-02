//
//  SCHybridPopoverController.h
//  SCHybridPopover
//
//  Created by Vincent Wang on 12/1/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INPopoverController; // For Snow Leopard or Leopard
@class NSPopover; // For Lion

@interface SCHybridPopoverController : NSObject {
    id _popover;
    id _delegate;
}

@property(readonly) id popover;
@property(nonatomic, assign) id delegate;

- (id)initWithContentViewController:(NSViewController *)viewController;
- (void)openPopoverFromRect:(NSRect)rect ofView:(NSView *)positioningView preferredEdge:(NSRectEdge)edge;
- (void)closePopover:(id)sender;

@end

@protocol SCHybridPopoverDelegate <NSObject>

- (BOOL)sc_popoverShouldClose:(id)popover;
- (void)sc_popoverWillShow:(id)popover;
- (void)sc_popoverDidShow:(id)popover;
- (void)sc_popoverWillClose:(id)popover;
- (void)sc_popoverDidClose:(id)popover;
- (NSWindow *)sc_detachableWindowForPopover:(id)popover; // Lion only (NSPopover)

@end