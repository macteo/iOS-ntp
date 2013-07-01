/*╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
  ║ ntpAAppDelegate.m                                                                                ║
  ║                                                                                                  ║
  ║ Created by Gavin Eadie on Nov16/10                                                               ║
  ║ Copyright © 2010 Ramsay Consulting. All rights reserved.                                         ║
  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝*/

#import "ntpAAppDelegate.h"
#import "NetworkClock.h"

@implementation ntpAAppDelegate

- (BOOL) application:(UIApplication *) app didFinishLaunchingWithOptions:(NSDictionary *) options {

    [NetworkClock sharedInstance];                          // gather up the ntp servers ...

    [_window makeKeyAndVisible];
/*┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
  │  Create a timer that will fire in ten seconds and then every ten seconds thereafter to ask the   │
  │ network clock what time it is.                                                                   │
  └──────────────────────────────────────────────────────────────────────────────────────────────────┘*/
    
    networkTime = [[NetworkClock sharedInstance] networkTime];
    
    if ((int)round([networkTime timeIntervalSince1970]) % 2 == 0) {
        red = YES;
    } else {
        red = NO;
    }

    float time = 1 - ([networkTime timeIntervalSince1970] - floor([networkTime timeIntervalSince1970]));
    [self performSelector:@selector(changeBackground) withObject:nil afterDelay:time];
    
    return YES;
}

- (void)changeBackground{
    networkTime = [[NetworkClock sharedInstance] networkTime];
    systemTime = [NSDate date];
    
    sysClockLabel.text = [NSString stringWithFormat:@"%f", [systemTime timeIntervalSince1970]];
    netClockLabel.text = [NSString stringWithFormat:@"%f", [networkTime timeIntervalSince1970]];
    differenceLabel.text = [NSString stringWithFormat:@"%5.3f",
                            [networkTime timeIntervalSinceDate:systemTime]];

    float time = 1 - ([networkTime timeIntervalSince1970] - floor([networkTime timeIntervalSince1970]));

    [self performSelector:@selector(changeBackground) withObject:nil afterDelay:time];
    
    if ((int)round([networkTime timeIntervalSince1970]) % 2 == 0) {
        red = YES;
    } else {
        red = NO;
    }

    if (red) {
        self.window.backgroundColor = [UIColor greenColor];
        red = NO;
    } else {
        self.window.backgroundColor = [UIColor redColor];
        red = YES;
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {

    [[NetworkClock sharedInstance] finishAssociations];     // be nice and let all the servers go ...
}

@end