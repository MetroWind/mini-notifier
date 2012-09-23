#import "notifier.h"

@implementation RudeNotificationApp

- (BOOL)userNotificationCenter: (NSUserNotificationCenter*) center
     shouldPresentNotification: (NSUserNotification*) notification
{
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

- (void)userNotificationCenter: (NSUserNotificationCenter*) center
        didDeliverNotification: (NSUserNotification*) notification
    __attribute__((__noreturn__))
{
    NSLog(@"Notification delivered.");
    [center removeDeliveredNotification: notification];
    NSLog(@"Notification removed.");    
    exit(0);
}
@end
