//
//  ntpAAppDelegate.h
//  ntpA
//
//  Created by Gavin Eadie on 10/16/10.
//  Copyright (c) 2010 Ramsay Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ntpAViewController;

@interface ntpAAppDelegate : NSObject <UIApplicationDelegate> {
    
    NSDate *                        systemTime;
    NSDate *                        networkTime;
    
    IBOutlet UILabel *              sysClockLabel;
    IBOutlet UILabel *              netClockLabel;
    IBOutlet UILabel *              differenceLabel;
    BOOL red;
}

@property (nonatomic, strong) IBOutlet UIWindow *           window;
@property (nonatomic, strong) IBOutlet ntpAViewController * viewController;

@end
