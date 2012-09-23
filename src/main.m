#import <Cocoa/Cocoa.h>
#import "notifier.h"

int main (int argc, char** argv)
{
    NSAutoreleasePool* Pool = [[NSAutoreleasePool alloc] init];
    NSBundle *bundle = [NSBundle mainBundle];
    id version = [bundle objectForInfoDictionaryKey: (NSString*) kCFBundleVersionKey];
    NSLog(@"mainBundle.version = %@", version);
    
    RudeNotificationApp* AppDele = [RudeNotificationApp new];
    NSApplication* App = [NSApplication sharedApplication];
    [App setDelegate: AppDele];
    [NSApp run];

    [Pool drain];
	return 0;
}
