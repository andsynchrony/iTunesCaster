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

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveNotification:)
                                                     name:@"com.apple.iTunes.playerInfo"
                                                     object:nil];
    
    
    chromecli = [[Chromecli alloc] init];
}

- (void) receiveNotification:(NSNotification *) notification {
    NSDictionary *information = [notification userInfo];
    NSLog(@"track information: %@", information);

    NSString *trackname = [information objectForKey:@"Name"];
    NSString *artistname = [information objectForKey:@"Artist"];
    NSString *filename = [information objectForKey:@"Location"];
    NSString *playerstate = [information objectForKey:@"Player State"];
    
    NSString *jsFilename = [NSString stringWithFormat:@"document.getElementById(\"player\").innerHTML='<audio id=\"media-player\" controls autoplay name=\"media\"><source src=\"%@\" type=\"audio/mp3\"></audio>';", filename];
    if ([playerstate rangeOfString:@"Paused"].location != NSNotFound) {
        jsFilename = @"var audio=document.getElementById(\"media-player\"); audio.pause();";
    }

    NSString *jsTrackname = [NSString stringWithFormat:@"document.getElementById(\"trackName\").innerHTML=\"%@\";", trackname];
    NSString *jsArtistName = [NSString stringWithFormat:@"document.getElementById(\"artistName\").innerHTML=\"%@\";", artistname];

    
    NSString *javascript = [NSString stringWithFormat:@"%@ %@ %@", jsTrackname, jsArtistName, jsFilename];
    [chromecli executeNSJavascriptInActiveTab: javascript];

}


@end
