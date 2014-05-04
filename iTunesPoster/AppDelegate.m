//
//  AppDelegate.m
//  iTunesPoster
//
//  Created by Stefan Wagner on 04.05.14.
//  Copyright (c) 2014 Stefan Wagner. All rights reserved.
//

#import "AppDelegate.h"
#import "Chromecli.h"

@implementation AppDelegate

Chromecli *app;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSLog (@"hello objective c world.");

    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveNotification:)
                                                     name:@"com.apple.iTunes.playerInfo"
                                                     object:nil];
    
    
    app = [[Chromecli alloc] init];
}

- (void) receiveNotification:(NSNotification *) notification {
    NSDictionary *information = [notification userInfo];
    NSLog(@"track information: %@", information);

    NSString *trackname = [information objectForKey:@"name"];
    NSString *javascript = @"document.getElementById(\"name\").innerHTML=\"skfjshfdskj\"";
    [app executeNSJavascriptInActiveTab: javascript];

}


@end
