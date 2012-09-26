// -*- mode: objc; -*-
//  
//  UserNotifier.h
//  Mini Notifier
//
//  Created by Corsair Sun on 9/26/12.
//  Copyright (c) 2012 Darksair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserNotifier : NSObject <NSUserNotificationCenterDelegate>
@property (atomic, assign) NSString* Title;
@property (atomic, assign) NSString* Subtitle;
@property (atomic, assign) NSString* Content;
@property (atomic, assign) NSString* SoundFName;
@property (atomic, assign) bool WillDelete;

- (void)notify;
- (void)notifyWithTitle: (NSString*)title subtitle: (NSString*)subtitle
                content: (NSString*)content;
- (void)notifyWithTitle: (NSString*)title subtitle: (NSString*)subtitle
                content: (NSString*)content sound: (NSString*)sound;
@end
