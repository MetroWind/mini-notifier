#import <Foundation/Foundation.h>
#import "notifier.h"

int main (int argc, char** argv)
{
    NSAutoreleasePool* Pool = [[NSAutoreleasePool alloc] init];
    NSBundle *bundle = [NSBundle mainBundle];
    id version = [bundle objectForInfoDictionaryKey: (NSString*) kCFBundleVersionKey];
    NSLog(@"Notifier v%@", version);
    
    RudeNotificationApp* AppDele = [RudeNotificationApp new];

    NSUserNotification* Notice = [NSUserNotification new];
    
    [Notice setTitle: @"My Title"];
    [Notice setInformativeText: @"My Text"];
    // [Notice setDeliveryDate: [NSDate date]];
    // [Notice setSoundName:NSUserNotificationDefaultSoundName];

    NSUserNotificationCenter* Center = [NSUserNotificationCenter defaultUserNotificationCenter];
    Center.delegate = AppDele;
    [Center scheduleNotification: Notice];

    NSRunLoop *RunLoop = [NSRunLoop currentRunLoop];
    [RunLoop run];

    [Pool drain];
	return 0;
}
