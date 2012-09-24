#import "notifier.h"

@implementation RudeNotificationApp
{
    NSUserNotificationCenter* Center;
}

@synthesize Title, Subtitle, Content, SoundFName, WillDelete;

- (id) init
{
    self = [super init];
    if(self)
    {
        Center = [NSUserNotificationCenter defaultUserNotificationCenter];
        Center.delegate = self;
    }

    return self;
}

- (void)notify
{
    if(SoundFName)
    {
        [self notifyWithTitle: self.Title subtitle: self.Subtitle
                      content: self.Content sound: self.SoundFName];
    }
    else
    {
        [self notifyWithTitle: self.Title subtitle: self.Subtitle
                      content: self.Content];
    }
}

- (void)notifyWithTitle: (NSString*)title subtitle: (NSString*)subtitle
                content: (NSString*)content
{
    [self notifyWithTitle: title subtitle: subtitle
                  content: content sound: NSUserNotificationDefaultSoundName];
}

- (void)notifyWithTitle: (NSString*)title subtitle: (NSString*)subtitle
                content: (NSString*)content sound: (NSString*)sound
{
    NSUserNotification* Notice = [NSUserNotification new];
    
    [Notice setTitle: title];
    [Notice setSubtitle: subtitle];
    [Notice setInformativeText: content];
    // [Notice setDeliveryDate: [NSDate date]];
    [Notice setSoundName: sound];
    
    [Center scheduleNotification: Notice];
}

- (BOOL)userNotificationCenter: (NSUserNotificationCenter*) center
     shouldPresentNotification: (NSUserNotification*) notification
{
    return YES;
}

// Doesn't work...
- (void)userNotificationCenter: (NSUserNotificationCenter*) center
       didActivateNotification: (NSUserNotification*) notification
    __attribute__((__noreturn__))
{
    [center removeDeliveredNotification: notification];
    NSLog(@"Notification clicked!");
    exit(0);
}

- (void)userNotificationCenter: (NSUserNotificationCenter*) center
        didDeliverNotification: (NSUserNotification*) notification
    __attribute__((__noreturn__))
{
    NSLog(@"Notification delivered.");
    if(self.WillDelete)
    {
        [center removeDeliveredNotification: notification];
        NSLog(@"Notification removed.");
    }
    
    exit(0);
}
@end
