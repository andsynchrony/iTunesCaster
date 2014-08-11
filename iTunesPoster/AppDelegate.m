//
//  AppDelegate.m
//  iTunesPoster
//
//  Created by Stefan Wagner on 04.05.14.
//  Copyright (c) 2014 Stefan Wagner. All rights reserved.
//

#import "AppDelegate.h"
#import "Chromecli.h"
#import "Arguments.h"
#import "iTunes.h"
#import "NSStrinAdditions.h"

@implementation AppDelegate

Chromecli *chromecli;
NSInteger tabid;
iTunesApplication *iTunes;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveNotification:)
                                                     name:@"com.apple.iTunes.playerInfo"
                                                     object:nil];
    
    iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];

    chromecli = [[Chromecli alloc] init];
    tabid = [chromecli getTab: @"file:///Users/andsynchrony/Documents/Code/xcode/iTunesPoster/iTunesViewer/iTunesViewer.html"];
}

- (void) receiveNotification:(NSNotification *) notification {
    NSDictionary *information = [notification userInfo];
    
	iTunesTrack *theCurrentTrack = [iTunes currentTrack];
	iTunesArtwork *artwork = (iTunesArtwork *)[[[theCurrentTrack artworks] get] lastObject];
    NSData * data = artwork.rawData;
    NSString *str = [NSString base64StringFromData:data length:[data length]];
    
    NSString *trackname = [information objectForKey:@"Name"];
    NSString *artistname = [information objectForKey:@"Artist"];
    NSString *filename = [information objectForKey:@"Location"];
    NSString *playerstate = [information objectForKey:@"Player State"];
    
    NSString *javascript = [NSString stringWithFormat:@"setFile(\"%@\", \"%@\", \"%@\"); setArtwork(\"%@\");", filename, artistname, trackname, str];

    if ([playerstate rangeOfString:@"Paused"].location != NSNotFound) {
        javascript = @"pause()";
    }

    [chromecli executeNSJavascriptInTab: tabid: javascript];

}



@end
