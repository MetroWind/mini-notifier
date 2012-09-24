#import "main.h"

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

RudeNotificationApp* initApp(int argc, char** argv)
{
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
                usage(argv[0]);
                exit(0);
        }
    }

    argc -= optind;
    argv += optind;

    if(argc > 0)
    {
        NSArray* Args = [[NSProcessInfo processInfo] arguments];
        NSRange Range;
        Range.location = (NSUInteger)(optind);
        Range.length = [Args count] - (unsigned long)(optind);
        NSArray* ContentSplitted = [Args subarrayWithRange: Range];
        Content = [ContentSplitted componentsJoinedByString: @" "];
    }
    
    RudeNotificationApp* Notifier = [RudeNotificationApp new];
    [Notifier setTitle: Title];
    [Notifier setSubtitle: Subtitle];
    [Notifier setContent: Content];
    [Notifier setSoundFName: SoundFName];
    [Notifier setWillDelete: Delete];

    return Notifier;
}


int main (int argc, char** argv)
{
    NSAutoreleasePool* Pool = [[NSAutoreleasePool alloc] init];
    NSBundle *bundle = [NSBundle mainBundle];
    id version = [bundle objectForInfoDictionaryKey: (NSString*) kCFBundleVersionKey];
    NSLog(@"Notifier v%@", version);

    RudeNotificationApp* Notifier = initApp(argc, argv);
    [Notifier notify];
    NSRunLoop *RunLoop = [NSRunLoop currentRunLoop];
    [RunLoop run];

    [Pool drain];
	return 0;
}
