//
//  AppDelegate.m
//  FireGrid
//
//  Created by Kunal Batra on 12/30/14.
//  Copyright (c) 2014 SendGrid. All rights reserved.
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
   
    
    // Get a reference to our posts
    Firebase *ref = [[Firebase alloc] initWithUrl: @"your_firebase_url"];
    
    
    //Initialize the Status bar app with Image and Tool tip
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    _statusItem.image = [NSImage imageNamed:@"sendgrid.png"];
    [_statusItem setToolTip:@"SendGrid Event feed"];
    
    
    self.theMenu = [[NSMenu alloc] initWithTitle:@"First"];
    [_theMenu setAutoenablesItems:NO];
    
    NSMenuItem *tItem = nil;
    [_theMenu addItemWithTitle:@"SendGrid Email Activity:" action:nil keyEquivalent:@""];
    [_theMenu addItemWithTitle:@"" action:nil keyEquivalent:@""];
    
    
    
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        //for every child in the snapshod we create a menu item
        for (FDataSnapshot *child in snapshot.children) {
          
            NSDate *tstamp2 = [[NSDate alloc] initWithTimeIntervalSince1970:[snapshot.value[child.key][@"timestamp"] intValue]];
            NSString *menuitem = [NSString stringWithFormat:@" %@ %@ed at %@",snapshot.value[child.key][@"email"], snapshot.value[child.key][@"event"], tstamp2 ];
            [_theMenu addItemWithTitle:menuitem action:nil keyEquivalent:@""];
            [_theMenu addItem:[NSMenuItem separatorItem]];
        }
        
        
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
    
    
  
    [tItem setKeyEquivalentModifierMask:NSCommandKeyMask];
    
    

    [_statusItem setMenu:_theMenu];


    
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



@end
