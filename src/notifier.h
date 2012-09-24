// -*- mode: objc; -*-
#import <Foundation/Foundation.h>

@interface RudeNotificationApp : NSObject <NSUserNotificationCenterDelegate>
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
