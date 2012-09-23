#import "notifier.h"

@implementation RudeNotificationApp
- (void)applicationDidFinishLaunching: (NSNotification*) notification
{
    NSLog(@"Hello world!");

    NSUserNotification* Notice = [NSUserNotification new];
    
    [Notice setTitle: @"My Title"];
    [Notice setInformativeText: @"My Text"];
    // [Notice setDeliveryDate: [NSDate date]];
    // [Notice setSoundName:NSUserNotificationDefaultSoundName];

    NSUserNotificationCenter* Center = [NSUserNotificationCenter defaultUserNotificationCenter];
    Center.delegate = self;
    [Center scheduleNotification: Notice];
}

- (BOOL)userNotificationCenter: (NSUserNotificationCenter*) center
     shouldPresentNotification: (NSUserNotification*) notification
{
    NSLog(@"RudeNotificationDelegate used.");
    return YES;
}

- (void)userNotificationCenter: (NSUserNotificationCenter*) center
       didActivateNotification: (NSUserNotification*) notification
    __attribute__((__noreturn__))
{
    [center removeDeliveredNotification: notification];
    NSLog(@"Clicked!");
    exit(0);
}

- (void)userNotificationCenter:(NSUserNotificationCenter*) center
        didDeliverNotification:(NSUserNotification*) userNotification
    __attribute__((__noreturn__))
{
  NSLog(@"Notification delivered.");
  exit(0);
}
@end
