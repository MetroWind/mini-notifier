//
//  AppDelegate.m
//  Mini Notifier
//
//  Created by Corsair Sun on 9/26/12.
//  Copyright (c) 2012 Darksair. All rights reserved.
//

#import "AppDelegate.h"

void usage(char* program_name)
{
    fprintf(stderr, "Usage: %s [OPTIONS] [CONTENT]\n"
            "\n"
            "Display a notification in the notification center with CONTENT.\n"
            "\n"
            "Options:\n"
            "   --title,-t TEXT    Set title of notification.\n"
            "--subtitle,-s TEXT    Set subtitle of notification.\n"
            "   --sound,-S FILE    Not implemented yet.\n"
            "       --delete,-d    Delete the notification in the notification center after posting it.\n"
            "         --help,-h    Display what you are looking at.\n"
            , program_name);
    return;
}

UserNotifier* initApp()
// This is ugly.  I hope I know a better way to process the command
// line arguments.  Also if you run the prgram by double-clicking it,
// OS X add some crappy argument to it.  I need a way to remove those.
{
    NSLog(@"Dealing with commandline arguments...");
    NSArray* Args = [[NSProcessInfo processInfo] arguments];
    int argc = (int)([Args count]);
    char** argv = malloc(argc * sizeof(char*));

    for(int i = 0; i < argc; i++)
    {
        NSLog(@"Arguments: %@", Args[i]);
        argv[i] = (char*)([Args[i] UTF8String]);
    }
    
    static struct option LongOptions[] = {
        { "title", required_argument, 0, 't' },
        { "subtitle", required_argument, 0, 's' },
        { "sound", required_argument, 0, 'S' },
        { "delete", no_argument, 0, 'd' },
        { "help", no_argument, 0, 'h' },
        { 0, 0, 0, 0 }
    };

    bool Delete = NO;
    int OptChar = 0;
    NSString* Title = @"Notifier";
    NSString* Subtitle = 0;
    NSString* Content = 0;
    NSString* SoundFName = 0;

    while((OptChar = getopt_long(argc, argv, "t:s:S:dh", LongOptions, 0)) != -1)
    {
        switch((char)(OptChar))
        {
            case 't':
                Title = [NSString stringWithCString: optarg
                                           encoding: NSUTF8StringEncoding];
                break;
            case 's':
                Subtitle = [NSString stringWithCString: optarg
                                              encoding: NSUTF8StringEncoding];
                break;
            case 'S':
                SoundFName = [NSString stringWithCString: optarg
                                                encoding: NSUTF8StringEncoding];
                break;
            case 'd':
                Delete = YES;
                break;
            case 'h':
                usage(argv[0]);
                exit(0);
            default:
                break;
        }
    }

    argc -= optind;
    argv += optind;

    if(argc > 0)
    {
        NSRange Range;
        Range.location = (NSUInteger)(optind);
        Range.length = [Args count] - (unsigned long)(optind);
        NSArray* ContentSplitted = [Args subarrayWithRange: Range];
        Content = [ContentSplitted componentsJoinedByString: @" "];
    }
    
    NSLog(@"Creating notifier...");
    UserNotifier* Notifier = [[UserNotifier alloc] init];
    [Notifier setTitle: Title];
    [Notifier setSubtitle: Subtitle];
    [Notifier setContent: Content];
    [Notifier setSoundFName: SoundFName];
    [Notifier setWillDelete: Delete];

    // I miss C++...
    // 
    // free(argv);
    // argv = 0;
    return Notifier;
}

@implementation AppDelegate
{
    UserNotifier* Notifier;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"App loaded.");
    Notifier = initApp();
    [Notifier notify];
}

@end
