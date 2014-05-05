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

Chromecli *chromecli;
NSInteger tabid;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveNotification:)
                                                     name:@"com.apple.iTunes.playerInfo"
                                                     object:nil];
    
    chromecli = [[Chromecli alloc] init];
    
    tabid = [chromecli openNSUrlInNewTab: @"file:///Users/andsynchrony/Documents/Code/xcode/iTunesPoster/iTunesViewer/iTunesViewer.html"];
}

- (void) receiveNotification:(NSNotification *) notification {
    NSDictionary *information = [notification userInfo];
    NSLog(@"track information: %@", information);

    NSString *trackname = [information objectForKey:@"Name"];
    NSString *artistname = [information objectForKey:@"Artist"];
    NSString *filename = [information objectForKey:@"Location"];
    NSString *playerstate = [information objectForKey:@"Player State"];
    
    NSString *javascript = [NSString stringWithFormat:@"setFile(\"%@\", \"%@\", \"%@\")", filename, artistname, trackname];

    if ([playerstate rangeOfString:@"Paused"].location != NSNotFound) {
        javascript = @"pause()";
    }

    [chromecli executeNSJavascriptInTab: tabid: javascript];

}


@end
