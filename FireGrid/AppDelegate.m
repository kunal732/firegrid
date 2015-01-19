//
//  AppDelegate.m
//  FireGrid
//
//  Created by Kunal Batra on 12/30/14.
//  Copyright (c) 2014 SendGrid Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <Firebase/Firebase.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) NSMenu *theMenu;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
   
    
    
    //Initialize the Status bar app with SendGrid Image and Tool tip
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    _statusItem.image = [NSImage imageNamed:@"sendgrid.png"];
    [_statusItem setToolTip:@"SendGrid Event feed"];
    
    //Initialize the menu
    self.theMenu = [NSMenu alloc];
    [_theMenu setAutoenablesItems:NO];
    NSMenuItem *tItem = nil;
    [_theMenu addItemWithTitle:@"SendGrid Email Activity:" action:nil keyEquivalent:@""];
    [_theMenu addItemWithTitle:@"" action:nil keyEquivalent:@""];
    
    
    //Hook up menu with Status bar app
    [tItem setKeyEquivalentModifierMask:NSCommandKeyMask];
    [_statusItem setMenu:_theMenu];
    
    //Add a new menu item for every child added.
    Firebase *ref2 = [[Firebase alloc] initWithUrl: @"Your_Firebasę_URL"];
    [[ref2 queryLimitedToLast:20] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        //Create string
        NSDate *tstamp2 = [[NSDate alloc] initWithTimeIntervalSince1970:[snapshot.value[@"timestamp"] intValue]];
        NSString *menuitem = [NSString stringWithFormat:@" %@ %@ at %@",snapshot.value[@"email"], snapshot.value[@"event"], tstamp2 ];
        
        //Create menu item from string
        [_theMenu addItemWithTitle:menuitem action:nil keyEquivalent:@""];
        [_theMenu addItem:[NSMenuItem separatorItem]];
        
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];

    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



@end
