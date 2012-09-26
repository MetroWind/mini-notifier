// -*- mode: objc; -*-
//  
//  AppDelegate.h
//  Mini Notifier
//
//  Created by Corsair Sun on 9/26/12.
//  Copyright (c) 2012 Darksair. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <getopt.h>
#import "UserNotifier.h"

void usage(char* program_name);
UserNotifier* initApp();

@interface AppDelegate : NSObject <NSApplicationDelegate>

@end
