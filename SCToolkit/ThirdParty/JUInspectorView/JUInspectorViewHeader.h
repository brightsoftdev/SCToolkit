//
//  JUInspectorView.h
//  JUInspectorView
//
//  Copyright (c) 2011 by Sidney Just
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
//  the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
//  and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
//  PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
//  FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Cocoa/Cocoa.h>
#import "JUInspectorBaseView.h"

@class JUInspectorViewHeader;

@protocol JUInspectorViewHeaderDelegate

-(void)headerClicked:(JUInspectorViewHeader *)headerView;

@end

@interface JUInspectorViewHeader : JUInspectorBaseView
{    
    id<JUInspectorViewHeaderDelegate> delegate;
    
    NSButton *disclosureTriangle;
    NSTextField *nameField;
    
    NSColor *dashColor;
    NSColor *gradientStartColor;
    NSColor *gradientEndColor;
    
    NSInteger state;
    NSString *title;
}

@property (assign, nonatomic) id<JUInspectorViewHeaderDelegate> delegate;

@property (readonly) NSButton *disclosureTriangle;

@property (retain, nonatomic) NSColor *dashColor;
@property (retain, nonatomic) NSColor *gradientStartColor;
@property (retain, nonatomic) NSColor *gradientEndColor;

@property (assign, nonatomic) NSInteger state;
@property (assign, nonatomic) NSString *title;

@end
