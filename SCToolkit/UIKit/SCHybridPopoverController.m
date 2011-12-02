//
//  SCHybridPopoverController.m
//  SCHybridPopover
//
//  Created by Vincent Wang on 12/1/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "SCHybridPopoverController.h"
#import "INPopoverController.h"

#define IS_RUNNING_LION (floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_6)

@implementation SCHybridPopoverController

@synthesize popover = _popover;
@synthesize delegate = _delegate;

- (id)initWithContentViewController:(NSViewController *)viewController
{
    self = [super init];
    
    if (self) {
        if (IS_RUNNING_LION) {
            _popover = [[NSClassFromString(@"NSPopover") alloc] init];
            [_popover setContentViewController:viewController];
            [_popover setAppearance:NSPopoverAppearanceMinimal];
            [_popover setAnimates:YES];
            
            // AppKit will close the popover when the user interacts with a user interface element outside the popover.
            // note that interacting with menus or panels that become key only when needed will not cause a transient popover to close.
            [_popover setBehavior:NSPopoverBehaviorTransient];
            [_popover setDelegate:self];
        }
        else {
            _popover = [[INPopoverController alloc] initWithContentViewController:viewController];
            [_popover setClosesWhenPopoverResignsKey:YES];
            [_popover setClosesWhenApplicationBecomesInactive:YES];
            [_popover setDelegate:self];
        }
    }
    
    return self;
}

- (void)dealloc
{
    [_popover release], _popover = nil;
    _delegate = nil;
    [super dealloc];
}

- (void)openPopoverFromRect:(NSRect)rect ofView:(NSView *)positioningView preferredEdge:(NSRectEdge)edge
{
    if (IS_RUNNING_LION) {
        [_popover showRelativeToRect:[positioningView bounds] ofView:positioningView preferredEdge:edge];
    }
    else {
        if ([_popover popoverIsVisible]) return;
        [_popover presentPopoverFromRect:[positioningView bounds] 
                                 inView:positioningView preferredArrowDirection:edge anchorsToPositionView:YES];
    }
}

- (void)closePopover:(id)sender
{
    if (IS_RUNNING_LION) 
        [_popover performClose:sender];
    else
        [(INPopoverController *)_popover closePopover:sender];
}


#pragma mark - 
#pragma mark INPopoverControllerDelegate

/**
 When the -closePopover: method is invoked, this method is called to give a change for the delegate to prevent it from closing. Returning NO for this delegate method will prevent the popover being closed. This delegate method does not apply to the -forceClosePopover: method, which will close the popover regardless of what the delegate returns.
 @param popover the @class INPopoverController object that is controlling the popover
 @returns whether the popover should close or not
 */
- (BOOL)in_popoverShouldClose:(INPopoverController*)popover
{
    BOOL result = YES;
    if ([self.delegate respondsToSelector:@selector(sc_popoverShouldClose:)]) {
        result = [self.delegate sc_popoverShouldClose:popover];
    }
    return result;
}

/**
 Invoked right before the popover shows on screen
 @param popover the @class INPopoverController object that is controlling the popover
 */
- (void)in_popoverWillShow:(INPopoverController*)popover
{
    if ([self.delegate respondsToSelector:@selector(sc_popoverWillShow:)]) {
        [self.delegate sc_popoverWillShow:popover];
    }
}

/**
 Invoked right after the popover shows on screen
 @param popover the @class INPopoverController object that is controlling the popover
 */
- (void)in_popoverDidShow:(INPopoverController*)popover
{
    if ([self.delegate respondsToSelector:@selector(sc_popoverDidShow:)]) {
        [self.delegate sc_popoverDidShow:popover];
    }
}

/**
 Invoked right before the popover closes
 @param popover the @class INPopoverController object that is controlling the popover
 */
- (void)in_popoverWillClose:(INPopoverController*)popover
{
    if ([self.delegate respondsToSelector:@selector(sc_popoverWillClose:)]) {
        [self.delegate sc_popoverWillClose:popover];
    }
}

/**
 Invoked right before the popover closes
 @param popover the @class INPopoverController object that is controlling the popover
 */
- (void)in_popoverDidClose:(INPopoverController*)popover
{
    if ([self.delegate respondsToSelector:@selector(sc_popoverDidClose:)]) {
        [self.delegate sc_popoverDidClose:popover];
    }
}

#pragma mark - 
#pragma mark NSPopoverDelegate

/*  Returns YES if the popover should close, NO otherwise.  The popover invokes this method on its delegate whenever it is about to close to give the delegate a chance to veto the close.  If the delegate returns YES, -popoverShouldClose: will also be invoked on the popover to allow the popover to veto the close. 
 */
- (BOOL)popoverShouldClose:(NSPopover *)popover
{
    BOOL result = YES;
    if ([self.delegate respondsToSelector:@selector(sc_popoverShouldClose:)]) {
        result = [self.delegate sc_popoverShouldClose:popover];
    }
    return result;
}

// -------------------------------------------------------------------------------
// Invoked on the delegate when the NSPopoverWillShowNotification notification is sent.
// This method will also be invoked on the popover. 
// -------------------------------------------------------------------------------
- (void)popoverWillShow:(NSNotification *)notification
{
    id popover = [notification object];
    if ([self.delegate respondsToSelector:@selector(sc_popoverWillShow:)]) {
        // Either performSelector or performSelectorOnMainThread will cause Appkit crashed
//        [self.delegate performSelectorOnMainThread:@selector(sc_popoverWillShow) withObject:notification waitUntilDone:YES];
//        [self.delegate performSelector:@selector(sc_popoverDidShow) withObject:popover];
        [self.delegate sc_popoverWillShow:popover];
    }
}

// -------------------------------------------------------------------------------
// Invoked on the delegate when the NSPopoverDidShowNotification notification is sent.
// This method will also be invoked on the popover. 
// -------------------------------------------------------------------------------
- (void)popoverDidShow:(NSNotification *)notification
{
    id popover = [notification object];
    if ([self.delegate respondsToSelector:@selector(sc_popoverDidShow:)]) {
        [self.delegate sc_popoverDidShow:popover];
    }
}

// -------------------------------------------------------------------------------
// Invoked on the delegate when the NSPopoverWillCloseNotification notification is sent.
// This method will also be invoked on the popover. 
// -------------------------------------------------------------------------------
- (void)popoverWillClose:(NSNotification *)notification
{
    id popover = [notification object];
    if ([self.delegate respondsToSelector:@selector(sc_popoverWillClose:)]) {
        [self.delegate sc_popoverWillClose:popover];
    }
}

// -------------------------------------------------------------------------------
// Invoked on the delegate when the NSPopoverDidCloseNotification notification is sent.
// This method will also be invoked on the popover. 
// -------------------------------------------------------------------------------
- (void)popoverDidClose:(NSNotification *)notification
{
    id popover = [notification object];
    if ([self.delegate respondsToSelector:@selector(sc_popoverDidClose:)]) {
        [self.delegate sc_popoverDidClose:popover];
    }
}

// -------------------------------------------------------------------------------
// Invoked on the delegate asked for the detachable window for the popover.
// -------------------------------------------------------------------------------
- (NSWindow *)detachableWindowForPopover:(id)popover
{
    if (IS_RUNNING_LION) {
        if ([self.delegate respondsToSelector:@selector(sc_detachableWindowForPopover:)]) {
            NSWindow *window = [self.delegate sc_detachableWindowForPopover:popover];
            return window;
        }
    }
    
    return nil;
}


@end
